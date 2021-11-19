library(tidyverse)
library(dslabs)
data(gapminder)
filter(gapminder, year == 1962) %>%
  ggplot(aes(fertility, life_expectancy)) +
  geom_point()