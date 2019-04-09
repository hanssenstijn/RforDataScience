# get clean ws
rm(list=ls())

# load needed lib
library(nycflights13)
library(tidyverse)

#data
airlines
airports
planes
weather

# Once you've identified the primary keys in your tables, it's good
# practice to verify that they do indeed uniquely identify each observation.
# One way to do that is to count() the primary keys and look
# for entries where n is greater than one
planes %>%
    count(tailnum) %>%
    filter(n > 1)
weather %>%
    count(year, month, day, hour, origin) %>%
    filter(n > 1)

# mutating joins
flights2 <- flights %>%
    select(year:day, hour, origin, dest, tailnum, carrier)
flights2
# left join with other dataset
flights2 %>%
    select(-origin, -dest) %>%
    left_join(airlines, by = "carrier")
# mutate creat new variable
flights2 %>%
    select(-origin, -dest) %>%
    mutate(name = airlines$name[match(carrier, airlines$carrier)])

# understanding joins
x <- tribble(
    ~key, ~val_x,
    1, "x1",
    2, "x2",
    3, "x3"
)
y <- tribble(
    ~key, ~val_y,
    1, "y1",
    2, "y2",
    4, "y3"
)

# The simplest type of join is the inner join. An inner join matches
# pairs of observations whenever their keys are equal:
x %>%
    inner_join(y, by = "key")

# An outer join keeps observations that appear in at least one of the tables.
# There are three types of outer joins:
#  A left join keeps all observations in x.
#  A right join keeps all observations in y.
#  A full join keeps all observations in x and y.

# duplicated keys
x <- tribble(
    ~key, ~val_x,
    1, "x1",
    2, "x2",
    2, "x3",
    1, "x4"
)
y <- tribble(
    ~key, ~val_y,
    1, "y1",
    2, "y2"
)
left_join(x, y, by = "key")

# The default, by = NULL, uses all variables that appear in both
# tables, the so-called natural join.
flights2 %>%
    left_join(weather)

# join by specific column
flights2 %>%
    left_join(planes, by = "tailnum")

# A named character vector: by = c("a" = "b"). This will match
# variable a in table x to variable b in table y.
flights2 %>%
    left_join(airports, c("dest" = "faa"))

#filtering joins
# . semi_join(x, y) keeps all observations in x that have a match
# in y.
# . anti_join(x, y) drops all observations in x that have a match
# in y.
# select top destinations
top_dest <- flights %>%
    count(dest, sort = TRUE) %>%
    head(10)
top_dest
# only keep the rows in x that have a match in y
flights %>%
    semi_join(top_dest)
# the inverse
flights %>%
    anti_join(planes, by = "tailnum") %>%
    count(tailnum, sort = TRUE)
