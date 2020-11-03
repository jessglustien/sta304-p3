#### Preamble ####
# Purpose: Prepare and clean the census data downloaded from American Community Survey
# Author: Nick Callow, Jessica Glustein, Olivia Bi, Min Zhang
# Data: 02 November 2020
# Contact: jessica.glustien@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
library(stringr)
# Read in the raw data.

raw_data <- read_dta("usa_00002.dta")


# Add the labels
raw_data <- labelled::to_factor(raw_data)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
reduced_data <- 
  raw_data %>% 
  select(
         sex, 
         age, 
         race, 
         #hispan,
         #marst, 
         #bpl,
         #citizen,
         educd,
         #labforce,
         inctot)

reduced_data <- 
  reduced_data %>%
  count(age, sex, race, educd) %>%
  group_by(age, sex, race, educd) 

reduced_data <- 
  reduced_data %>% 
  filter(age != "less than 1 year old") %>%
  filter(age != "90 (90+ in 1980 and 1990)")

colnames(reduced_data)[4] <- "education"

#update education:
reduced_data$education <- as.character(reduced_data$education)
reduced_data$education[reduced_data$education=='no schooling completed'] <- '3rd Grade or less'
reduced_data$education[reduced_data$education=='nursery school, preschool'] <- '3rd Grade or less'
reduced_data$education[reduced_data$education=='kindergarten'] <- '3rd Grade or less'
reduced_data$education[reduced_data$education=='grade 1'] <- '3rd Grade or less'
reduced_data$education[reduced_data$education=='grade 2'] <- '3rd Grade or less'
reduced_data$education[reduced_data$education=='grade 3'] <- '3rd Grade or less'
reduced_data$education[reduced_data$education=='grade 4'] <- 'Middle School - Grades 4 - 8'
reduced_data$education[reduced_data$education=='grade 5'] <- 'Middle School - Grades 4 - 8'
reduced_data$education[reduced_data$education=='grade 6'] <- 'Middle School - Grades 4 - 8'
reduced_data$education[reduced_data$education=='grade 7'] <- 'Middle School - Grades 4 - 8'
reduced_data$education[reduced_data$education=='grade 8'] <- 'Middle School - Grades 4 - 8'
reduced_data$education[reduced_data$education=='grade 9'] <- 'Completed some high school'
reduced_data$education[reduced_data$education=='grade 10'] <- 'Completed some high school'
reduced_data$education[reduced_data$education=='grade 11'] <- 'Completed some high school'
reduced_data$education[reduced_data$education=='regular high school diploma'] <- 'High school graduate'
reduced_data$education[reduced_data$education=='12th grade, no diploma'] <- 'Completed some high school'
reduced_data$education[reduced_data$education=='ged or alternative credential'] <- 'High school graduate'
reduced_data$education[reduced_data$education=='some college, but less than 1 year'] <- 'Completed some college, but no degree'
reduced_data$education[reduced_data$education=='1 or more years of college credit, no degree'] <- 'Completed some college, but no degree' 
reduced_data$education[reduced_data$education=="associate's degree, type not specified"] <- 'Associate Degree'
reduced_data$education[reduced_data$education=="bachelor's degree"] <- 'College Degree (such as B.A., B.S.)'
reduced_data$education[reduced_data$education== "master's degree"] <- 'Masters degree'
reduced_data$education[reduced_data$education=="professional degree beyond a bachelor's degree"] <- 'Masters degree'
reduced_data$education[reduced_data$education=='doctoral degree'] <- 'Doctorate degree'

#update race
reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='two major races'] <- 'other race, nec'
reduced_data$race[reduced_data$race=='three or more major races'] <- 'other race, nec'









reduced_data$age <- as.integer(reduced_data$age)
  
reduced_data <-
  reduced_data %>% 
  filter(age >= 18)  #remove people under 18


# Saving the census data as a csv file in my
# working directory

write_csv(reduced_data, "census_data.csv")



         