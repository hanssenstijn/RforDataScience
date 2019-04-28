# get clean ws
rm(list=ls())

#load lib
library(tidyverse)
library(modelr)

# do not silently drop missing values.
options(na.action = na.warn)

ggplot(sim1, aes(x, y)) +
    geom_point()

# Transformations
# If your transformation involves +, *, ^, or -, you'll need to wrap it in I() so R doesn't treat it like part
# of the model specification.
df <- tribble(
    ~y, ~x,
    1, 1,
    2, 2,
    3, 3
)
# Again, if you get confused about what your model is doing, you can
# always use model_matrix() to see exactly what equation lm() is fitting:
# doesn'tt work....
model_matrix(df, y ~ x^2 + x)
# need to wrap it in I()
model_matrix(df, y ~ I(x^2) + x)
# polynomial function
model_matrix(df, y ~ poly(x, 2))
# However there's one major problem with using poly(): outside the
# range of the data, polynomials rapidly shoot off to positive or negative
# infinity. One safer alternative is to use the natural spline,
# splines::ns():
library(splines)
model_matrix(df, y ~ ns(x, 2))

# try to approximate a non-linear function
sim5 <- tibble(
    x = seq(0, 3.5 * pi, length = 50),
    y = 4 * sin(x) + rnorm(length(x))
)
ggplot(sim5, aes(x, y)) +
    geom_point()

# I'm going to fit five models to this data:
mod1 <- lm(y ~ ns(x, 1), data = sim5)
mod2 <- lm(y ~ ns(x, 2), data = sim5)
mod3 <- lm(y ~ ns(x, 3), data = sim5)
mod4 <- lm(y ~ ns(x, 4), data = sim5)
mod5 <- lm(y ~ ns(x, 5), data = sim5)

grid <- sim5 %>%
    data_grid(x = seq_range(x, n = 50, expand = 0.1)) %>%
    gather_predictions(mod1, mod2, mod3, mod4, mod5, .pred = "y")
ggplot(sim5, aes(x, y)) +
    geom_point() +
    geom_line(data = grid, color = "red") +
    facet_wrap(~ model)

# Handeling missing values
# R's default behavior is to silently drop them
# but options(na.action = na.warn), makes sure you get a warning:
df <- tribble(
    ~x, ~y,
    1, 2.2,
    2, NA,
    3, 3.5,
    4, 8.3,
    NA, 10
)
mod <- lm( y ~x, data = df)

# To suppress the warning, set na.action = na.exclude:
mod <- lm(y ~ x, data = df, na.action = na.exclude)
# You can always see exactly how many observations were used with
# nobs():
nobs(mod)
