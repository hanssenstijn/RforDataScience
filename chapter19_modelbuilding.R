# get clean ws
rm(list=ls())

# load lib
library(tidyverse)
library(modelr)
options(na.action = na.warn)
library(nycflights13)
library(lubridate)
library(hexbin)

# visualize data
ggplot(diamonds, aes(cut, price)) + geom_boxplot()
ggplot(diamonds, aes(color, price)) + geom_boxplot()
ggplot(diamonds, aes(clarity, price)) + geom_boxplot()

ggplot(diamonds, aes(carat, price)) +
    geom_hex(bins = 50)

# 1. Focus on diamonds smaller than 2.5 carats (99.7% of the data).
# 2. Log-transform the carat and price variables:
diamonds2 <- diamonds %>%
filter(carat <= 2.5) %>%
mutate(lprice = log2(price), lcarat = log2(carat))

ggplot(diamonds2, aes(lcarat, lprice)) +
        geom_hex(bins = 50)    

# create model
mod_diamond <- lm(lprice ~ lcarat, data = diamonds2)

# Note that I
# back-transform the predictions, undoing the log transformation, so
# I can overlay the predictions on the raw data:
grid <- diamonds2 %>%
    data_grid(carat = seq_range(carat, 20)) %>%
    mutate(lcarat = log2(carat)) %>%
    add_predictions(mod_diamond, "lprice") %>%
    mutate(price = 2 ^ lprice)
ggplot(diamonds2, aes(carat, price)) +
    geom_hex(bins = 50) +
    geom_line(data = grid, color = "red", size = 1)

# a more complicated model
mod_diamond2 <- lm(
    lprice ~ lcarat + color + cut + clarity,
    data = diamonds2
)
grid <- diamonds2 %>%
    data_grid(cut, .model = mod_diamond2) %>%
    add_predictions(mod_diamond2)
grid

ggplot(grid, aes(cut, pred)) +
    geom_point()

# develop residuals variable
diamonds2 <- diamonds2 %>%
    add_residuals(mod_diamond2, "lresid2")
# visualize
ggplot(diamonds2, aes(lcarat, lresid2)) +
    geom_hex(bins = 50)
# This plot indicates that there are some diamonds with quite large
# residuals-remember a residual of 2 indicates that the diamond is 4x
# the price that we expected. It's often useful to look at unusual values
# individually:
diamonds2 %>%
    filter(abs(lresid2) > 1) %>%
    add_predictions(mod_diamond2) %>%
    mutate(pred = round(2 ^ pred)) %>%
    select(price, pred, carat:table, x:z) %>%
    arrange(price)

# what affects the number of daily flights
# flights per day
daily <- flights %>%
    mutate(date = make_date(year, month, day)) %>%
    group_by(date) %>%
    summarize(n = n())
daily
# plot
ggplot(daily, aes(date, n)) +
    geom_line()

# day of week
daily <- daily %>%
    mutate(wday = wday(date, label = TRUE))
ggplot(daily, aes(wday, n)) +
    geom_boxplot()

# predict and overlay on the original data
mod <- lm(n ~ wday, data = daily)
grid <- daily %>%
    data_grid(wday) %>%
    add_predictions(mod, "n")
ggplot(daily, aes(wday, n)) +
    geom_boxplot() +
    geom_point(data = grid, color = "red", size = 3)
# compute and visualize the residuals
daily <- daily %>%
    add_residuals(mod)
daily %>%
    ggplot(aes(date, resid)) +
    geom_ref_line(h = 0) +
    geom_line()
# check which day is wrongly predicted
ggplot(daily, aes(date, resid, color = wday)) +
    geom_ref_line(h = 0) +
    geom_line()
# There are some days with far fewer flights than expected:
daily %>%
    filter(resid < -100)
# visualize trend with geom_smooth()
daily %>%
    ggplot(aes(date, resid)) +
    geom_ref_line(h = 0) +
    geom_line(color = "grey50") +
    geom_smooth(se = FALSE, span = 0.20)
# focus only on the saturdays
daily %>%
    filter(wday == "Sat") %>%
    ggplot(aes(date, n)) +
    geom_point() +
    geom_line() +
    scale_x_date(
        NULL,
        date_breaks = "1 month",
        date_labels = "%b"
    )
# Let's create a "term" variable that roughly captures the three school
# terms, and check our work with a plot:
term <- function(date) {
    cut(date,
        breaks = ymd(20130101, 20130605, 20130825, 20140101),
        labels = c("spring", "summer", "fall")
    )
}
daily <- daily %>%
    mutate(term = term(date))
daily %>%
    filter(wday == "Sat") %>%
    ggplot(aes(date, n, color = term)) +
    geom_point(alpha = 1/3) +
    geom_line() +
    scale_x_date(
        NULL,
        date_breaks = "1 month",
        date_labels = "%b"
    )
# collor based on term
daily %>%
    ggplot(aes(wday, n, color = term)) +
    geom_boxplot()
# imrpove the model using the term variable
mod1 <- lm(n ~ wday, data = daily)
mod2 <- lm(n ~ wday * term, data = daily)
daily %>%
    gather_residuals(without_term = mod1, with_term = mod2) %>%
    ggplot(aes(date, resid, color = model)) +
    geom_line(alpha = 0.75)

grid <- daily %>%
    data_grid(wday, term) %>%
    add_predictions(mod2, "n")
ggplot(daily, aes(wday, n)) +
    geom_boxplot() +
    geom_point(data = grid, color = "red") +
    facet_wrap(~ term)

# using a model that is robust to outliers MASS::rlm()
mod3 <- MASS::rlm(n ~ wday * term, data = daily)
daily %>%
    add_residuals(mod3, "resid") %>%
    ggplot(aes(date, resid)) +
    geom_hline(yintercept = 0, size = 2, color = "white") +
    geom_line()
