# get clean ws
rm(list=ls())

#load lib
library(tidyverse)

# simple tibble
df <- tibble(
    a = rnorm(10),
    b = rnorm(10),
    c = rnorm(10),
    d = rnorm(10)
)
# for loop
output <- vector("double", ncol(df)) # 1. output
# output output <- vector("double", length(x))
# Before you start the loop, you must always allocate sufficient
# space for the output.
for (i in seq_along(df)) { # 2. sequence
    # sequence i in seq_along(df)
    # This determines what to loop over: each run of the for loop will
    # assign i to a different value from seq_along(df).
    output[[i]] <- median(df[[i]]) # 3. body
}
output

# If you're creating named output, make sure to name the results
# vector like so:
# results <- vector("list", length(x))
# names(results) <- names(x)

# A better solution is to save the results in a list, and then combine
# into a single vector after the loop is done:
means <- c(0, 1, 2)
out <- vector("list", length(means))
for (i in seq_along(means)) {
    n <- sample(100, 1)
    out[[i]] <- rnorm(n, means[[i]])
}
str(out)
# I've used unlist() to flatten a list of vectors into a single vector.
str(unlist(out))

# while loop
flip <- function() sample(c("T", "H"), 1)
flips <- 0
nheads <- 0
while (nheads < 3) {
    if (flip() == "H") {
        nheads <- nheads + 1
    } else {
        nheads <- 0
    }
    flips <- flips + 1
}
flips

# add an extra argument to the function
col_summary <- function(df, fun) {
    out <- vector("double", length(df))
    for (i in seq_along(df)) {
        out[i] <- fun(df[[i]])
    }
    out
}
# calculate median or mean
col_summary(df, median)
col_summary(df, mean)

# The goal of using purrr functions instead of for loops is to allow you
# to break common list manipulation challenges into independent
# pieces

# map function from purr package
map_dbl(df, mean)
map_dbl(df, median)
# use a pipe
df %>% map_dbl(mean)

# Base sapply() is a wrapper around lapply() that automatically
# simplifies the output.
x1 <- list(
    c(0.27, 0.37, 0.57, 0.91, 0.20),
    c(0.90, 0.94, 0.66, 0.63, 0.06),
    c(0.21, 0.18, 0.69, 0.38, 0.77)
)
x2 <- list(
    c(0.50, 0.72, 0.99, 0.38, 0.78),
    c(0.93, 0.21, 0.65, 0.13, 0.27),
    c(0.39, 0.01, 0.38, 0.87, 0.34)
)
threshold <- function(x, cutoff = 0.8) x[x > cutoff]
x1 %>% sapply(threshold) %>% str()

# safely() is an adverb: it takes a function (a verb) and returns a modified version. In this case, the modified
# function will never throw an error.
safe_log <- safely(log)
str(safe_log(10))
