
# earthquakes

<!-- badges: start -->
[![Travis build status](https://travis-ci.com/raggichr/earthquakes.svg?branch=master)](https://travis-ci.com/raggichr/earthquakes)
<!-- badges: end -->

The goal of earthquakes is to ...

## Installation

You can install the released version of earthquakes from [GitHub](https://github.com/raggichr/earthquakes) with:

``` r
install_github("raggichr/earthquakes")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
# load my earthquakes library
library(earthquakes)

# read data from my library
filename <- system.file("extdata", "signif.txt", package = "earthquakes")
library(readr)
eq_data_raw <- readr::read_delim(file = filename, delim = "\t")

# data cleansing
eq_data <- eq_clean_data(eq_raw = eq_data_raw)

# data filtering
library(dplyr)
library(lubridate)
library(leaflet)
eq_data %>%
    filter(COUNTRY %in% "ITALY" &
               lubridate::year(DATE) >= 2000) -> eq_data_sample

# data mapping
eq_data_sample %>%
    eq_clean_data() %>%
    filter(COUNTRY %in% "ITALY" & lubridate::year(DATE) >= 2000) %>%
    eq_map(annot_col = "DATE")
```

