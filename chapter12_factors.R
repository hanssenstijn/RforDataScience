# get clean ws
rm(list=ls())

# load needed lib
library(tidyverse)
library(forcats)

# create factors
x1 <- c("Dec", "Apr", "Jan", "Mar")
# sort it alphabatic
sort(x1)
# creat month order
month_levels <- c(
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

y1 <- factor(x1, levels = month_levels)
y1
sort(y1)

# general social survey
gss_cat

# count race
gss_cat %>%
    count(race)
# visalize
ggplot(gss_cat, aes(race)) +
    geom_bar()
# force to see the non value factors
ggplot(gss_cat, aes(race)) +
    geom_bar() +
    scale_x_discrete(drop = FALSE)
# create relig
relig <- gss_cat %>%
    group_by(relig) %>%
    summarize(
        age = mean(age, na.rm = TRUE),
        tvhours = mean(tvhours, na.rm = TRUE),
        n = n()
    )
# unorderd
ggplot(relig, aes(tvhours, relig)) + geom_point()
# orderded using fct_reorder()
ggplot(relig, aes(tvhours, fct_reorder(relig, tvhours))) +
    geom_point()
# fct_infreq() to order levels in increasing frequencies
gss_cat %>%
    mutate(marital = marital %>% fct_infreq() %>% fct_rev()) %>%
    ggplot(aes(marital)) +
    geom_bar()

# modifying factor levels ; fct_recode
gss_cat %>%
    mutate(partyid = fct_recode(partyid,
                                "Republican, strong" = "Strong republican",
                                "Republican, weak" = "Not str republican",
                                "Independent, near rep" = "Ind,near rep",
                                "Independent, near dem" = "Ind,near dem",
                                "Democrat, weak" = "Not str democrat",
                                "Democrat, strong" = "Strong democrat"
    )) %>%
    count(partyid)

# fct_lump() ; lump together all the small groups to make a plot simpler
gss_cat %>%
    mutate(relig = fct_lump(relig)) %>%
    count(relig)

gss_cat %>%
    mutate(relig = fct_lump(relig, n = 10)) %>%
    count(relig, sort = TRUE) %>%
    print(n = Inf)

