
library(dslabs)
library(tidyverse)
data(gapminder)
### Fixed scales for better comparisons

filter(gapminder, year%in%c(1962, 2012)) %>%
  ggplot(aes(fertility, life_expectancy, col = continent)) +
  geom_point() +
  facet_wrap(. ~ year, scales = "free")

###Time series plots
gapminder %>% 
  filter(country == "United States") %>% 
  ggplot(aes(year, fertility)) +
  geom_point()
###to make it linear and join these points to create curve
gapminder %>% 
  filter(country == "United States") %>% 
  ggplot(aes(year, fertility)) +
  geom_line()
###curves for 2 diff country

countries <- c("South Korea","Germany")

gapminder %>% filter(country %in% countries) %>% 
  ggplot(aes(year,fertility)) +
  geom_line()
###for two seperate curve
countries <- c("South Korea","Germany")

gapminder %>% filter(country %in% countries & !is.na(fertility)) %>% 
  ggplot(aes(year, fertility, col = country)) +
  geom_line()

###labelling : define a data table with the label
labels <- data.frame(country = countries, x = c(1975,1965), y = c(60,72))
gapminder %>% 
  filter(country %in% countries) %>% 
  ggplot(aes(year, life_expectancy, col = country)) +
  geom_line() +
  geom_text(data = labels, aes(x, y, label = country), size = 5) +
  theme(legend.position = "none")
