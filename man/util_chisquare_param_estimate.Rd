% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/est-param-chisq.R
\name{util_chisquare_param_estimate}
\alias{util_chisquare_param_estimate}
\title{Estimate Chisquare Parameters}
\usage{
util_chisquare_param_estimate(.x, .auto_gen_empirical = TRUE)
}
\arguments{
\item{.x}{The vector of data to be passed to the function. Must be non-negative
integers.}

\item{.auto_gen_empirical}{This is a boolean value of TRUE/FALSE with default
set to TRUE. This will automatically create the \code{tidy_empirical()} output
for the \code{.x} parameter and use the \code{tidy_combine_distributions()}. The user
can then plot out the data using \verb{$combined_data_tbl} from the function output.}
}
\value{
A tibble/list
}
\description{
This function will attempt to estimate the Chisquare prob parameter
given some vector of values \code{.x}. The function will return a list output by default,
and  if the parameter \code{.auto_gen_empirical} is set to \code{TRUE} then the empirical
data given to the parameter \code{.x} will be run through the \code{tidy_empirical()}
function and combined with the estimated Chisquare data.
}
\details{
This function will see if the given vector \code{.x} is a numeric vector.
It will attempt to estimate the prob parameter of a Chisquare distribution.
The function first performs tidyeval on the input data to ensure it's a
numeric vector. It then checks if there are at least two data points, as this
is a requirement for parameter estimation.

The estimation of the chi-square distribution parameters is performed using
maximum likelihood estimation (MLE) implemented with the \code{bbmle} package.
The negative log-likelihood function is minimized to obtain the estimates for
the degrees of freedom (\code{doff}) and the non-centrality parameter (\code{ncp}).
Initial values for the optimization are set based on the sample variance and
mean, but these can be adjusted if necessary.

If the estimation fails or encounters an error, the function returns \code{NA}
for both \code{doff} and \code{ncp}.

Finally, the function returns a tibble containing the following information:
\describe{
\item{dist_type}{The type of distribution, which is "Chisquare" in this case.}
\item{samp_size}{The sample size, i.e., the number of data points in the input vector.}
\item{min}{The minimum value of the data points.}
\item{max}{The maximum value of the data points.}
\item{mean}{The mean of the data points.}
\item{degrees_of_freedom}{The estimated degrees of freedom (\code{doff}) for the chi-square distribution.}
\item{ncp}{The estimated non-centrality parameter (\code{ncp}) for the chi-square distribution.}
}

Additionally, if the argument \code{.auto_gen_empirical} is set to \code{TRUE}
(which is the default behavior), the function also returns a combined tibble
containing both empirical and chi-square distribution data, obtained by
calling \code{tidy_empirical} and \code{tidy_chisquare}, respectively.
}
\examples{
library(dplyr)
library(ggplot2)

tc <- tidy_chisquare(.n = 500, .df = 6, .ncp = 1) |> pull(y)
output <- util_chisquare_param_estimate(tc)

output$parameter_tbl

output$combined_data_tbl |>
  tidy_combined_autoplot()

}
\seealso{
Other Parameter Estimation: 
\code{\link{util_bernoulli_param_estimate}()},
\code{\link{util_beta_param_estimate}()},
\code{\link{util_binomial_param_estimate}()},
\code{\link{util_burr_param_estimate}()},
\code{\link{util_cauchy_param_estimate}()},
\code{\link{util_exponential_param_estimate}()},
\code{\link{util_f_param_estimate}()},
\code{\link{util_gamma_param_estimate}()},
\code{\link{util_generalized_beta_param_estimate}()},
\code{\link{util_generalized_pareto_param_estimate}()},
\code{\link{util_geometric_param_estimate}()},
\code{\link{util_hypergeometric_param_estimate}()},
\code{\link{util_inverse_burr_param_estimate}()},
\code{\link{util_inverse_pareto_param_estimate}()},
\code{\link{util_inverse_weibull_param_estimate}()},
\code{\link{util_logistic_param_estimate}()},
\code{\link{util_lognormal_param_estimate}()},
\code{\link{util_negative_binomial_param_estimate}()},
\code{\link{util_normal_param_estimate}()},
\code{\link{util_paralogistic_param_estimate}()},
\code{\link{util_pareto1_param_estimate}()},
\code{\link{util_pareto_param_estimate}()},
\code{\link{util_poisson_param_estimate}()},
\code{\link{util_t_param_estimate}()},
\code{\link{util_triangular_param_estimate}()},
\code{\link{util_uniform_param_estimate}()},
\code{\link{util_weibull_param_estimate}()},
\code{\link{util_zero_truncated_binomial_param_estimate}()},
\code{\link{util_zero_truncated_geometric_param_estimate}()},
\code{\link{util_zero_truncated_negative_binomial_param_estimate}()},
\code{\link{util_zero_truncated_poisson_param_estimate}()}

Other Chisquare: 
\code{\link{tidy_chisquare}()},
\code{\link{util_chisquare_stats_tbl}()}
}
\author{
Steven P. Sanderson II, MPH
}
\concept{Chisquare}
\concept{Parameter Estimation}
