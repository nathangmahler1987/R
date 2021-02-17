#Nathan Mahler INFO 4130
#This EDA in general follows Def 3 where the goal of EDA is to facilitate a general
#understanding of the data. While Defs 1&2 presence are definitely felt I felt that Def 3 was the more overiding motivation here. 
#load needed packages and data
library(tidyverse)
#basic summary of data
summary(diamonds)
#Which values are the most common? Why. Premium cuts are the most common, possibly because they are the easiest to mark-up
diamonds %>% count(cut)
#Which values are rare? Why? Does that match your expectations? No I expected fair diamonds to be the most common
#Can you see any unusual patterns? What might explain them?
#see structure of data
str(diamonds)
#simple bar chart w/ cut
ggplot(data = diamonds) + 
  geom_bar(mapping=aes(x=cut))
#simple bar chart w/ color
ggplot(data = diamonds) + 
  geom_bar(mapping=aes(x=color))
#simple bar chart w/ clarity
#Can you see any unusual patterns? What might explain them?
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
#How are the observations within each cluster similar to each other?
#How are the observations in separate clusters different from each other?
#How can you explain or describe the clusters?
ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.1)
ggplot(data = smaller, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)
# The below code will allow us to see outliers in graphical from
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))
#The below code will allow us to view the individual outlier data points
#Why might the appearance of clusters be misleading? They could be simple data entry errors.
unusual <- diamonds %>% 
  filter(y < 3 | y > 20) %>% 
  select(price, x, y, z) %>%
  arrange(y)
unusual
#rows 8&9 are unusual. Why?
#The below code will allow me to change the outliers with missing values since I can't explain them
diamonds2 <- diamonds %>% 
  mutate(y=ifelse(y<3 | y >20, NA,y))
#plot the diamonds2 dataset, that has taken out the outliers
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + 
  geom_point()
#It took me a second to realize what I was looking at, as my first thought was "Why is there still that outlier at zero?"
#then I realized I filter on y not on x:)
# the below line of code standardizes the count so we can easier see a comparison of distributions.
#What is this  "..density.."syntax? I do not feel I understand density as well as I should
#Could this pattern be due to coincidence (i.e. random chance)? I guess there is always a chance it vould be random, but what is the probability.
#How can you describe the relationship implied by the pattern? positive linear
#How strong is the relationship implied by the pattern? strong
ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)
#review data
str(diamonds)
#box plot to more effectively see outliers
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot() +
  coord_flip()
numberOfFairDiamonds <- as.data.frame(diamonds %>% count(cut) %>% select(n))
#Interesting that the fair cut has a lot of outliers.
numberOfFairDiamonds
str(numberOfFairDiamonds)
#I want the number of fair diamonds in it's own data set since I would like to graph it
numberOfFairDiamonds1 <- numberOfFairDiamonds[1,]
numberOfFairDiamonds1
#can I graph this?
#They showed this in the book and it looks interesting
#Does the relationship change if you look at individual subgroups of the data?
ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color))
#What other variables might affect the relationship?
#clarity 
  