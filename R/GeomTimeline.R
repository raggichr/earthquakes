#' @title Class GeomTimeline
#'
#' @description Construct a new class 'GeomTimeline' which is a 'ggproto' object
#' for plotting a time line of earthquakes.#'
#'
#' @import ggplot2
#'
#' @export
GeomTimeline <- ggplot2::ggproto("GeomTimeline", ggplot2::GeomPoint,
                                 # <a character vector of required aesthetics>
                                 required_aes = c("x","y"),
                                 # aes(<default values for certain aesthetics>)
                                 default_aes = ggplot2::aes(shape = 19,
                                                            colour = "black",
                                                            size = 1,
                                                            alpha = 0.4),
                                 # <a function used to draw the key in the legend>
                                 draw_key = ggplot2::draw_key_point,
                                 # Function that returns a grid grob that will
                                 # be plotted (this is where the real work occurs)
                                 draw_panel = function(data, panel_params, coord){
                                     # transform the data first
                                     coords <- coord$transform(data, panel_params)

                                     # x-axis grob
                                     grob_xaxis <- grid::xaxisGrob(at = coords$x)

                                     # points grob
                                     grob_points <- grid::pointsGrob(coords$x,
                                                      coords$y,
                                                      pch = coords$shape,
                                                      size = grid::unit(coords$size/1, "char"),
                                                      # default.units = "npc",
                                                      gp = grid::gpar(col = coords$colour,
                                                                      alpha = coords$alpha)
                                     )

                                     # line grob
                                     grob_line <- grid::polylineGrob(x = grid::unit(rep(c(0, 1), length(coords$y)), "npc"),
                                                                     y = rep(coords$y, each = 2),
                                                                     id.length = rep(2, length(coords$y)),
                                                                     gp = grid::gpar(col = "black",
                                                                                     lwd = 0.3,
                                                                                     lty = 1,
                                                                                     alpha = 0.2))

                                     # knit together grobs
                                     grob_all <- grid::gTree(children = grid::gList(grob_xaxis,
                                                                                     grob_line,
                                                                                     grob_points))

                                     return(grob_all)
                                 }
                             )


# GeomTimeline <- ggplot2::ggproto("GeomTimeline", ggplot2::Geom,
#                                  # <a character vector of required aesthetics>
#                                  required_aes = c("x"),
#                                  # aes(<default values for certain aesthetics>)
#                                  default_aes = ggplot2::aes(y = 0.1,
#                                                             shape = 21,
#                                                             size = 1,
#                                                             colour = "blue",
#                                                             alpha = 0.75,
#                                                             stroke = 1, # framing or border around the points
#                                                             fill = NA),
#                                  # <a function used to draw the key in the legend>
#                                  draw_key = ggplot2::draw_key_point,
#                                  # Function that returns a grid grob that will
#                                  # be plotted (this is where the real work occurs)
#                                  draw_panel = function(data, panel_scales, coord){
#                                      # transform the data first
#                                      coords <- coord$transform(data, panel_scales)
#
#                                      # # set NA to zero
#                                      # coords$size[is.na(coords$size)] <- 0
#                                      #
#                                      # # set range stnadardization between 0 and 1
#                                      # range01 <- function(x){(x-min(x))/(max(x)-min(x))}
#                                      # coords$size <- range01(coords$size)
#
#                                      # To create the earthquake's timeline we separate the task in two parts
#                                      # 1) Plot the line over the x-axis
#                                      # 2) Plot the points for each earthquake
#                                      # We use of the concept of grobs objects.
#
#                                      # x-axis grob
#                                      grob_xaxis <- grid::xaxisGrob(at = coords$x)
#
#                                      # x-axis line grob
#                                      grob_line <- grid::polylineGrob(x = grid::unit(rep(c(0, 1), length(coords$y)),
#                                                                                     "npc"),
#                                                                      y = rep(coords$y, each = 2),
#                                                                      id.length = rep(2, length(coords$y)),
#                                                                      gp = grid::gpar(col = "black",
#                                                                                      lwd = 0.3,
#                                                                                      lty = 1))
#
#                                      # point line grob
#                                      grob_points <- grid::pointsGrob(x = coords$x,
#                                                                      y = coords$y,
#                                                                      pch = coords$shape,
#                                                                      # size = unit(coords$size, "mm"),
#                                                                      # default.units = "npc",
#                                                                      gp = grid::gpar(col = coords$colour,
#                                                                                      fill = coords$fill,
#                                                                                      alpha = coords$alpha,
#                                                                                      lwd = coords$stroke * .stroke / 2
#                                                                      )
#                                      )
#
#                                      # knit together grobs
#                                      all_grobs <- grid::gTree(children = grid::gList(grob_xaxis,
#                                                                                      grob_line,
#                                                                                      grob_points))
#
#                                      return(all_grobs)
#                                  })
