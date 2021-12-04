
library(caret)
library(tidyverse)
library(rpart)
library(rpart.plot)

library(titanic)

titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>%
  mutate(Survived = factor(Survived),
         Pclass = factor(Pclass),
         Sex = factor(Sex))
###Question 2: Demographics of Titanic Passengers

total <- titanic %>%
  filter(Sex %in% c("female","male")) %>%
  count(Sex)
total

age40 <- titanic %>%
  filter(Age == 40 & Sex %in% c("female","male")) %>%
  count(Sex)
age40

max_age <- titanic %>%
  filter(!is.na(Age)) %>%
  group_by(Sex) %>%
  summarize(max = max(Age))
max_age

titanic %>%
  filter(!is.na(Age)) %>%
  ggplot(aes(x = Age, group = Sex, fill = Sex)) + 
  geom_density(alpha = 0.2, bw = 10) 

params <- titanic %>%
  filter(!is.na(Age)) %>%
  summarize(mean = mean(Age), sd = sd(Age))

p <- titanic %>%
  ggplot(aes(sample = Age)) +
  geom_qq(dparams = params) +
  geom_abline()
p
p <- titanic %>%
  ggplot(aes(x = Survived, fill = Sex)) +
  geom_bar(position = position_dodge())
p

p <- titanic %>%
  ggplot(aes(x = Age, y = ..count.., fill = Survived)) +
  geom_density(alpha = 0.2)
p