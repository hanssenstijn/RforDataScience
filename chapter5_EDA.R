# get clean ws
rm(list=ls())

# load needed lib
library(tidyverse)
library(nycflights13)
library(gapminder)
library(Lahman)

# geom_reqpoly --> using if you wish to overlay multiple histograms in the same plot
smaller <- diamonds %>% filter(carat < 3) 
ggplot(data = smaller,mapping=aes(x=carat))+ geom_histogram(binwidth = 0.1)
ggplot(data = smaller, mapping = aes(x = carat, color = cut)) +
    geom_freqpoly(binwidth = 0.1)

# Instead of displaying count, we'll display density,
# which is the count standardized so that the area under each frequency polygon is one
ggplot(data = diamonds,mapping = aes(x = price, y = ..density..)) +
    geom_freqpoly(mapping = aes(color = cut), binwidth = 500)
