#' Tidy Randomly Generated Gamma Tibble
#'
#' @family Data Generator
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @seealso \url{https://www.statology.org/fit-gamma-distribution-to-dataset-in-r/}
#' @seealso \url{https://en.wikipedia.org/wiki/Gamma_distribution}
#'
#' @details This function uses the underlying `stats::rgamma()`, and its underlying
#' `p`, `d`, and `q` functions. For more information please see [stats::rgamma()]
#'
#' @description This function will generate `n` random points from a gamma
#' distribution with a user provided, `.shape`, `.rate`, and number of
#' random simulations to be produced. The function returns a tibble with the
#' simulation number column the x column which corresponds to the n randomly
#' generated points, the `d_`, `p_` and `q_` data points as well.
#'
#' The data is returned un-grouped.
#'
#' The columns that are output are:
#'
#' -  `sim_number` The current simulation number.
#' -  `x` The current value of `n` for the current simulation.
#' -  `y` The randomly generated data point.
#' -  `dx` The `x` value from the [stats::density()] function.
#' -  `dy` The `y` value from the [stats::density()] function.
#' -  `p` The values from the resulting p_ function of the distribution family.
#' -  `q` The values from the resulting q_ function of the distribution family.
#'
#' @param .n The number of randomly generated points you want.
#' @param .shape This is strictly 0 to infinity.
#' @param .rate The standard deviation of the randomly generated data. This is
#' strictly from 0 to infinity.
#' @param .num_sims The number of randomly generated simulations you want.
#'
#' @examples
#' tidy_gamma()
#'
#' @return
#' A tibble of randomly generated data.
#'
#' @export
#'

tidy_gamma <- function(.n = 50, .shape = 1, .rate = 1, .num_sims = 1){

    # Tidyeval ----
    n        <- as.integer(.n)
    num_sims <- as.integer(.num_sims)
    shp <- .shape
    rte <- .rate

    # Checks ----
    if(!is.integer(n) | n < 0){
        rlang::abort(
            "The parameters '.n' must be of class integer. Please pass a whole
            number like 50 or 100. It must be greater than 0."
        )
    }

    if(!is.integer(num_sims) | num_sims < 0){
        rlang::abort(
            "The parameter `.num_sims' must be of class integer. Please pass a
            whole number like 50 or 100. It must be greater than 0."
        )
    }

    if(!is.numeric(shp) | shp < 0){
        rlang::abort(
            "The parameters of '.shape' and '.rate' must be of class numeric.
            Please pass a numer like 1 or 1.1 etc. and must be greater than 0."
        )
    }

    if(!is.numeric(rte) | rte < 0){
        rlang::abort(
            "The parameters of '.shape' and '.rate' must be of class numeric.
            Please pass a numer like 1 or 1.1 etc."
        )
    }

    x <- seq(1, num_sims, 1)

    ps <- seq(-n, n-1, 2)
    qs <- seq(0, 1, (1/(n-1)))

    df <- dplyr::tibble(sim_number = as.factor(x)) %>%
        dplyr::group_by(sim_number) %>%
        dplyr::mutate(x = list(1:n)) %>%
        dplyr::mutate(y = list(stats::rgamma(n = n, shape = shp, rate = rte))) %>%
        dplyr::mutate(d = list(density(unlist(y), n = n)[c("x","y")] %>%
                                   purrr::set_names("dx","dy") %>%
                                   dplyr::as_tibble())) %>%
        dplyr::mutate(p = list(stats::pgamma(ps, shape = shp, rate = rte))) %>%
        dplyr::mutate(q = list(stats::qgamma(qs, shape = shp, rate = rte))) %>%
        tidyr::unnest(cols = c(x, y, d, p, q)) %>%
        dplyr::ungroup()


    # Attach descriptive attributes to tibble
    attr(df, ".shape") <- .shape
    attr(df, ".rate") <- .rate
    attr(df, ".n") <- .n
    attr(df, ".num_sims") <- .num_sims
    attr(df, "tibble_type") <- "tidy_gamma"
    attr(df, "ps") <- ps
    attr(df, "qs") <- qs

    # Return final result as function output
    return(df)

}