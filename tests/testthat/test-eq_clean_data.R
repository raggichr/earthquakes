context("Clean data")

test_that("Clean data is a data frame",{
    filename <- system.file("extdata", "signif.txt", package = "earthquakes")
    library(readr)
    eq_data_raw <- readr::read_delim(file = filename, delim = "\t")
    eq_data <- eq_clean_data(eq_raw = eq_data_raw)

    expect_is(eq_data, c("spec_tbl_df", "tbl_df", "tbl", "data.frame"))
})

test_that("Clean location is a vector", {
    filename <- system.file("extdata", "signif.txt", package = "earthquakes")
    library(readr)
    eq_data_raw <- readr::read_delim(file = filename, delim = "\t")
    eq_data <- eq_location_clean(eq_datf = eq_data_raw)

    expect_equivalent(head(eq_data$LOCATION_NAME), c("Bab-A-Daraa,Al-Karak", "W", "Ugarit", "Thera Island (Santorini)",
                                                     "Ariha (Jericho)", "Lacus Cimini"))
})
