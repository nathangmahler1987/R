### R Data Wrangling Basics with dplyr in Tidyverse ###----
# a database SQL-like syntax
#Nathan Mahler

contrib <- read.csv("C:/Users/natem/Desktop/INFO_4130/Mod3/contrib.csv")
#Look at the data
View(contrib)
options(max.print = 200)
attach(contrib)
## 1 selecting columns with select() (like SELECT in SQL)----

select(contrib, Class.Year, Major, FY04Giving)
select(contrib, Gender:Major)
select(contrib, -(Gender:Major))

contrib %>% 
  select(-(1:3))
# common Select helpers are: starts_with(), ends_with(), contains(), everything()
contrib %>% 
  select(ends_with("Giving"))
contrib %>% 
  select(starts_with("FY"))
contrib %>% 
  select(contains("Yea"))

contrib %>% 
  select(Major:Next.Degree,everything())
# if you get an error when doing a function like mean on a column in a table 
# it might be because the function needs a vector, and  this case you can use pull()
# pull() extracts the contents of a col out of a data frame/tibble, vectorizes data for a function that needs a vector such as mean()
contrib %>%
    pull(FY04Giving) %>%
    mean()

## 2 sorting cols with arrange() and desc() (like ORDER BY in SQL)----
attach(contrib)
contrib %>% 
  select(Major, FY04Giving) %>% 
  arrange(desc(FY04Giving))


## 3 filter rows with filter() (like WHERE in SQL)----
contrib %>% 
  select(Major, FY04Giving) %>% 
  filter(FY04Giving>1000) %>% 
  arrange(desc(FY04Giving))

contrib %>% 
  select(Major, FY04Giving) %>% 
  filter(FY04Giving>mean(FY04Giving))

contrib %>% 
  select(Major, FY04Giving) %>% 
  filter(FY04Giving>500 & FY04Giving<1000)

contrib %>% 
  select(Major, FY04Giving) %>% 
  filter(FY04Giving<50 | FY04Giving>10000)

contrib %>% 
  select(Major, FY04Giving) %>% 
  filter(FY04Giving>1000 & Major == "History")

contrib %>% 
  select(Major, FY04Giving) %>% 
  filter(FY04Giving<50 | Major != "Economics")
  
contrib %>% 
  select(Major, FY04Giving) %>% 
  filter(FY04Giving<50 | Major %in% c("Economics", "Biology") )

contrib %>% 
  select(Major, FY04Giving) %>% 
  filter(FY04Giving>1000 & Major %>% str_detect("ory") )

# filter row numbers with slice() (like Top 5 in SQL)
contrib %>% 
  arrange(desc(FY04Giving)) %>% 
  slice(1:5)
# filter to unique row values using distinct() (like distinct in SQL)
contrib %>% 
  distinct(Major)

## 4 add new variables with mutate()----
contribWithToatal <- contrib %>% 
  mutate(total_giving = FY04Giving + FY03Giving + FY02Giving + FY01Giving + FY00Giving)

# binning with ntile(), divides into groups with a ID number
contrib %>% 
  mutate(FY04Giving_binned = ntile(FY04Giving,3))

# add lable inside mutate() with case_when() to change numeric var to categorical
contrib %>% 
  select(FY04Giving) %>% 
    mutate(FY04Giving_binned2 = case_when(
      FY04Giving>10000 ~ "high",
      FY04Giving>1000 ~ "Medium",
      TRUE ~ "Low"))
  

# 5 group and summarize with aggregate functions----
# with summarize() and group_by (like group by in SQL)
contrib %>% 
  group_by(Major) %>% 
  summarise(
    FY4 = sum(FY04Giving)
  ) %>% 
  ungroup() %>% 
  arrange(desc(FY4))
  

# why use ungroup() so the you can perform operations on vars that cannot be done while they are in a group
# problem in group_by() with more than one var
# summarize with one group_by works because summarize removes the last grouping var https://community.rstudio.com/t/is-ungroup-recommended-after-every-group-by/5296
contribSummaryTable <- contrib %>% 
  group_by(Major) %>% 
  summarise(
    sum = sum(FY04Giving),
    avg =mean(FY04Giving),
    min=min(FY04Giving),
    max=max(FY04Giving),
    count= n(),
    sd=sd(FY04Giving)
  ) %>% 
  ungroup() %>% 
  arrange(desc(sum))

# find number of NAs with summarize_all
contrib %>% 
    summarize_all(~sum(is.na(.)))

## 6 Rename columns with rename()----
contribSummaryTable %>% 
  rename(
    "Sum of Contributions" = sum,
    "Average of contributions" = avg, 
    "Min of Contributions" = min,
    "Max of Contributions" = max,
    "Number of Contributions" = count,
    "Standard Deviation of contributions" = sd
  )
# if remaining all cols in order then can use set_names()
contribSummaryTable %>% 
  set_names(c("College Major","Sum", "Avg", "Min", "Max", "Count", "Standard Deviation"))

## 7 Other useful functions:----
# Unpivot a table with gather(), Pivot a table with spread()

# JOIN tables with inner_join() or left_join() etc.
# Table1 %>%
#    inner_join(y=Table2, by=c("Table1.id" = "Table2.id"))

# UNION tables with bind_rows() or bind_cols()

# separate() vars and unite() vars 
# ...separate(col=order_date, into = c("year", "month", "day"), remove=FALSE) %>% 
#    mutate(
#        year = as.numeric(year),
#        month = as.numeric(month),
#        day = as.numeric(day)
#    ) %>%
    
#    unite(order_date_united, year, month, day, sep = "-", remove = FALSE) %>% 
#    mutate(order_date_united = as.Date(order_date_united))