#Nathan Mahler INFO 4130
#This EDA in general follows Def 3 where the goal of EDA is to facilitate a general
#understanding of the data. While Defs 1&2 presence are definitely felt I felt that Def 3 was the more overiding motivation here. 
#load needed packages and data
library(tidyverse)
#basic summary of data
summary(diamonds)
#see structure of data
str(diamonds)
#simple bar chart w/ cut
ggplot(data = diamonds) + 
  geom_bar(mapping=aes(x=cut))
#simple bar chart w/ color
ggplot(data = diamonds) + 
  geom_bar(mapping=aes(x=color))
#simple bar chart w/ clarity
ggplot(data = diamonds) + 
  geom_bar(mapping=aes(x=clarity))
# the distribution with clarity looks skewed. The data is definitely right-tailed.
#I1 data looks different, I will try to dive deeper into that area. 
#verify this with actual numbers
diamonds %>% count(clarity)
#First, I need to learn a little bit about diamond clarity.
# this site from the american gem society https://www.americangemsociety.org/page/clarityscale was useful.
#assign to an object
numberOfDiamondsPerClarityGroup <- diamonds %>% count(clarity)
numberOfDiamondsPerClarityGroup
#Isolate I1
I1NumberOfDiamondsPerClarityGroup <- numberOfDiamondsPerCarityGroup[1,]
#isolate and store info as data frame
dfnumberOfDiamondsPerClarityGroup <- as.data.frame(numberOfDiamondsPerClarityGroup[1,])
#Validate
dfnumberOfDiamondsPerClarityGroup
#The above lines of code, while not necessarily a part of my EDA were a good learning exercise.
#lines 14&15 showed the most interesting trend in my opinion (it was the trend about clarity).
#The below lines of code showed a different type of graph I had not used before so I wanted to run it.
smaller <- diamonds %>% 
  filter(carat < 3)
ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.1)
ggplot(data = smaller, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)
# The below code will allow us to see outliers in graphical from
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))
#The below code will allow us to view the individual outlier data points
unusual <- diamonds %>% 
  filter(y < 3 | y > 20) %>% 
  select(price, x, y, z) %>%
  arrange(y)
unusual
#rows 8&9 are unusual. Why?
#The below code will allow me to change the outliers with missing values since I can't explain them
diamonds2 <- diamonds %>% 
  mutate(y=ifelse(y<3 | y >20, NA,y))
