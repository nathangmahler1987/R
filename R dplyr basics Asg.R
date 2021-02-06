### R Data Wrangling Basics with dplyr in Tidyverse ###----
# a database SQL-like syntax


#Look at the data


options(max.print = 200)

## 1 selecting columns with select() (like SELECT in SQL)----




# common Select helpers are: starts_with(), ends_with(), contains(), everything()



# if you get an error when doing a function like mean on a column in a table 
# it might be because the function needs a vector, and  this case you can use pull()
# pull() extracts the contents of a col out of a data frame/tibble, vectorizes data for a function that needs a vector such as mean()
contrib %>%
    pull(FY04Giving) %>%
    mean()

## 2 sorting cols with arrange() and desc() (like ORDER BY in SQL)----


## 3 filter rows with filter() (like WHERE in SQL)----




# filter row numbers with slice() (like Top 5 in SQL)


# filter to unique row values using distinct() (like distinct in SQL)


## 4 add new variables with mutate()----


# binning with ntile(), divides into groups with a ID number


# add lable inside mutate() with case_when() to change numeric var to categorical


# 5 group and summarize with aggregate functions----
# with summarize() and group_by (like group by in SQL)


# why use ungroup() so the you can perform operations on vars that cannot be done while they are in a group
# problem in group_by() with more than one var
# summarize with one group_by works because summarize removes the last grouping var https://community.rstudio.com/t/is-ungroup-recommended-after-every-group-by/5296


# find number of NAs with summarize_all
contrib %>% 
    summarize_all(~sum(is.na(.)))

## 6 Rename columns with rename()----






# if remaining all cols in order then can use set_names()


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