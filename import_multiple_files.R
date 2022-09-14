## This script's goal is to import multiple .csv files from a local folder using relative paths
## I recommend learning how to use RStudio Projects first

#### BASIC CODE ####
## Clean data memory
rm(list = ls())
rm("what") # Clean a specific R object

## Remove plots
dev.off(dev.list()["RStudioGD"]) # Apply dev.off() & dev.list()


#### LOAD PACKAGES ####
library(dplyr) # Cleaning and processing data
library(purrr) # Map function
library(tidyr)
library(plyr) # Function ldply
library(stringr) # Extracting data from strings
library(lubridate) # Parsing dates and times


#### IMPORT DATA ####
## Open multiple files
file_paths <- fs::dir_ls("data/football-data.co.uk") # Note that I am using relative paths on local

## Create a list of dataframes
data <- file_paths %>% 
  map(function (path) {
    read.csv(path)
  })

## Convert list of dataframe into a single dataframe
data <- ldply(data, data.frame)


#### SAVE NEW DATA FRAME - OPTIONAL ####
## I am again using relative paths within my RStudio project 
write.table(data, "sp_merge_data.csv", fileEncoding = "UTF-8", sep = ",", row.names = FALSE, col.names = TRUE)
