#GGRIDGES
library(ggridges)
p <- gapminder %>% 
  filter(year == past_year & !is.na(dollars_per_day)) %>%
  ggplot(aes(dollars_per_day, group)) + 
  scale_x_continuous(trans = "log2") 
p  + geom_density_ridges(jittered_points = TRUE) 
p + geom_density_ridges(jittered_points = TRUE, 
                        position = position_points_jitter(height = 0),
                        point_shape = '|', point_size = 3, 
                        point_alpha = 1, alpha = 0.7)
