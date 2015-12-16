##  Set Working Directory to the datai1 folder


#  These must be installed the first time
install.packages("xlsx")
install.packages("dplyr")
install.packages("lubridate")
install.packages("reshape2")

#  Calls the packages
library(xlsx)
library(dplyr)
library(lubridate)
library(reshape2)
##  AfricaPopulation <- read.xlsx2("/Users/peterjmyers/myProjects/dtsc1/rawData/Maddison_Africa_Full.xlsx", sheetIndex=2, startRow = 13)
##  EuropePopulation <- read.xlsx2("/Users/peterjmyers/myProjects/dtsc1/rawData/Maddison_Europe_Full.xlsx", sheetIndex=2, startRow = 13)
##  AsiaPopulation <- read.xlsx2("/Users/peterjmyers/myProjects/dtsc1/rawData/Maddison_Asia_Full.xlsx", sheetIndex=2, startRow = 13)
##  CentralSouthAmericaPopulation <- read.xlsx2("/Users/peterjmyers/myProjects/dtsc1/rawData/Maddison_CentralAndSouthAmerica_Full.xlsx", sheetIndex=2, startRow = 13)

###  DOWNLOAD FILE
#if(!file.exists("data")) {dir.create("data")}
#fileUrl <- "http://www.worldeconomics.com/Files/Maddison_NorthAmerica_Full.xlsx"
#download.file(fileUrl, destfile = "./data/America.xlsx")  ## method = "curl" removed for windows
#dateDownloaded <- date()


setwd("C:/Users/Peter/myProjects/dtsc1/datai1")
# LOAD DATA
NorthAmericaPopulation <- read.xlsx2("./Maddison_NorthAmerica_Full.xlsx", sheetIndex=2, startRow = 64, endRow = 202, colIndex = 1:3, header=FALSE)
NorthAmericaGDP <- read.xlsx2("./Maddison_NorthAmerica_Full.xlsx", sheetIndex=3, startRow = 64, endRow = 202, colIndex = 1:3, header=FALSE)
NorthAmericaPerCapitaGDP <- read.xlsx2("./Maddison_NorthAmerica_Full.xlsx", sheetIndex=4, startRow = 64, endRow = 202, colIndex = 1:3, header=FALSE)

EuropePopulation <- read.xlsx2("./Maddison_Europe_Full.xlsx", sheetIndex=2, startRow = 64, endRow = 202, colIndex = c(1:13,16,17), header=FALSE)
EuropeGDP <- read.xlsx2("./Maddison_Europe_Full.xlsx", sheetIndex=3, startRow = 64, endRow = 202, colIndex = c(1:13,16,17), header=FALSE)
EuropePerCapitaGDP <- read.xlsx2("./Maddison_Europe_Full.xlsx", sheetIndex=4, startRow = 64, endRow = 202, colIndex = c(1:13,16,17), header=FALSE)

# GIVE NAMES BEFORE MELT
names(NorthAmericaPopulation) <- c("year", "canada","usa")
names(NorthAmericaGDP) <- c("year", "canada", "usa")
names(NorthAmericaPerCapitaGDP) <- c("year", "canada", "usa")

names(EuropePopulation) <- c("year", "Austria","Belgium","Denmark","Finland","France","Germany","Italy","Netherlands","Norway","Sweden","Switzerland","UK","Portugal","Spain")
names(EuropeGDP) <- c("year", "Austria","Belgium","Denmark","Finland","France","Germany","Italy","Netherlands","Norway","Sweden","Switzerland","UK","Portugal","Spain")
names(EuropePerCapitaGDP) <- c("year", "Austria","Belgium","Denmark","Finland","France","Germany","Italy","Netherlands","Norway","Sweden","Switzerland","UK","Portugal","Spain")

## Melt down to 3 columns each
NorthAmericaPopulationMelt <- melt(NorthAmericaPopulation,id="year")
NorthAmericaGDPMelt <- melt(NorthAmericaPopulation,id="year")
NorthAmericaPerCapitaGDPMelt <- melt(NorthAmericaPopulation,id="year")

EuropePopulationMelt <- melt(EuropePopulation,id="year")
EuropeGDPMelt <- melt(EuropeGDP,id="year")
EuropePerCapitaGDPMelt <- melt(EuropePerCapitaGDP,id="year")

## RENAME COLUMNS AFTER MELTING
names(NorthAmericaPopulationMelt) <- c("year", "country", "population")
names(NorthAmericaGDPMelt) <- c("year", "country", "gdp")
names(NorthAmericaPerCapitaGDPMelt) <- c("year", "country", "per_capita_gdp")

names(EuropePopulationMelt) <- c("year", "country", "population")
names(EuropeGDPMelt) <- c("year", "country", "gdp")
names(EuropePerCapitaGDPMelt) <- c("year", "country", "per_capita_gdp")

#REMOVE NA VALUES (Not Needed)
#good <- complete.cases(NorthAmericaPopulationMelt)
#NorthAmericaPopulationMelt <- NorthAmericaPopulationMelt[good,][,]
#good <- complete.cases(NorthAmericaGDPMelt)
#NorthAmericaGDPMelt <- NorthAmericaGDPMelt[good,][,]
#good <- complete.cases(NorthAmericaPerCapitaGDPMelt)
#NorthAmericaPerCapitaGDPMelt <- NorthAmericaPerCapitaGDPMelt[good,][,]

#good <- complete.cases(EuropePopulationMelt)
#EuropePopulationMelt <- EuropePopulationMelt[good,][,]
#good <- complete.cases(EuropeGDPMelt)
#EuropeGDPMelt <- EuropeGDPMelt[good,][,]
#good <- complete.cases(EuropePerCapitaGDP)
#EuropePerCapitaGDP <- EuropePerCapitaGDP[good,][,]



# Convert to correct units
NorthAmericaPopulationMelt <- mutate(NorthAmericaPopulationMelt, population = population * 1000)
NorthAmericaGDPMelt <- mutate(NorthAmericaGDPMelt, gdp = gdp * 1000000)

EuropePopulationMelt <- mutate(EuropePopulationMelt, population = population * 1000)
EuropeGDPMelt <- mutate(EuropeGDPMelt, gdp = gdp * 1000000)

### CONVERT YEAR TO DATE
##  Add 0101 to dates  paste function
#NorthAmericaPopulation <- mutate(NorthAmericaPopulation, year = paste(NorthAmericaPopulation$date,"0101", sep = ""))
#NorthAmericaGDP <- mutate(NorthAmericaGDP, year = paste(NorthAmericaGDP$year,"0101", sep = ""))
##  ymd read in with lubridate
#NorthAmericaPopulation <- mutate(NorthAmericaPopulation, year = ymd(NorthAmericaPopulation$date))
#NorthAmericaGDP <- mutate(NorthAmericaGDP, year = ymd(NorthAmericaGDP$year))

##  Merge data into one set
year_fact1 <- merge(NorthAmericaPopulationMelt,NorthAmericaGDPMelt)
year_fact1 <- merge(year_fact1,NorthAmericaPerCapitaGDPMelt)

year_fact2 <- merge(EuropePopulationMelt,EuropeGDPMelt)
year_fact2 <- merge(year_fact2,EuropePerCapitaGDPMelt)





## Write to file
write.table(year_fact1, "./year_fact1.csv", sep = "\t", col.names=NA)
write.table(year_fact2, "./year_fact2.csv", sep = "\t", col.names=NA)


## Create 5Year year_fact2 using SQL
#country
#start year
#end year
#display year  (ie. 1970-1975, 1971-1976)
#delta population
#delta dgp
#delta per_capita_gdp
#% change pop
#% change gdp
#% change per_capita_gdp