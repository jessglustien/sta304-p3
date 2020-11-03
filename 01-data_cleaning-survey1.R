 #### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from NationScape
# Author: Nick Callow, Jessica Glustein, Olivia Bi, Min Zhang
# Data: 02 November 2020
# Contact: jessica.glustien@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from NationScape and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)

# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read_dta("ns20200625.dta")
# Add the labels
raw_data <- labelled::to_factor(raw_data)
# Just keep some variables
reduced_data <- 
  raw_data %>% 
  select(vote_2016,
         vote_2020,
         gender,
         race_ethnicity,
         household_income,
         education,
         state,
         age)


#### What else???? ####
# Maybe make some age-groups?
# Maybe check the values?
# Is vote a binary? If not, what are you going to do?

reduced_data<-
  reduced_data %>%
  mutate(vote_trump = 
           ifelse(vote_2020=="Donald Trump", 1, 0))

reduced_data<-
  reduced_data %>%
  mutate(vote_biden = 
           ifelse(vote_2020=="Joe Biden", 1, 0))

reduced_data<-
  reduced_data %>%
  mutate(not_sure = 
           ifelse(vote_2020=="I am not sure/don't know", 1, 0))

reduced_data<-
  reduced_data %>%
  mutate(someone_else = 
           ifelse(vote_2020=="Someone else", 1, 0))

colnames(reduced_data)[3] <- "sex"
colnames(reduced_data)[4] <- "race"

reduced_data<-
  reduced_data %>%
  filter(vote_2020 != "I would not vote")  #keep only people who will vote

# race update: 
reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='White'] <- 'white'

reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='Black, or African American'] <- 'black/african american/negro'

reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='Asian (Chinese)'] <- 'chinese'

reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='Asian (Asian Indian)'] <- 'other asian or pacific islander'

reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='Asian (Vietnamese)'] <- 'other asian or pacific islander'

reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='Asian (Japanese)'] <- 'japanese'

reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='Asian (Korean)'] <- 'other asian or pacific islander'

reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='Some other race'] <- 'other race, nec'

reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='Asian (Filipino)'] <- 'other asian or pacific islander'

reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='Asian (Other)'] <- 'other asian or pacific islander'

reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='American Indian or Alaska Native'] <- 'american indian or alaska native'

reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='Pacific Islander (Guamanian)'] <- 'other asian or pacific islander'

reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='Pacific Islander (Native Hawaiian)'] <- 'other asian or pacific islander'

reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='Pacific Islander (Samoan)'] <- 'other asian or pacific islander'

reduced_data$race <- as.character(reduced_data$race)
reduced_data$race[reduced_data$race=='Pacific Islander (Other)'] <- 'other asian or pacific islander'




#update sex
reduced_data$sex <- as.character(reduced_data$sex)
reduced_data$sex[reduced_data$sex=='Female'] <- 'female'

reduced_data$sex <- as.character(reduced_data$sex)
reduced_data$sex[reduced_data$sex=='Male'] <- 'male'

# Saving the survey/sample data as a csv file in my
# working directory
write_csv(reduced_data, "survey_data.csv")


