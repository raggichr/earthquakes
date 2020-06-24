
# earthquakes

<!-- badges: start -->
[![Travis build status](https://travis-ci.com/raggichr/earthquakes.svg?branch=master)](https://travis-ci.com/raggichr/earthquakes)
<!-- badges: end -->

The goal of earthquakes is to complete the MSDR Capstone project on Coursera.

This capstone project will be centered around a dataset obtained from the [U.S. National Oceanographic and Atmospheric Administration (NOAA)](https://www.ngdc.noaa.gov/nndc/struts/form?t=101650&s=1&d=1) on significant earthquakes around the world. This dataset contains information about 5,933 earthquakes over an approximately 4,000 year time span.

The overall goal of the capstone project is to integrate the skills you have developed over the courses in this Specialization and to build a software package that can be used to work with the NOAA Significant Earthquakes dataset. This dataset has a substantial amount of information embedded in it that may not be immediately accessible to people without knowledge of the intimate details of the dataset or of R. Your job is to provide the tools for processing and visualizing the data so that others may extract some use out of the information embedded within.

The ultimate goal of the capstone is to build an R package that will contain features and will satisfy a number of requirements that will be laid out in the subsequent Modules.

## Installation

You can install the released version of earthquakes from [GitHub](https://github.com/raggichr/earthquakes) with:

``` r
library(devtools)
install_github("raggichr/earthquakes")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
# load my earthquakes package
library(earthquakes)

# data reading from my package
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

