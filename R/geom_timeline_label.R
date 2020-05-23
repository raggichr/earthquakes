#' @title A ggplot2 layer: \code{geom_timeline_label()} function
#'
#' @description Construct a regular function/layer to plot a timeline with the earthquakes
#' of a given country that is added to a plot created with ggplot() function. This function is
#' for adding annotations to the earthquake data. This geom adds a vertical line to each data
#' point with a text annotation (e.g. the location of the earthquake) attached to each line.
#'
#' The \code{geom_timeline_label()} function is a wrapper to the layer function for the 'GeomTimelineLabel' class.
#'
#' @param mapping aesthetic mappings created by aes
#' @param data is the data frame that contains the earthquake's data
#' @param stat layer's statistical transformation
#' @param position position adjustment function
#' @param na.rm remove the NA values from the data frame
#' @param show.legend layer's legend
#' @param inherit.aes will indicate the default aesthetics overridng
#' @param ... layer's other arguments
#'
#' @return a plot timeline with earthquakes of a given country or list of countries.
#'
#' @import ggplot2
#'
#' @examples
#' \dontrun{
#' filename <- system.file("extdata", "signif.txt", package = "earthquakes")
#' library(readr)
#' eq_data_raw <- readr::read_delim(file = filename, delim = "\t")
#' eq_data <- eq_clean_data(eq_raw = eq_data_raw)
#' library(ggplot2)
#' library(ggthemes)
#' eq_data %>%
#'     dplyr::filter(DATE >= "1995-01-01" &
#'                       DATE <= "2018-01-01" &
#'                       COUNTRY %in% c("USA","ITALY","MEXICO")) %>%
#'     ggplot(aes(x = DATE,
#'                y = COUNTRY,
#'                colour = DEATHS,
#'                size = EQ_PRIMARY)) +
#'     geom_timeline() +
#'     geom_timeline_label(aes(x = DATE,
#'                             y = COUNTRY,
#'                             tags = LOCATION_NAME,
#'                             number = 3,
#'                             max_aes = EQ_PRIMARY)) +
#'     theme_tufte() +
#'     theme(legend.position = "right")
#' }
#'
#' @export
geom_timeline_label <- function(mapping = NULL,
                          data = NULL,
                          stat = "identity",
                          position = "identity",
                          na.rm = FALSE,
                          show.legend = NA,
                          inherit.aes = TRUE, ...){
    ggplot2::layer(geom = GeomTimelineLabel,
                   mapping = mapping,
                   data = data,
                   stat = stat,
                   position = position,
                   show.legend = show.legend,
                   inherit.aes = inherit.aes,
                   params = list(na.rm = na.rm, ...))
}
