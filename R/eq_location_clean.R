#' @title Cleans the location name of the raw NOAA earthquake dataset.
#'
#' @description Cleans the (\code{LOCATION_NAME}) column by stripping out the country name (including the colon)
#' and converts names to title case (as opposed to all caps). This will be needed later for annotating
#' visualizations. This function should be applied to the raw data to produce a cleaned up version of
#' the (\code{LOCATION_NAME}) column.
#'
#' @param eq_datf the raw NOAA earthquake dataset as a data frame that contains location names written in upper case.
#'
#' @return returns a clean data frame of the NOAA earthquake dataset.
#'
#' @import dplyr
#' @importFrom stringi stri_trans_totitle
#'
#'@examples
#'\dontrun{
#' filename <- system.file("extdata", "signif.txt", package = "earthquakes")
#' library(readr)
#' eq_data_raw <- readr::read_delim(file = filename, delim = "\t")
#' eq_data <- eq_location_clean(eq_datf = eq_data_raw)
#' head(eq_data_raw$LOCATION_NAME)
#' head(eq_data$LOCATION_NAME)
#' }
#'
#' @export
eq_location_clean <- function(eq_datf){

    LOCATION_NAME <- NULL

    eq_datf <- eq_datf %>%
        dplyr::mutate(LOCATION_NAME = trimws(gsub(pattern = ".*:", replacement = "", LOCATION_NAME)),
                      LOCATION_NAME = stringi::stri_trans_totitle(LOCATION_NAME))

    return(eq_datf)
}
