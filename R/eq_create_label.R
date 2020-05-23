#' @title Creates popup text for markers.
#'
#' @description  This function generates HTML formatted text to be used in popups for map markers.
#'
#' @param eq_data_clean The clean earthquake data in a tbl_df object.
#' @return This function returns a character vector containing popup text to be used in a leaflet visualization.
#'
#' @examples
#' \dontrun{
#' filename<-system.file("data","earthquakes_data.txt.zip",package="capstone")
#' eq_location_clean(eq_clean_data(eq_data_read(filename))) %>%
#' dplyr::filter(COUNTRY == "MEXICO" & lubridate::year(datetime) >= 1980) %>%
#' dplyr::mutate(popup_text = eq_create_label(.)) %>%
#'  eq_map(annot_col = "popup_text")
#' }
#'
#' @export
eq_create_label <- function(eq_data_clean = NULL){

    # check if the correct columns are present
    all_columns <- colnames(eq_data_clean)

    stopifnot(any("LOCATION_NAME" %in% all_columns),
              any("EQ_PRIMARY" %in% all_columns),
              any("TOTAL_DEATHS" %in% all_columns))

    # create the "popup_text" without using NA Labels
    popup_vals <- eq_data_clean %>% dplyr::select(c("LOCATION_NAME","EQ_PRIMARY","TOTAL_DEATHS")) %>%
        dplyr::mutate(LOCATION_NAME = ifelse(is.na(LOCATION_NAME), LOCATION_NAME,
                                             paste0("<strong>Location:</strong> ", LOCATION_NAME,"<br>"))) %>%
        dplyr::mutate(EQ_PRIMARY = ifelse(is.na(EQ_PRIMARY), EQ_PRIMARY,
                                          paste0("<strong>Magnitude:</strong> ", EQ_PRIMARY,"<br>"))) %>%
        dplyr::mutate(TOTAL_DEATHS = ifelse(is.na(TOTAL_DEATHS), TOTAL_DEATHS,
                                              paste0("<strong>Total deaths:</strong> ", TOTAL_DEATHS))) %>%
        tidyr::unite("popup_values", c("LOCATION_NAME","EQ_PRIMARY","TOTAL_DEATHS"), sep = "") %>%
        dplyr::mutate(popup_values = stringr::str_replace_all(popup_values, "[,]*NA[,]*", "")) %>%
        dplyr::mutate(popup_values = ifelse(popup_values == "", "All Values are NA", popup_values))

    # convert tbl_df to a character vector
    popup_vals <- dplyr::collect(dplyr::select(popup_vals,c("popup_values")))[[1]]

    return(popup_vals)
}
