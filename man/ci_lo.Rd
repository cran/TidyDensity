% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stats-confidence-intervals.R
\name{ci_lo}
\alias{ci_lo}
\title{Confidence Interval Generic}
\usage{
ci_lo(.x, .na_rm = FALSE)
}
\arguments{
\item{.x}{A vector of numeric values}

\item{.na_rm}{A Boolean, defaults to FALSE. Passed to the quantile function.}
}
\value{
A numeric value.
}
\description{
Gets the lower 2.5\% quantile of a numeric vector.
}
\details{
Gets the lower 2.5\% quantile of a numeric vector.
}
\examples{
x <- mtcars$mpg
ci_lo(x)

}
\seealso{
Other Statistic: 
\code{\link{ci_hi}()},
\code{\link{tidy_kurtosis_vec}()},
\code{\link{tidy_range_statistic}()},
\code{\link{tidy_skewness_vec}()},
\code{\link{tidy_stat_tbl}()}
}
\author{
Steven P. Sanderson II, MPH
}
\concept{Statistic}
