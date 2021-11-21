library(dslabs)
library(tidyverse)
data(gapminder)
gapminder <- gapminder %>%  mutate(dollars_per_day = gdp/population/365)
past_year <- 1970
gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) + 
  geom_histogram(binwidth = 1, color = "white")
###apply a log base 2 transform
#we use log transformation for skewed data ( positive curve (tail to right side) & negative curve ( tail to left side))
gapminder %>% 
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(log2(dollars_per_day))) + 
  geom_histogram(binwidth = 1, color = "black")
