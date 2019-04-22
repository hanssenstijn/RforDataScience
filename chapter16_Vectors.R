# get clean ws
rm(list=ls())

#load lib
library(tidyverse)

# There are two types of vectors:
#     . Atomic vectors, of which there are six types: logical, integer, double,
# character, complex, and raw. Integer and double vectors are
# collectively known as numeric vectors.
#     . Lists, which are sometimes called recursive vectors because lists
# can contain other lists.

# The chief difference between atomic vectors and lists is that atomic
# vectors are homogeneous, while lists can be heterogeneous.

# check type
typeof(letters)
# check length
x <- list("a", "b", 1:10)
length(x)

# Coercion
# There are two ways to convert, or coerce, one type of vector to
# another:
# . Explicit coercion happens when you call a function like as.logi
# cal(), as.integer(), as.double(), or as.character(). Whenever
# you find yourself using explicit coercion, you should
# always check whether you can make the fix upstream, so that
# the vector never had the wrong type in the first place. For example,
# you may need to tweak your readr col_types specification.
# . Implicit coercion happens when you use a vector in a specific
# context that expects a certain type of vector. For example, when
# you use a logical vector with a numeric summary function, or
# when you use a double vector where an integer vector is
# expected.

# It's also important to understand what happens when you try and
# create a vector containing multiple types with c()-the most complex
# type always wins:
typeof(c(TRUE, 1L))
typeof(c(1L, 1.5))
typeof(c(1.5, "a"))

# nameing vectors
set_names(1:3, c("a", "b", "c"))

# attributes
attr(x, "greeting") <- "Hi!"
attr(x, "farewell") <- "Bye!"
attributes(x)

