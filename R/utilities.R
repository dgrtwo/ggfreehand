#' @export
circle_data <- function(x, y, radius = 1, radiusx  = radius, radiusy = radius,
                        noisiness = 5, ...) {
    npoints <- 300
    tt <- seq(0, 2 * pi, length.out = npoints)
    # don't always start at the same point
    tt <- (tt + runif(1, 0, 2 * pi)) %% (2 * pi)

    xx <- x + (radiusx + cumsum(rnorm(npoints, 0, noisiness * radiusx / npoints))) * cos(tt)
    yy <- y + (radiusy + cumsum(rnorm(npoints, 0, noisiness * radiusy / npoints))) * sin(tt)
    data.frame(x = xx, y = yy)
}
