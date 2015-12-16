## Packages
#  dplyr
#  lubridate
#  xlsx
library(xlsx)
library(dplyr)
library(lubridate)
##  AfricaPopulation <- read.xlsx2("/Users/peterjmyers/myProjects/dtsc1/rawData/Maddison_Africa_Full.xlsx", sheetIndex=2, startRow = 13)
##  EuropePopulation <- read.xlsx2("/Users/peterjmyers/myProjects/dtsc1/rawData/Maddison_Europe_Full.xlsx", sheetIndex=2, startRow = 13)
##  AsiaPopulation <- read.xlsx2("/Users/peterjmyers/myProjects/dtsc1/rawData/Maddison_Asia_Full.xlsx", sheetIndex=2, startRow = 13)
##  CentralSouthAmericaPopulation <- read.xlsx2("/Users/peterjmyers/myProjects/dtsc1/rawData/Maddison_CentralAndSouthAmerica_Full.xlsx", sheetIndex=2, startRow = 13)
# LOAD DATA
NorthAmericaPopulation <- read.xlsx2("/Users/peterjmyers/myProjects/dtsc1/rawData/Maddison_NorthAmerica_Full.xlsx", sheetIndex=2, startRow = 13, colIndex = c(1,3))
NorthAmericaGDP <- read.xlsx2("/Users/peterjmyers/myProjects/dtsc1/rawData/Maddison_NorthAmerica_Full.xlsx", sheetIndex=3, startRow = 13, colIndex = c(1,3))

# GIVE NAMES
names(NorthAmericaPopulation) <- c("year", "population")

#REMOVE NA VALUES
good <- complete.cases(NorthAmericaPopulation)
NorthAmericaPopulation <- NorthAmericaPopulation[good,][,]


##  Add 0101 to dates  paste function
NorthAmericaPopulation <- mutate(NorthAmericaPopulation, unformatedDate = paste(NorthAmericaPopulation$year,"0101", sep = ""))

##  ymd read in with lubridate
ymd(NorthAmericaPopulation$unformatedDate)