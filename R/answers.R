#' A dataset of David Robinson's Stack Overflow answers as of 4/1/2015
#'
#' This object was created with the lines of code shown in the Examples
#' below. It is a dataset from the Stack Exchange API showing answers from
#' user 712603 (David Robinson, this package's maintainer). It is useful for
#' example plots, such as those in the vignette, since everyone knows
#' freehand red circles are most important when plotting Stack Overflow data.
#'
#' @examples
#'
#' # created with stackr:
#' \dontrun{
#'     require("stackr")
#'     answers <- stack_users(712603, "answers", num_pages = 10, pagesize = 100)
#'     answers <- dplyr::tbl_df(answers)
#' }
"answers"
