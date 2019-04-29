# get clean ws
rm(list=ls())

# load lib
library(modelr)
library(tidyverse)
library(gapminder)

# data
gapminder

#plot change over time
gapminder %>%
    ggplot(aes(year, lifeExp, group = country)) +
    geom_line(alpha = 1/3)

nz <- filter(gapminder, country == "New Zealand")
nz %>%
    ggplot(aes(year, lifeExp)) +
    geom_line() +
    ggtitle("Full data = ")
nz_mod <- lm(lifeExp ~ year, data = nz)
nz %>%
    add_predictions(nz_mod) %>%
    ggplot(aes(year, pred)) +
    geom_line() +
    ggtitle("Linear trend + ")
nz %>%
    add_residuals(nz_mod) %>%
    ggplot(aes(year, resid)) +
    geom_hline(yintercept = 0, color = "white", size = 3) +
    geom_line() +
    ggtitle("Remaining pattern")

# create nested data
by_country <- gapminder %>%
    group_by(country, continent) %>%
    nest()
by_country
# look at first list
by_country$data[[1]]

# model fitting function
country_model <- function(df) {
    lm(lifeExp ~ year, data = df)
}
# use purrr::map() to apply country_model to each element
models <- map(by_country$data, country_model)

# store models immdiately
by_country <- by_country %>%
    mutate(model = map(data, country_model))
by_country
# add residuals
by_country <- by_country %>%
    mutate(
        resids = map2(data, model, add_residuals)
    )
by_country

# unnest
resids <- unnest(by_country, resids)
resids

# plot residuals
resids %>%
    ggplot(aes(year, resid)) +
    geom_line(aes(group = country), alpha = 1 / 3) +
    geom_smooth(se = FALSE)

# by continent
resids %>%
    ggplot(aes(year, resid, group = country)) +
    geom_line(alpha = 1 / 3) +
    facet_wrap(~continent)

# broom package to extract some model quality metrics
broom::glance(nz_mod)
