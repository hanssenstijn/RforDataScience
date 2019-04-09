# get clean ws
rm(list=ls())

# load needed lib
library(tidyverse)
library(stringr)

# You can create strings with either single quotes or double quotes.
string1 <- "This is a string"
string2 <- 'To put a "quote" inside a string, use single quotes'
double_quote <- "\"" # or '"'
single_quote <- '\'' # or "'"

# To see the raw contents of the string, use writeLines():
writeLines(string1)

# There are a handful of other special characters. The most common
# are "\n", newline, and "\t", tab, but you can see the complete list by
# requesting help on ?'"', or ?"'".

# Multiple strings are often stored in a character vector, which you
# can create with c():
c("one", "two", "three")

# str_length() tells you the number of characters in a string:
str_length(c("a", "R for data science", NA))

# To combine two or more strings, use str_c():
str_c("x", "y")

# Use the sep argument to control how they're separated:
str_c("x", "y", sep = ", ")

# If you want them to print as "NA", use str_replace_na():
x <- c("abc", NA)
str_c("|-", str_replace_na(x), "-|")

# You can extract parts of a string using str_sub(). As well as the
# string, str_sub() takes start and end arguments that give the
# (inclusive) position of the substring:
x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
# negative numbers count backwards from end
str_sub(x, -3, -1)

#sort/order
x <- c("apple", "eggplant", "banana")
str_sort(x, locale = "en")

#The simplest patterns match exact strings:
x <- c("apple", "banana", "pear")
str_view(x, "an")
str_view(x, ".a.")

# ^ to match the start of the string.
# $ to match the end of the string.
x <- c("apple", "banana", "pear")
str_view(x, "^a")
str_view(x, "a$")

# . \d matches any digit.
# . \s matches any whitespace (e.g., space, tab, newline).
# . [abc] matches a, b, or c.
# . [^abc] matches anything except a, b, or c.
str_view(c("grey", "gray"), "gr(e|a)y")

# The next step up in power involves controlling how many times a
# pattern matches:
# . ?: 0 or 1
# . +: 1 or more
# . *: 0 or more
x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")
str_view(x, "CC+")
str_view(x, 'C[LX]+')

# You can also specify the number of matches precisely:
# . {n}: exactly n
# . {n,}: n or more
# . {,m}: at most m
# . {n,m}: between n and m
str_view(x, "C{2}")
str_view(x, "C{2,}")
str_view(x, "C{2,3}")
str_view(x, 'C{2,3}?')
str_view(x, 'C[LX]+?')

# To determine if a character vector matches a pattern, use
# str_detect(). It returns a logical vector the same length as the
# input:
x <- c("apple", "banana", "pear")
str_detect(x, "e")
# How many common words start with t?
sum(str_detect(words, "^t"))
# What proportion of common words end with a vowel?
mean(str_detect(words, "[aeiou]$"))

# str_replace() and str_replace_all() allow you to replace
# matches with new strings. The simplest use is to replace a pattern
# with a fixed string:
x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-")

# You can use the other arguments of regex() to control details of the
# match:
# . ignore_case = TRUE allows characters to match either their
# uppercase or lowercase forms. This always uses the current
# locale:
bananas <- c("banana", "Banana", "BANANA")
str_view(bananas, regex("banana", ignore_case = TRUE))

