#' @title Earthquakes Data in an Interactive Map.
#'
#' @description The function  \code{eq_map()} that takes an argument data containing
#' the filtered data frame with earthquakes to visualize. The function maps the
#' epicenters (\code{LATITUDE/LONGITUDE}) and annotates each point with in pop up window
#' containing annotation data stored in a column of the data frame.
#' The user should be able to choose which column is used for the annotation in
#' the pop-up with a function argument named \code{annot_col}. Each earthquake
#' should be shown with a circle, and the radius of the circle should be
#' proportional to the earthquake's magnitude (\code{EQ_PRIMARY}).
#'
#' The Earthquakes will be mapped centered with their latitude and
#' longitude "epicenter". The epicenter is annotated based on an \code{annot_col}
#' which the user can specify. In addition, if the user specifies \code{"popup_text"}
#' then a call to eq_create_label generates the appropriate text for the popup.
#'
#' @param eq_data_clean the clean earthquake data in a tbl_df object.
#' @param annot_col a column name in the tbl_df object to be used for annotation.
#'
#' @return an interactive leaflet map.
#'
#' @note If an invalid column name is provided, the function provides a warning
#' and uses the LOCATION_NAME column as the annotation column.
#'
#' @import leaflet
#'
#' @examples
#' \dontrun{
#' filename <- system.file("extdata", "signif.txt", package = "earthquakes")
#' library(readr)
#' eq_data_raw <- readr::read_delim(file = filename, delim = "\t")
#' eq_data <- eq_clean_data(eq_raw = eq_data_raw)
#' library(dplyr)
#' library(lubridate)
#' library(leaflet)
#' eq_data %>%
#'     filter(COUNTRY %in% "ITALY" &
#'                lubridate::year(DATE) >= 2000) -> eq_data_sample
#'
#' eq_data_sample %>%
#'     eq_clean_data() %>%
#'     filter(COUNTRY %in% "ITALY" & lubridate::year(DATE) >= 2000) %>%
#'     eq_map(annot_col = "DATE")
#' }
#'
#' @export
eq_map <- function(eq_data_clean = NULL, annot_col = "DATE"){

    # check if the correct columns are present
    all_columns <- colnames(eq_data_clean)

    stopifnot(any("DATE" %in% all_columns),
              any("LATITUDE" %in% all_columns),
              any("LONGITUDE" %in% all_columns),
              any("EQ_PRIMARY" %in% all_columns))

    # check to see if invalid column provided - print message and default to DATE
    if(!(any(annot_col %in% all_columns))) {
        warning("Invalid Column - DATE Displayed")
        annot_col = "DATE"
    }

    # create a leaflet map
    l_map <- leaflet() %>%
        leaflet::addTiles() %>%
        leaflet::addCircleMarkers(data = eq_data_clean,
                                  lng = ~ LONGITUDE,
                                  lat = ~ LATITUDE,
                                  radius = ~ EQ_PRIMARY,
                                  weight = 1,
                                  fillOpacity = 0.2,
                                  popup = ~ paste0("<strong>Date: </strong>",
                                                 get(annot_col)))

    return(l_map)
}
