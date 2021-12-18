library(tidyverse)
library(dslabs)
data(brexit_polls)
p <- 0.481    # official proportion voting "Remain"
d <- 2*p-1    # official spread
N<- 1500
expected <- p*N
se_remain <- sqrt(N * p * (1 - p))
x_hat <- p
standard_error_x_hat <- sqrt(x_hat * (1-x_hat)/N)
d<- 2*p-1
d
se_d <- 2 * standard_error_x_hat
se_d
brexit_polls <- brexit_polls %>% 
  mutate(x_hat = (spread + 1) /2)
mean(brexit_polls$spread)
sd(brexit_polls$spread)
mean(brexit_polls$x_hat)
sd(brexit_polls$x_hat)
you_gov <- brexit_polls[1,]
x_hat <- 0.52
N <- 4722
se <- sqrt(x_hat * (1-x_hat) / N)
ci <- c(x_hat - qnorm(0.975) * se, x_hat + qnorm(0.975) * se)
ci
june_polls <- brexit_polls %>% filter(enddate >= '2016-06-1')
nrow(june_polls)
d <- -0.38
june_polls <- june_polls %>%
  mutate(se_x_hat = sqrt(x_hat * (1-x_hat)/ samplesize), se_spread = 2*se_x_hat,
         lower = spread - qnorm(0.975) * se_spread,
         upper = spread + qnorm(0.975) * se_spread,
         hit = (lower < 2*p-1 & upper > 2*p-1))
mean(june_polls$lower < 0 & june_polls$upper > 0)
mean(june_polls$lower > 0 & june_polls$upper > 0)
mean(june_polls$hit)
june_polls %>%
  group_by(pollster) %>%
  summarize(hit_rate=mean(hit), n()) %>%
  arrange(hit_rate)
june_polls %>% group_by(poll_type) %>%
  ggplot(aes(poll_type,spread)) +
  geom_boxplot()


combined_by_type <- june_polls %>%
  group_by(poll_type) %>%
  summarize(N = sum(samplesize),
            spread = sum(spread*samplesize)/N,
            p_hat = (spread + 1)/2,
            se_spread = 2*sqrt(p_hat*(1-p_hat)/N),
            spread_lower = spread - qnorm(.975)*se_spread,
            spread_upper = spread + qnorm(.975)*se_spread)
combined_by_type %>%
  filter(poll_type == "Online") %>%
  pull(spread_lower)
combined_by_type %>%
  filter(poll_type == "Online") %>%
  pull(spread_upper)

brexit_hit <- brexit_polls %>%
  mutate(p_hat = (spread + 1)/2,
         se_spread = 2*sqrt(p_hat*(1-p_hat)/samplesize),
         spread_lower = spread - qnorm(.975)*se_spread,
         spread_upper = spread + qnorm(.975)*se_spread,
         hit = spread_lower < d & spread_upper > d) %>%
  select(poll_type, hit)


brexit_chisq <- table(brexit_hit$poll_type, brexit_hit$hit)
chisq.test(brexit_chisq)$p.value





# from previous question
brexit_chisq <- table(brexit_hit$poll_type, brexit_hit$hit)

# convert to data frame
chisq_df <- as.data.frame(brexit_chisq)

online_true <- chisq_df$Freq[chisq_df$Var1 == "Online" & chisq_df$Var2 == "TRUE"]
online_false <- chisq_df$Freq[chisq_df$Var1 == "Online" & chisq_df$Var2 == "FALSE"]

online_odds <- online_true/online_false
online_odds


phone_true <- chisq_df$Freq[chisq_df$Var1 == "Telephone" & chisq_df$Var2 == "TRUE"]
phone_false <- chisq_df$Freq[chisq_df$Var1 == "Telephone" & chisq_df$Var2 == "FALSE"]

phone_odds <- phone_true/phone_false
phone_odds