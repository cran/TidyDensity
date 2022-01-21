## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",  
  fig.width = 8,
  fig.height = 4.5,
  fig.align = 'center',
  out.width = '95%',
  dpi = 100,
  message = FALSE,
  warning = FALSE
)

## ----setup--------------------------------------------------------------------
library(TidyDensity)

## ----example------------------------------------------------------------------
library(TidyDensity)
library(dplyr)
library(ggplot2)

tidy_normal()

## ----plot_density-------------------------------------------------------------
tn <- tidy_normal(.n = 100, .num_sims = 6)

tidy_autoplot(tn, .plot_type = "density")
tidy_autoplot(tn, .plot_type = "quantile")
tidy_autoplot(tn, .plot_type = "probability")
tidy_autoplot(tn, .plot_type = "qq")

## ----more_than_nine_simulations-----------------------------------------------
tn <- tidy_normal(.n = 100, .num_sims = 20)

tidy_autoplot(tn, .plot_type = "density")
tidy_autoplot(tn, .plot_type = "quantile")
tidy_autoplot(tn, .plot_type = "probability")
tidy_autoplot(tn, .plot_type = "qq")

