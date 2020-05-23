context("Create an interactive map")

test_that("Create a map",{
    filename <- system.file("extdata", "signif.txt", package = "earthquakes")
    library(readr)
    eq_data_raw <- readr::read_delim(file = filename, delim = "\t")
    eq_data <- eq_clean_data(eq_raw = eq_data_raw)
    library(dplyr)
    library(lubridate)
    library(leaflet)
    eq_data %>%
        filter(COUNTRY %in% "ITALY" &
                   lubridate::year(DATE) >= 2000) -> eq_data_sample

    p <- eq_data_sample %>%
        eq_clean_data() %>%
        filter(COUNTRY %in% "ITALY" & lubridate::year(DATE) >= 2000) %>%
        eq_map(annot_col = "DATE")

    expect_is(p, c("leaflet", "htmlwidget"))
})
