context("Create a time line plot")

test_that("Create a time line plot",{
    filename <- system.file("extdata", "signif.txt", package = "earthquakes")
    library(readr)
    eq_data_raw <- readr::read_delim(file = filename, delim = "\t")
    eq_data <- eq_clean_data(eq_raw = eq_data_raw)
    library(dplyr)
    library(ggplot2)
    library(ggthemes)
    p <- eq_data %>%
        dplyr::filter(DATE >= "1995-01-01" &
                          DATE <= "2018-01-01" &
                          COUNTRY %in% c("USA","ITALY","MEXICO")) %>%
        ggplot(aes(x = DATE,
                   y = COUNTRY,
                   colour = DEATHS,
                   size = EQ_PRIMARY)) +
        geom_timeline() +
        geom_timeline_label(aes(x = DATE,
                                y = COUNTRY,
                                tags = LOCATION_NAME,
                                number = 3,
                                max_aes = EQ_PRIMARY)) +
        theme_tufte() +
        theme(legend.position = "right")

    expect_is(p, c("gg", "ggplot"))
})
