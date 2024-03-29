% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vec-bootstrap-q.R
\name{bootstrap_q_vec}
\alias{bootstrap_q_vec}
\title{Compute Bootstrap Q of a Vector}
\usage{
bootstrap_q_vec(.x)
}
\arguments{
\item{.x}{A numeric}
}
\value{
A vector
}
\description{
This function takes in a vector as it's input and will return the quantile
of a vector.
}
\details{
A function to return the quantile of a vector.
}
\examples{
x <- mtcars$mpg

bootstrap_q_vec(x)

}
\seealso{
Other Bootstrap: 
\code{\link{bootstrap_density_augment}()},
\code{\link{bootstrap_p_augment}()},
\code{\link{bootstrap_p_vec}()},
\code{\link{bootstrap_q_augment}()},
\code{\link{bootstrap_stat_plot}()},
\code{\link{bootstrap_unnest_tbl}()},
\code{\link{tidy_bootstrap}()}

Other Vector Function: 
\code{\link{bootstrap_p_vec}()},
\code{\link{cgmean}()},
\code{\link{chmean}()},
\code{\link{ckurtosis}()},
\code{\link{cmean}()},
\code{\link{cmedian}()},
\code{\link{csd}()},
\code{\link{cskewness}()},
\code{\link{cvar}()},
\code{\link{tidy_kurtosis_vec}()},
\code{\link{tidy_scale_zero_one_vec}()},
\code{\link{tidy_skewness_vec}()}
}
\author{
Steven P. Sanderson II, MPH
}
\concept{Bootstrap}
\concept{Vector Function}
