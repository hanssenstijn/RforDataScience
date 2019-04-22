# get clean ws
rm(list=ls())

# load needed lib
# install.packages("magrittr")
library(magrittr)
# install.packages("pryr")
library(pryr)

diamonds <- ggplot2::diamonds
diamonds2 <- diamonds %>%
    dplyr::mutate(price_per_carat = price / carat)

# check size object
pryr::object_size(diamonds)
pryr::object_size(diamonds, diamonds2)

# making adjustments increases the size!
diamonds$carat[1] <- NA
pryr::object_size(diamonds, diamonds2)

# pipe that gives no outcome for the second command
rnorm(100) %>%
    matrix(ncol = 2) %>%
    plot() %>%
    str()

# using %T>% which does give the output of the second line
rnorm(100) %>%
    matrix(ncol = 2) %T>%
    plot() %>%
    str()

