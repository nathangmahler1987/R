### R ggplot basics Asg ----
#Nathan Mahler INFO 4130
library(tidyverse)
library(lubridate)
library(tidyquant)
# ggplot(data=D) +  
#   geom_function(mapping = aes()) This is kind of the general formula for graphing in ggplot

contrib <- read.csv("C:/Users/natem/Desktop/INFO_4130/Mod3/contrib.csv", stringsAsFactors=TRUE)


glimpse(contrib)

# 1.0 Scatter Plots ----
# - Good for visualizing relationship between 2 Continuous Variables
# Q: what is the relationship between the amount a person gave in year 00 to that given in year 04?
# Scatter Plot
contrib %>% 
  ggplot(aes(x=FY04Giving,y=FY00Giving)) +
  geom_point(alpha=0.5,size=5, color="blue") + 
  geom_smooth(method = lm, se= FALSE)

cor(contrib$FY04Giving, contrib$FY00Giving)

# 2.0 Line Plots ----
# - Good for time series
# Data Manipulation


# Line Plot


# 3.0 Bar / Column Plots ----
# Good for 1 categorical var and 1 continuous (summarized) variable

# Bar Plot

# 4.0 Histograms / Density Plots ----
# - Shows the distribution of a continuous (granular) variable

# Histogram


# Faceted Histogram
# Shows a histogram segmented by categorical variable

# Histogram


# Density Plot


# 5.0 Box Plot / Violin Plot ----
# - Good for comparing distributions (granular data) with lots of categories

# Box Plot




# Violin Plot & Jitter Plot


# 6.0 Adding Text & Labels ----

# Adding text to bar chart


# Adding labels (text in a rectangle) to a bar chart



# 7.0 Scales x and y----
# Edits x and y axis scaling



