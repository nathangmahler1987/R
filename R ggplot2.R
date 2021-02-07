### ggplot basics ----
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
TotalContribByYear <- contrib %>% 
  group_by(Class.Year) %>% 
  summarise(TotalAmount= sum(FY04Giving,FY03Giving,FY02Giving,FY01Giving,FY00Giving)) %>% 
  ungroup()
View(TotalContribByYear)

TotalContribByMajor <- contrib %>% 
  group_by(Major) %>% 
  summarise(TotalAmount= sum(FY04Giving,FY03Giving,FY02Giving,FY01Giving,FY00Giving)) %>% 
  ungroup()
View(TotalContribByMajor)
# Line Plot
TotalContribByYear %>% 
  ggplot(aes(x=Class.Year, y= TotalAmount)) +
  geom_line(size=3,color="red")

# 3.0 Bar / Column Plots ----
# Good for 1 categorical var and 1 continuous (summarized) variable
# Bar Plot
TotalContribByYear %>% 
  mutate(Class.Year = Class.Year %>% as_factor %>% fct_reorder(TotalAmount)) %>% 
  ggplot(aes(Class.Year, TotalAmount)) +
  geom_col(size=3,fill="skyblue")+
  coord_flip()

TotalContribByMajor %>% 
  ggplot(aes(Major, TotalAmount)) +
  geom_col(size=3,fill="skyblue")+
  coord_flip()
# 4.0 Histograms / Density Plots ----
# - Shows the distribution of a continuous (granular) variable
# Histogram
contrib %>% 
  ggplot(aes(FY04Giving))+ # make sure this is a plus sign not %>%. 
  #Whenever we are adding layers we need a + not %>% 
  geom_histogram(bins = 10)

# Faceted Histogram
# Shows a histogram segmented by categorical variable
# Histogram
contrib %>% 
  mutate(Class.Year = Class.Year %>% as_factor()) %>% 
  ggplot(aes(FY04Giving,fill=Class.Year)) +
  geom_histogram()+
  facet_wrap(~Class.Year, ncol=1)+
  scale_fill_tq()+
  theme_tq()
# Density Plot
contrib %>%
  filter(FY04Giving<250) %>% 
  mutate(Class.Year = Class.Year %>% as_factor()) %>% 
  ggplot(aes(FY04Giving,fill=Class.Year)) +
  geom_density(alpha=.5)

# 5.0 Box Plot / Violin Plot ----
# - Good for comparing distributions (granular data) with lots of categories
# Box Plot
contrib %>% 
  filter(FY04Giving<300) %>% 
  mutate(Class.Year = Class.Year %>% as_factor()) %>% 
  ggplot(aes(Class.Year,FY04Giving))+
  geom_boxplot()+
  coord_flip()
  
contrib %>% 
  filter(FY04Giving<300) %>% 
  ggplot(aes(Major,FY04Giving))+
  geom_boxplot()+
  coord_flip()

contrib %>% 
  filter(FY04Giving<300) %>% 
  ggplot(aes(Next.Degree,FY04Giving))+
  geom_boxplot()+
  coord_flip()

contrib %>% 
  filter(FY04Giving<300) %>% 
  mutate(AttendenceEvent=AttendenceEvent %>% as_factor()) %>% 
  ggplot(aes(AttendenceEvent,FY04Giving))+
  geom_boxplot()+
  coord_flip()

# Violin Plot & Jitter Plot
contrib %>% 
  filter(FY04Giving<300) %>% 
  mutate(Class.Year = Class.Year %>% as_factor()) %>% 
  ggplot(aes(Class.Year,FY04Giving))+
  geom_violin()+
  geom_jitter(width=.08, color = "blue")+
  coord_flip()

# 6.0 Adding Text & Labels ----
# Adding text to bar chart
TotalContribByYear %>% 
  mutate(Class.Year = Class.Year %>% as_factor %>% fct_reorder(TotalAmount)) %>% 
  ggplot(aes(Class.Year, TotalAmount)) +
  geom_col(size=3,fill="skyblue")+
  geom_text(aes(label=scales::dollar(TotalAmount)), vjust =-2)+
  theme_tq()
# Adding labels (text in a rectangle) to a bar chart
TotalContribByYear %>% 
  mutate(Class.Year = Class.Year %>% as_factor %>% fct_reorder(TotalAmount)) %>% 
  ggplot(aes(Class.Year, TotalAmount)) +
  geom_col(size=3,fill="skyblue")+
  geom_label(aes(label=scales::dollar(TotalAmount)), vjust =2)+
  expand_limits(y=600000)
  theme_tq()


# 7.0 Scales x and y----
# Edits x and y axis scaling
  TotalContribByYear %>% 
    mutate(Class.Year = Class.Year %>% as_factor %>% fct_reorder(TotalAmount)) %>% 
    ggplot(aes(Class.Year, TotalAmount)) +
    geom_col(size=3,fill="skyblue")+
    geom_label(aes(label=scales::dollar(TotalAmount)))+
    scale_y_continuous(labels = scales::dollar_format())+
    expand_limits(y=600000)+
    theme_classic()+
    labs(
      title = "Total Giving",
      subtitle = "by Graduting Year",
      x="Grad Year",
      y="Amount Given",
      caption = "Older Alumni have given more"
      
    )

