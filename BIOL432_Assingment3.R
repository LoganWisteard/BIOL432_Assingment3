---
title: 'BIOL 432: Assingment 3'
author: "Logan WIsteard"
date: "24/01/2022"
output: html_document
---

# Project Info
Date: 24/01/22
[GitHub Repository]:
  
library(dplyr) # load dplyr into R
library(knitr) # load knitr into R

#Load the Data
fallopia <- read.csv("/Users/loganwisteard/Desktop/homefolder/BIOL432-assingment3/InputData/FallopiaData.csv")

# Remove rows <60, Reorder columns to otal, Taxon, Scenario, Nutrients and remove all others
fallopia <- fallopia %>% 
  filter(Total > 60) %>% # removing rows with a total biomass of < 60
  select(Total, Taxon, Scenario, Nutrients) %>% # reordering the columns and removing unneeded ones 
  mutate(TotalG = Total/1000) %>% #creating a new column 
  select(TotalG, Taxon, Scenario, Nutrients) #replacing Total with TotalG


#Write a custom function that will take two inputs from the user: 1. a vector of data to process (e.g. column from a data.frame object) 
#and 2. a string that defines what calculation to perform
custom.function <- function (vector, string){
  if(string == "Average"){ #if string is "Average" caculate mean
    print(mean(vector))
  }
  else if(string == "Sum"){ #if string is "Sum" caculate sum
    print(sum(vector))
  }
  else if (string =="Observations"){ #if string is "observations" count number of observations
    print(length(vector))
  }
  else{
    print("Error: Invalid Cacuation Type")
  }
}


#Write some R code that uses your function to count the total number of observations in the 'Taxon' column
custom.function(fallopia$Taxon, "Observations") # count observations in Taxon column

#Write some R code that uses your function to calculate the average TotalG for each of the two Nutrient concentrations
custom.function(fallopia$TotalG[fallopia$Nutrients == "high"], "Average") # average TotalG for high nutrient group

custom.function(fallopia$TotalG[fallopia$Nutrients == "low"], "Average") # average TotalG for low nutrient group

# Save the new data
write.csv(fallopia, file = "./Output/WrangledData.csv", row.names= F)

