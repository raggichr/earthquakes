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
    popup_vals <- eq_data_clean %>% dplyr::select(c(.data[["LOCATION_NAME"]],
                                                    .data[["EQ_PRIMARY"]],
                                                    .data[["TOTAL_DEATHS"]])) %>%
        dplyr::mutate(LOCATION_NAME = ifelse(is.na(.data[["LOCATION_NAME"]]), .data[["LOCATION_NAME"]],
                                             paste0("<strong>Location:</strong> ", .data[["LOCATION_NAME"]],"<br>"))) %>%
        dplyr::mutate(EQ_PRIMARY = ifelse(is.na(.data[["EQ_PRIMARY"]]), .data[["EQ_PRIMARY"]],
                                          paste0("<strong>Magnitude:</strong> ", .data[["EQ_PRIMARY"]],"<br>"))) %>%
        dplyr::mutate(TOTAL_DEATHS = ifelse(is.na(.data[["TOTAL_DEATHS"]]), .data[["TOTAL_DEATHS"]],
                                              paste0("<strong>Total deaths:</strong> ", .data[["TOTAL_DEATHS"]]))) %>%
        tidyr::unite("popup_values", c("LOCATION_NAME","EQ_PRIMARY","TOTAL_DEATHS"), sep = "") %>%
        dplyr::mutate(popup_values = stringr::str_replace_all(.data[["popup_values"]], "[,]*NA[,]*", "")) %>%
        dplyr::mutate(popup_values = ifelse(.data[["popup_values"]] == "", "All Values are NA", .data[["popup_values"]]))

    # convert tbl_df to a character vector
    popup_vals <- dplyr::collect(dplyr::select(popup_vals, .data[["popup_values"]]))[[1]]

    return(popup_vals)
}
