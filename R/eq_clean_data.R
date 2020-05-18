#' @title Cleans the raw NOAA earthquake dataset.
#'
#' @description Takes raw NOAA data frame and returns a clean data frame. The clean data frame should have the following:
#' 1. A date column created by uniting the year, month, day and converting it to the Date class.
#' 2. LATITUDE and LONGITUDE columns converted to numeric class.
#' 3. In addition, a LOCATION_NAME column by stripping out the country name (including the colon)
#' and converts names to title case (as opposed to all caps). This will be needed later for annotating visualizations.
#'
#' @param eq_raw the raw NOAA earthquake dataset as a data frame that contains location names written in upper case.
#'
#' @return returns a clean data frame of the NOAA earthquake dataset.
#'
#' @examples
#'
#' @export
eq_clean_data <- function(eq_raw){

    YEAR <- NULL
    MONTH <- NULL
    DAY <- NULL
    HOUR <- NULL

    LATITUDE <- NULL
    LONGITUDE <- NULL

    LOCATION_NAME <- NULL

    # 1. A date column created by uniting the year, month, day and converting it to the Date class
    # 2. LATITUDE and LONGITUDE columns converted to numeric class
    eq_raw %>%
        dplyr::mutate(DATE = lubridate::ymd_h(paste(eq_raw$YEAR,
                                             eq_raw$MONTH,
                                             eq_raw$DAY,
                                             eq_raw$HOUR, sep = ""))) %>%
        dplyr::mutate_at(.vars = (c("LATITUDE", "LONGITUDE")), .funs = ~as.numeric(.)) -> eq_clean

    # 3. cleans the LOCATION_NAME column by stripping out the country name (including the colon) and converts names to title case
    eq_clean <- eq_location_clean(eq_datf = eq_clean)

    return(eq_clean)
}
