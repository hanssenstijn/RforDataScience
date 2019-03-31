# get clean ws
rm(list=ls())

# load needed lib
library(nycflights13)
library(tidyverse)

# Compute cases per year
table1 %>%
    count(year, wt = cases)

# Visualize changes over time
ggplot(table1, aes(year, cases)) +
    geom_line(aes(group = country), color = "grey50") +
    geom_point(aes(color = country))
# separate() pulls apart one column into multiple columns, by splitting
# wherever a separator character appears.
table3 %>%
    separate(rate, into = c("cases", "population"))

# Another important tool for making missing values explicit in tidy
# data is complete():
stocks <- tibble(
    year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
    qtr = c( 1, 2, 3, 4, 2, 3, 4),
    return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
)

stocks %>%
    complete(year, qtr)

