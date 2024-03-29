#' Tidy Stats of Tidy Distribution
#'
#' @family Statistic
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the value(s) of a given `tidy_` distribution function
#' output and chosen column from it. This function will only work with `tidy_`
#' distribution functions.
#'
#' There are currently three different output types for this function. These are:
#' *  "vector" - which gives an `sapply()` output
#' *  "list" - which gives an `lapply()` output, and
#' *  "tibble" - which returns a `tibble` in long format.
#'
#' Currently you can pass any stat function that performs an operation on a vector
#' input. This means you can pass things like `IQR`, `quantile` and their associated
#' arguments in the `...` portion of the function.
#'
#' This function also by default will rename the value column of the `tibble` to
#' the name of the function. This function will also give the column name of sim_number
#' for the `tibble` output with the corresponding simulation numbers as the values.
#'
#' For the `sapply` and `lapply` outputs the column names will also give the
#' simulation number information by making column names like `sim_number_1` etc.
#'
#' There is an option of `.use_data_table` which can greatly enhance the speed of
#' the calculations performed if used while still returning a `tibble`. The calculations
#' are performed after turning the input data into a `data.table` object, performing
#' the necessary calculation and then converting back to a `tibble` object.
#'
#'
#' @description
#' A function to return the `stat` function values of a given `tidy_` distribution
#' output.
#'
#' @param .data The input data coming from a `tidy_` distribution function.
#' @param .x The default is `y` but can be one of the other columns from the
#' input data.
#' @param .fns The default is `IQR`, but this can be any `stat` function like
#' `quantile` or `median` etc.
#' @param .return_type The default is "vector" which returns an `sapply` object.
#' @param .use_data_table The default is FALSE, TRUE will use data.table under the
#' hood and still return a tibble. If this argument is set to TRUE then the
#' `.return_type` parameter will be ignored.
#' @param ... Addition function arguments to be supplied to the parameters of
#' `.fns`
#'
#' @examples
#' tn <- tidy_normal(.num_sims = 3)
#'
#' p <- c(0.025, 0.25, 0.5, 0.75, 0.95)
#'
#' tidy_stat_tbl(tn, y, quantile, "vector", probs = p, na.rm = TRUE)
#' tidy_stat_tbl(tn, y, quantile, "list", probs = p)
#' tidy_stat_tbl(tn, y, quantile, "tibble", probs = p)
#' tidy_stat_tbl(tn, y, quantile, .use_data_table = TRUE, probs = p, na.rm = TRUE)
#'
#' @return
#' A return of object of either `sapply` `lapply` or `tibble` based upon user input.
#'
#' @export
#'
#' @importFrom data.table .SD
#' @importFrom data.table melt
#' @importFrom data.table as.data.table

tidy_stat_tbl <- function(.data, .x = y, .fns, .return_type = "vector",
                          .use_data_table = FALSE, ...) {
  atb <- attributes(.data)

  # Tidyeval ----
  value_var_expr <- rlang::enquo(.x)
  func <- .fns
  func_chr <- deparse(substitute(.fns))
  passed_args <- list(...)
  return_type <- tolower(as.character(.return_type))
  .datatable.aware <- TRUE

  # Checks ----
  if (!return_type %in% c("vector", "list", "tibble", "data.frame")) {
    rlang::abort(
      message = "'.return_type' must be either 'vector','list', or 'tibble'",
      use_cli_format = TRUE
    )
  }

  if (!"tibble_type" %in% names(atb)) {
    rlang::abort(
      message = "'.data' must come from a 'tidy_' distribution function.",
      use_cli_format = TRUE
    )
  }

  if (rlang::quo_is_missing(value_var_expr)) {
    rlang::abort(
      message = "'.x' must be a column from the data.frame/tibble passed to '.data'."
    )
  }

  # Prep tibble ----
  # First is .use_data_table TRUE? If so then execute and forget the rest
  if (.use_data_table) {
    .x <- deparse(substitute(.x))

    # # Benchmark ran 25 at 15.13 seconds
    # # Thank you Akrun https://stackoverflow.com/questions/73938515/keep-names-from-quantile-function-when-used-in-a-data-table/73938561#73938561
    if (atb$tibble_type == "tidy_bootstrap_nested") {
        dt <- dplyr::as_tibble(.data) |>
            TidyDensity::bootstrap_unnest_tbl() |>
            dplyr::select(sim_number, {{ value_var_expr }}) |>
            data.table::as.data.table()
    } else {
        dt <- dplyr::as_tibble(.data) |>
            dplyr::select(sim_number, {{ value_var_expr }}) |>
            data.table::as.data.table()
    }

    # names(dt) <- c("sim_number","y")

    ret <- data.table::melt(
      dt[, as.list(func(.SD[[1]], ...)), by = sim_number, .SDcols = .x],
      id.var = "sim_number",
      value.name = func_chr
    ) |>
      dplyr::as_tibble() |>
      dplyr::arrange(sim_number, variable) |>
      dplyr::rename(name = variable)

    return(ret)
  }

  # Check to see if it is a bootstrap tibble first
  # Is it a Bootstrap Nested tibble?
  if (atb$tibble_type == "tidy_bootstrap_nested") {
    df_tbl <- dplyr::as_tibble(.data) |>
      TidyDensity::bootstrap_unnest_tbl()
    df_tbl <- base::split(df_tbl, df_tbl$sim_number) |>
      purrr::map(\(x) x |> dplyr::pull(y))
  }

  # Is it an unnested bootstrap tibble?
  if (atb$tibble_type == "tidy_bootstrap") {
    df_tbl <- dplyr::as_tibble(.data)
    df_tbl <- base::split(df_tbl, df_tbl$sim_number) |>
      purrr::map(\(x) x |> dplyr::pull(y))
  }

  # If regular tidy_ dist tibble ----
  if (!atb$tibble_type %in% c("tidy_bootstrap", "tidy_bootstrap_nested")) {
    df_tbl <- dplyr::as_tibble(.data)
    df_tbl <- base::split(df_tbl, df_tbl$sim_number) |>
      purrr::map(\(x) x |> dplyr::pull({{ value_var_expr }}))
  }

  # New Param Args ----
  if ("na.rm" %in% names(passed_args)) {
    tmp_args <- passed_args[!names(passed_args) == "na.rm"]
  }

  if (!exists("tmp_args")) {
    args <- passed_args
  } else if (exists("tmp_args")) {
    args <- tmp_args
  } else {
    args <- NULL
  }

  # If length of args = 0 then NULL
  if (length(args) == 0) args <- NULL

  # Run func ----
  if (return_type == "vector") {
    ret <- sapply(df_tbl, func, ...)
    if (is.null(colnames(ret))) {
      cn <- names(ret)
    } else {
      cn <- colnames(ret)
    }
    #cn <- stringr::str_c("sim_number_", cn)
    cn <- paste0("sim_number_", cn)

    if (is.null(colnames(ret))) {
      names(ret) <- cn
    } else {
      colnames(ret) <- cn
    }
  }

  if (return_type == "list") {
    ret <- lapply(df_tbl, func, ...)
    ln <- names(ret)
    #cn <- stringr::str_c("sim_number_", ln)
    cn <- paste0("sim_number_", ln)
    names(ret) <- cn
  }

  # Another fix
  # https://stackoverflow.com/questions/73989631/passing-a-function-and-arguments-to-a-function-and-purrr
  if (return_type == "tibble") {
    # Benchmark ran 25 at 73 seconds
    ret <- purrr::map(
      df_tbl, ~ if (is.null(args)) func(.x) else func(.x, unlist(args))
    )

    if (is.null(args)) {
      ret <- ret |>
        purrr::map(~ cbind(.x, name = names(.x))) |>
        purrr::imap(~ cbind(.x, sim_number = .y)) |>
        purrr::map_df(dplyr::as_tibble) |>
        dplyr::select(sim_number, .x, dplyr::everything()) |>
        dplyr::mutate(.x = as.numeric(.x)) |>
        dplyr::mutate(sim_number = factor(sim_number)) |>
        dplyr::rename(value = .x)
    } else {
      ret <- ret |>
        purrr::map(~ cbind(.x, name = names(.x))) |>
        purrr::imap(.f = ~ cbind(.x, sim_number = .y)) |>
        purrr::map_df(dplyr::as_tibble) |>
        dplyr::select(sim_number, .x, dplyr::everything()) |>
        dplyr::mutate(.x = as.numeric(.x)) |>
        dplyr::mutate(sim_number = factor(sim_number)) |>
        dplyr::rename(value = .x)
    }

    cn <- c("sim_number", func_chr, "name")
    if ("name" %in% names(ret)) {
      names(ret) <- cn
    } else {
      ret <- ret |>
        dplyr::mutate(name = 1)

      names(ret) <- cn
    }

    ret <- ret |> dplyr::select(sim_number, name, dplyr::everything())
  }

  # Return
  if (inherits(ret, "tibble") | inherits(ret, "data.table")) {
    attr(ret, "tibble_type") <- "tidy_stat_tbl"
    attr(ret, ".fns") <- deparse(substitute(.fns))
    attr(ret, "incoming_tibble_type") <- atb$tibble_type
    attr(ret, ".return_type") <- .return_type
    attr(ret, ".return_type_function") <- switch(return_type,
      "vector" = "sapply",
      "list" = "lapply",
      "tibble" = "purr_map"
    )
    attr(ret, "class") <- "tidy_stat_tbl"
  }

  return(ret)
}
