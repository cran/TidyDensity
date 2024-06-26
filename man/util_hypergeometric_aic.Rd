% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils-aic-hypergeometric.R
\name{util_hypergeometric_aic}
\alias{util_hypergeometric_aic}
\title{Calculate Akaike Information Criterion (AIC) for Hypergeometric Distribution}
\usage{
util_hypergeometric_aic(.x)
}
\arguments{
\item{.x}{A numeric vector containing the data to be fitted to a hypergeometric
distribution.}
}
\value{
The AIC value calculated based on the fitted hypergeometric distribution to the provided data.
}
\description{
This function estimates the parameters m, n, and k of a hypergeometric distribution
from the provided data and then calculates the AIC value based on the fitted
distribution.
}
\details{
This function calculates the Akaike Information Criterion (AIC) for a
hypergeometric distribution fitted to the provided data.

This function fits a hypergeometric distribution to the provided data. It
estimates the parameters m, n, and k of the hypergeometric distribution from
the data. Then, it calculates the AIC value based on the fitted distribution.

Initial parameter estimates: The function does not estimate parameters; they
are directly calculated from the data.

Optimization method: Since the parameters are directly calculated from the
data, no optimization is needed.

Goodness-of-fit: While AIC is a useful metric for model comparison, it's
recommended to also assess the goodness-of-fit of the chosen model using
visualization and other statistical tests.
}
\examples{
# Example 1: Calculate AIC for a sample dataset
set.seed(123)
x <- rhyper(100, m = 10, n = 10, k = 5)
util_hypergeometric_aic(x)

}
\seealso{
Other Utility: 
\code{\link{check_duplicate_rows}()},
\code{\link{convert_to_ts}()},
\code{\link{quantile_normalize}()},
\code{\link{tidy_mcmc_sampling}()},
\code{\link{util_beta_aic}()},
\code{\link{util_binomial_aic}()},
\code{\link{util_cauchy_aic}()},
\code{\link{util_chisq_aic}()},
\code{\link{util_exponential_aic}()},
\code{\link{util_f_aic}()},
\code{\link{util_gamma_aic}()},
\code{\link{util_generalized_beta_aic}()},
\code{\link{util_generalized_pareto_aic}()},
\code{\link{util_geometric_aic}()},
\code{\link{util_inverse_burr_aic}()},
\code{\link{util_inverse_pareto_aic}()},
\code{\link{util_inverse_weibull_aic}()},
\code{\link{util_logistic_aic}()},
\code{\link{util_lognormal_aic}()},
\code{\link{util_negative_binomial_aic}()},
\code{\link{util_normal_aic}()},
\code{\link{util_paralogistic_aic}()},
\code{\link{util_pareto1_aic}()},
\code{\link{util_pareto_aic}()},
\code{\link{util_poisson_aic}()},
\code{\link{util_t_aic}()},
\code{\link{util_triangular_aic}()},
\code{\link{util_uniform_aic}()},
\code{\link{util_weibull_aic}()},
\code{\link{util_zero_truncated_binomial_aic}()},
\code{\link{util_zero_truncated_geometric_aic}()},
\code{\link{util_zero_truncated_negative_binomial_aic}()},
\code{\link{util_zero_truncated_poisson_aic}()}
}
\author{
Steven P. Sanderson II, MPH
}
\concept{Utility}
