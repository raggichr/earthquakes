#' @title Class GeomTimelineLabel
#'
#' @description Construct a new class 'GeomTimelineLabel' which is a 'ggproto' object
#' for plotting a time line of earthquakes.#'
#'
#' @import ggplot2
#'
#' @export
GeomTimelineLabel <- ggplot2::ggproto("GeomTimelineLabel", ggplot2::GeomText,
                                      #<character vector of required aesthetics>
                                      required_aes = c("x", "y", "tags"),
                                      #aes(<default values for certain aesthetics>)
                                      default_aes = ggplot2::aes(number = NULL,
                                                                 max_aes = NULL),
                                      #<a function used to draw the key in the legend>
                                      draw_key = draw_key_text,
                                      ## Function that returns a grid grob that will
                                      ## be plotted (this is where the real work occurs)
                                      draw_panel = function(data, panel_scales, coord) {

                                          # transform the data first
                                          coords <- coord$transform(data, panel_scales)

                                          # creating the vertical lines over the timeline
                                          grob_timeline_seq <- grid::segmentsGrob(x0 = grid::unit(coords$x, "npc"),
                                                                                  y0 = grid::unit(coords$y, "npc"),
                                                                                  x1 = grid::unit(coords$x, "npc"),
                                                                                  y1 = grid::unit(coords$y + 0.06/length(unique(coords$y)), "npc"),
                                                                                  default.units = "npc",
                                                                                  arrow = NULL,
                                                                                  name = NULL,
                                                                                  gp = grid::gpar(),
                                                                                  vp = NULL)

                                          # adding the text to the vertical lines over the timeline
                                          grob_earthquake_text <- grid::textGrob(label = coords$tags,
                                                                                 x = unit(coords$x, "npc"),
                                                                                 y = unit(coords$y + 0.08/length(unique(coords$y)), "npc"),
                                                                                 rot = 60,
                                                                                 just = "left",
                                                                                 gp = grid::gpar(fontsize = 8))

                                          # knit together grobs
                                          grob_all <- grid::gTree(children = grid::gList(grob_timeline_seq,
                                                                                         grob_earthquake_text
                                              ))

                                          return(grob_all)
                                      }
)
