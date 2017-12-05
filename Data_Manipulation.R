#this file is for loading in data and filtering out specific columns
library(dplyr)

full_data = read.csv("data/survey_results_public.csv")

get.filtered.data = function(columns)
{
  #columns should be a string vector with the names of the columns name that are desired
  return (full_data %>% select(columns))
}

get.full.data = function()
{
  return (full_data)
}