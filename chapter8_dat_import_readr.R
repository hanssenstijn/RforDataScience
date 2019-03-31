# get clean ws
rm(list=ls())

# load needed lib
library(nycflights13)
library(tidyverse)

# read csv
read_csv("a,b,c
1,2,3
4,5,6")

# You can use skip = n to skip the first n lines; or use
# comment = "#" to drop all lines that start with (e.g.) #:
# skip first 2 lines
read_csv("The first line of metadata
The second line of metadata
x,y,z
1,2,3", skip = 2)
# skip al lines that start with '#'
read_csv("# A comment I want to skip
x,y,z
1,2,3", comment = "#")
# to not treat the first row as headings
read_csv("1,2,3\n4,5,6", col_names = FALSE)

# Another option that commonly needs tweaking is na. This specifies
# the value (or values) that are used to represent missing values in
# your file:
read_csv("a,b,c\n1,2,.", na = ".")

# The parse_*() functions.
# These functions take a character vector and return a more specialized
# vector like a logical, integer, or date:
str(parse_logical(c("TRUE", "FALSE", "NA")))
str(parse_integer(c("1", "2", "3")))
str(parse_date(c("2010-01-01", "1979-10-14")))
parse_integer(c("1", "231", ".", "456"), na = ".")
# parse number
parse_double("1,23", locale = locale(decimal_mark = ","))
# In R, we can get at the underlying representation of a
# string using charToRaw():
charToRaw("Hadley")

