% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot-bootstrap-stat.R
\name{bootstrap_stat_plot}
\alias{bootstrap_stat_plot}
\title{Bootstrap Stat Plot}
\usage{
bootstrap_stat_plot(
  .data,
  .value,
  .stat = "cmean",
  .show_groups = FALSE,
  .show_ci_labels = TRUE,
  .interactive = FALSE
)
}
\arguments{
\item{.data}{The data that comes from either \code{tidy_bootstrap()} or after
\code{bootstrap_unnest_tbl()} is applied to it.}

\item{.value}{The value column that the calculations are being applied to.}

\item{.stat}{The cumulative statistic function being applied to the \code{.value}
column. It must be quoted. The default is "cmean".}

\item{.show_groups}{The default is FALSE, set to TRUE to get output of all
simulations of the bootstrap data.}

\item{.show_ci_labels}{The default is TRUE, this will show the last value of
the upper and lower quantile.}

\item{.interactive}{The default is FALSE, set to TRUE to get a plotly plot
object back.}
}
\value{
A plot either ggplot2 or plotly.
}
\description{
This function produces a plot of a cumulative statistic function applied to the
bootstrap variable from \code{tidy_bootstrap()} or after \code{bootstrap_unnest_tbl()}
has been applied to it.
}
\details{
This function will take in data from either \code{tidy_bootstrap()} directly or
after apply \code{bootstrap_unnest_tbl()} to its output. There are several different
cumulative functions that can be applied to the data.The accepted values are:
\itemize{
\item "cmean" - Cumulative Mean
\item "chmean" - Cumulative Harmonic Mean
\item "cgmean" - Cumulative Geometric Mean
\item "csum" = Cumulative Sum
\item "cmedian" = Cumulative Median
\item "cmax" = Cumulative Max
\item "cmin" = Cumulative Min
\item "cprod" = Cumulative Product
\item "csd" = Cumulative Standard Deviation
\item "cvar" = Cumulative Variance
\item "cskewness" = Cumulative Skewness
\item "ckurtosis" = Cumulative Kurtotsis
}
}
\examples{
x <- mtcars$mpg

tidy_bootstrap(x) |>
  bootstrap_stat_plot(y, "cmean")

tidy_bootstrap(x, .num_sims = 10) |>
  bootstrap_stat_plot(y,
    .stat = "chmean", .show_groups = TRUE,
    .show_ci_label = FALSE
  )

}
\seealso{
Other Bootstrap: 
\code{\link{bootstrap_density_augment}()},
\code{\link{bootstrap_p_augment}()},
\code{\link{bootstrap_p_vec}()},
\code{\link{bootstrap_q_augment}()},
\code{\link{bootstrap_q_vec}()},
\code{\link{bootstrap_unnest_tbl}()},
\code{\link{tidy_bootstrap}()}

Other Autoplot: 
\code{\link{tidy_autoplot}()},
\code{\link{tidy_combined_autoplot}()},
\code{\link{tidy_four_autoplot}()},
\code{\link{tidy_multi_dist_autoplot}()},
\code{\link{tidy_random_walk_autoplot}()}
}
\author{
Steven P. Sanderson II, MPH
}
\concept{Autoplot}
\concept{Bootstrap}
