% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vec-cumulative-functions.R
\name{cskewness}
\alias{cskewness}
\title{Cumulative Skewness}
\usage{
cskewness(.x)
}
\arguments{
\item{.x}{A numeric vector}
}
\value{
A numeric vector
}
\description{
A function to return the cumulative skewness of a vector.
}
\details{
A function to return the cumulative skewness of a vector.
}
\examples{
x <- mtcars$mpg

cskewness(x)

}
\seealso{
Other Vector Function: 
\code{\link{bootstrap_p_vec}()},
\code{\link{bootstrap_q_vec}()},
\code{\link{cgmean}()},
\code{\link{chmean}()},
\code{\link{ckurtosis}()},
\code{\link{cmean}()},
\code{\link{cmedian}()},
\code{\link{csd}()},
\code{\link{cvar}()},
\code{\link{tidy_kurtosis_vec}()},
\code{\link{tidy_scale_zero_one_vec}()},
\code{\link{tidy_skewness_vec}()}
}
\author{
Steven P. Sanderson II, MPH
}
\concept{Vector Function}
