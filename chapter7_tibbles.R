# get clean ws
rm(list=ls())

# load needed lib
library(nycflights13)
library(tidyverse)

# load iris as tible
as_tibble(iris)

# create a tible
tibble(
    x = 1:5,
    y = 1,
    z = x ^ 2 + y
)

# create a tible --> may have all column names
tb <- tibble(
    `:)` = "smile",
    ` ` = "space",
    `2000` = "number"
)
tb

# transposed tibble --> tribble()
tribble(
    ~x, ~y, ~z,
    #--|--|----
    "a", 2, 3.6,
    "b", 1, 8.5
)

# print() the data frame and control the
# number of rows (n) and the width of the display. width = Inf will
# display all columns:
nycflights13::flights %>%
    print(n = 10, width = Inf)

# to get a scroallable view
nycflights13::flights %>%
    View()

# create tibble
df <- tibble(
    x = runif(5),
    y = rnorm(5)
)
# extract only x
df %>% .$x
