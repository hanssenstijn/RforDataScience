# get clean ws
rm(list=ls())

# load needed lib
library(nycflights13)
library(tidyverse)

# "package"::function/data
nycflights13::flights

# filter argument
filter(flights, month == 1, day == 1)

# Select columns by name
select(flights, year, month, day)

# rename variable
rename(flights, tail_num = tailnum)

# Another option is to use select() in conjunction with the every
# thing() helper. This is useful if you have a handful of variables
# you'd like to move to the start of the data frame:
select(flights, time_hour, air_time, everything())


