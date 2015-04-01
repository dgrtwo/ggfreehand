#' Freehand circles
#'
#' Add freehand circles (default red) to a plot, similar to the style of Meta
#' Stack Overflow (http://meta.stackexchange.com/a/19775/176330).
#'
#' The \code{radius} argument determines the radius of the freehand circles. It
#' is normalized based on the scales such that a radius of 1 takes up 1/25 of the
#' plot's width and height. You can also set the radius separately for the x- and
#' y- axes with \code{radiusx} and \code{radiusy}.
#'
#' @section Aesthetics:
#' \code{geom_freehand} understands the following aesthetics (required aesthetics are in bold):
#'
#' \itemize{
#'   \item \code{\strong{x}}
#'   \item \code{\strong{y}}
#'   \item \code{alpha}
#'   \item \code{colour}
#'   \item \code{linetype}
#'   \item \code{noisiness}
#'   \item \code{radius}
#'   \item \code{radiusx}
#'   \item \code{radiusy}
#'   \item \code{size}
#' }
#'
#' @param mapping The aesthetic mapping, usually constructed with
#'    \code{\link{aes}} or \code{\link{aes_string}}. Only needs to be set
#'    at the layer level if you are overriding the plot defaults.
#' @param data A layer specific dataset - only needed if you want to override
#'    the plot defaults.
#' @param stat The statistical transformation to use on the data for this
#'    layer.
#' @param position The position adjustment to use for overlapping points
#'    on this layer
#' @param ... other arguments passed on to \code{\link{layer}}. This can
#'   include aesthetics whose values you want to set, not map. See
#'   \code{\link{layer}} for more details.
#'
#' @export
#' @examples
#'
#' require("ggplot2")
#'
#' p <- ggplot(mtcars, aes(wt, mpg))
#' p + geom_point()
#'
#' one_car <- mtcars[1, ]
#' p + geom_point() + geom_freehand(data = one_car, rx = .1, ry = .5)
#'
geom_freehand <- function (mapping = NULL, data = NULL, stat = "identity", position = "identity", ...) {
    GeomFreehand$new(mapping = mapping, data = data, stat = stat, position = position, ...)
}


GeomFreehand <- proto(ggplot2:::GeomPath, {
    objname <- "freehand"

    draw <- function(., data, scales, coordinates, arrow = NULL, radius = 1,
                     radiusx = radius, radiusy = radius, ...) {
        # radius default is 1/25 of the range
        x_range <- diff(scales$x.range)
        y_range <- diff(scales$y.range)
        radiusx <- radiusx * x_range / 25
        radiusy <- radiusy * y_range / 25

        data <- dplyr::mutate(data, group = seq_along(x))
        data <- dplyr::group_by(data, x, y, PANEL, group, colour, size, linetype, alpha)
        data <- dplyr::do(data, circle_data(.$x, .$y, radiusx = radiusx, radiusy = radiusy, ...))
        ggplot2:::GeomPath$draw(data, scales, coordinates, arrow, ...)
    }

    default_aes <- function(.) aes(colour="red", size=0.5, linetype=1, alpha = NA,
                                   r = 1, rx = 1, ry = 1, noisiness = 5)

    default_stat <- function(.) ggplot2:::StatIdentity
})
