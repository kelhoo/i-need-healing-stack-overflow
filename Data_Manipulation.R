#this file is for loading in data and filtering out specific columns
library(dplyr)

full_data = read.csv("data/filename.csv")

get.filtered.data(columns)
{
  #columns should be a string vector with the names of the columns name that are desired
  return full_data %>% select(columns)
}

get.full.data()
{
  return full_data
}