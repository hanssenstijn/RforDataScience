# get clean ws
rm(list=ls())

# first function
rescale01 <- function(x) {
    rng <- range(x, na.rm = TRUE)
    (x - rng[1]) / (rng[2] - rng[1])
}
rescale01(c(0, 5, 10))

# use lower case words and an underscore to name functions
# e.g. impute_missing()

# make breaks
# Load data --------------------------------------

# example conditional execution
# if (condition) {
#     # code executed when condition is TRUE
# } else {
#     # code executed when condition is FALSE
# }

has_name <- function(x) {
    nms <- names(x)
    if (is.null(nms)) {
        rep(FALSE, length(x))
    } else {
        !is.na(nms) & nms != ""
    }
}

# choosing names
# . x, y, z: vectors.
# . w: a vector of weights.
# . df: a data frame.
# . i, j: numeric indices (typically rows and columns).
# . n: length, or number of rows.
# . p: number of columns.

# throw in an error and see immediatly where it goes wrong in your function
wt_mean <- function(x, w, na.rm = FALSE) {
    stopifnot(is.logical(na.rm), length(na.rm) == 1)
    stopifnot(length(x) == length(w))
    if (na.rm) {
        miss <- is.na(x) | is.na(w)
        x <- x[!miss]
        w <- w[!miss]
    }
    sum(w * x) / sum(x)
}
wt_mean(1:6, 6:1, na.rm = "foo")