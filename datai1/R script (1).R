## Note separate functions should be used in this file
# However for this project perhaps it can all be on one document

## Set Working Directory to the datai1 folder
setwd("C:/Users/Peter/myProjects/dtsc1/datai1")

## These must be installed the first time
install.packages("xlsx")
install.packages("dplyr")
install.packages("lubridate")
install.packages("reshape2")
install.packages("zoo") ## Linear interpolation NA values
install.packages("sqldf")

## Calls the packages
library(xlsx)
library(dplyr)
library(lubridate)
library(reshape2)
library(zoo)
library(sqldf)

## DOWNLOAD FILE
#if(!file.exists("data")) {dir.create("data")}
#fileUrl <- "http://www.worldeconomics.com/Files/Maddison_NorthAmerica_Full.xlsx"
#download.file(fileUrl, destfile = "./data/America.xlsx")  ## method = "curl" removed for windows
#dateDownloaded <- date()

## Load data from excel
NorthAmericaPopulation <- read.xlsx2("./Maddison_NorthAmerica_Full.xlsx", sheetIndex=2, startRow = 64, endRow = 202, colIndex = 1:3, header=FALSE)
NorthAmericaGDP <- read.xlsx2("./Maddison_NorthAmerica_Full.xlsx", sheetIndex=3, startRow = 64, endRow = 202, colIndex = 1:3, header=FALSE)
NorthAmericaPerCapitaGDP <- read.xlsx2("./Maddison_NorthAmerica_Full.xlsx", sheetIndex=4, startRow = 64, endRow = 202, colIndex = 1:3, header=FALSE)

EuropePopulation <- read.xlsx2("./Maddison_Europe_Full.xlsx", sheetIndex=2, startRow = 64, endRow = 202, colIndex = c(1:13,16,17), header=FALSE)
EuropeGDP <- read.xlsx2("./Maddison_Europe_Full.xlsx", sheetIndex=3, startRow = 64, endRow = 202, colIndex = c(1:13,16,17), header=FALSE)
EuropePerCapitaGDP <- read.xlsx2("./Maddison_Europe_Full.xlsx", sheetIndex=4, startRow = 64, endRow = 202, colIndex = c(1:13,16,17), header=FALSE)

CentralAndSouthAmericaPopulation <- read.xlsx2("./Maddison_CentralAndSouthAmerica_Full.xlsx", sheetIndex=2, startRow = 64, endRow = 202, colIndex = 1:24, header=FALSE)
CentralAndSouthAmericaGDP <- read.xlsx2("./Maddison_CentralAndSouthAmerica_Full.xlsx", sheetIndex=3, startRow = 64, endRow = 202, colIndex = 1:24, header=FALSE)
CentralAndSouthAmericaPerCapitaGDP <- read.xlsx2("./Maddison_CentralAndSouthAmerica_Full.xlsx", sheetIndex=4, startRow = 64, endRow = 202, colIndex = 1:24, header=FALSE)

AsiaPopulation <- read.xlsx2("./Maddison_Asia_Full.xlsx", sheetIndex=2, startRow = 64, endRow = 202, colIndex = 1:41, header=FALSE)
AsiaGDP <- read.xlsx2("./Maddison_Asia_Full.xlsx", sheetIndex=3, startRow = 64, endRow = 202, colIndex = 1:41, header=FALSE)
AsiaPerCapitaGDP <- read.xlsx2("./Maddison_Asia_Full.xlsx", sheetIndex=4, startRow = 64, endRow = 202, colIndex = 1:41, header=FALSE)

AfricaPopulation <- read.xlsx2("./Maddison_Africa_Full.xlsx", sheetIndex=2, startRow = 64, endRow = 202, colIndex = 1:54, header=FALSE)
AfricaGDP <- read.xlsx2("./Maddison_Africa_Full.xlsx", sheetIndex=3, startRow = 64, endRow = 202, colIndex = 1:54, header=FALSE)
AfricaPerCapitaGDP <- read.xlsx2("./Maddison_Africa_Full.xlsx", sheetIndex=4, startRow = 64, endRow = 202, colIndex = 1:54, header=FALSE)

## GIVE NAMES BEFORE MELT
names(NorthAmericaPopulation) <- c("year", "canada","usa")
names(NorthAmericaGDP) <- c("year", "canada", "usa")
names(NorthAmericaPerCapitaGDP) <- c("year", "canada", "usa")

names(EuropePopulation) <- c("year", "Austria","Belgium","Denmark","Finland","France","Germany","Italy","Netherlands","Norway","Sweden","Switzerland","UK","Portugal","Spain")
names(EuropeGDP) <- c("year", "Austria","Belgium","Denmark","Finland","France","Germany","Italy","Netherlands","Norway","Sweden","Switzerland","UK","Portugal","Spain")
names(EuropePerCapitaGDP) <- c("year", "Austria","Belgium","Denmark","Finland","France","Germany","Italy","Netherlands","Norway","Sweden","Switzerland","UK","Portugal","Spain")

names(CentralAndSouthAmericaPopulation) <- c("year", "Argentina","Brazil","Chile","Colombia","Mexico","Peru","Uruguay","Venezuela","Bolivia","Costa.Rica","Cuba","Dominican.Rep.",
	"Ecuador","El.Salvador","Guatemala","Haiti","Honduras","Jamaica","Nicaragua","Panama","Paraguay","Puerto.Rico","T.and.Tobago")
names(CentralAndSouthAmericaGDP) <- c("year", "Argentina","Brazil","Chile","Colombia","Mexico","Peru","Uruguay","Venezuela","Bolivia","Costa.Rica","Cuba","Dominican.Rep.",
	"Ecuador","El.Salvador","Guatemala","Haiti","Honduras","Jamaica","Nicaragua","Panama","Paraguay","Puerto.Rico","T.and.Tobago")
names(CentralAndSouthAmericaPerCapitaGDP) <- c("year", "Argentina","Brazil","Chile","Colombia","Mexico","Peru","Uruguay","Venezuela","Bolivia","Costa.Rica","Cuba","Dominican.Rep.",
	"Ecuador","El.Salvador","Guatemala","Haiti","Honduras","Jamaica","Nicaragua","Panama","Paraguay","Puerto.Rico","T.and.Tobago")

names(AsiaPopulation) <- c("year", "China","India","Indonesia","Japan","Philippines","South.Korea","Thailand","Taiwan","Bangladesh","Burma","Hong.Kong","Malaysia",
	"Nepal","Pakistan","Singapore","Sri.Lanka","Afghanistan","Cambodia","Laos","Mongolia","North.Korea","Vietnam","24.Sm.E.Asia","Bahrain","Iran","Iraq","Israel","Jordan","Kuwait",
	"Lebanon","Oman","Qatar","Saudi.Arabia","Syria","Turkey","UAE","Yemen","W.Bank.and.Gaza","Australia","New.Zealand")
names(AsiaGDP) <- c("year", "China","India","Indonesia","Japan","Philippines","South.Korea","Thailand","Taiwan","Bangladesh","Burma","Hong.Kong","Malaysia",
	"Nepal","Pakistan","Singapore","Sri.Lanka","Afghanistan","Cambodia","Laos","Mongolia","North.Korea","Vietnam","24.Sm.E.Asia","Bahrain","Iran","Iraq","Israel","Jordan","Kuwait",
	"Lebanon","Oman","Qatar","Saudi.Arabia","Syria","Turkey","UAE","Yemen","W.Bank.and.Gaza","Australia","New.Zealand")
names(AsiaPerCapitaGDP) <- c("year", "China","India","Indonesia","Japan","Philippines","South.Korea","Thailand","Taiwan","Bangladesh","Burma","Hong.Kong","Malaysia",
	"Nepal","Pakistan","Singapore","Sri.Lanka","Afghanistan","Cambodia","Laos","Mongolia","North.Korea","Vietnam","24.Sm.E.Asia","Bahrain","Iran","Iraq","Israel","Jordan","Kuwait",
	"Lebanon","Oman","Qatar","Saudi.Arabia","Syria","Turkey","UAE","Yemen","W.Bank.and.Gaza","Australia","New.Zealand")

names(AfricaPopulation) <- c("year", "Algeria","Angola","Benin","Botswana","Burkina.Faso","Burundi","Cameroon","Cape.Verde","Central.Africa.Republic","Chad","Comoro.Islands","Congo",
	"Cote.d.Ivoire","Djibouti","Egypt","Equatorial.Guinea","Eritrea.and.Ethiopia","Gabon","Gambia","Ghana","Guinea","Guinea.Bissau","Kenya","Lesotho","Liberia","Libya","Madagascar",
	"Malawi","Mali","Mauritania","Mauritius","Morocco","Mozambique","Namibia","Niger","Nigeria","Rwanda","Sao.Tome.and.Principe","Senegal","Seychelles","Sierra.Leone","Somalia",
	"South.Africa","Sudan","Swaziland","Tanzania","Togo","Tunisia","Uganda","Zaire","Zambia","Zimbabwe","Three.Small.Afr.")
names(AfricaGDP) <- c("year", "Algeria","Angola","Benin","Botswana","Burkina.Faso","Burundi","Cameroon","Cape.Verde","Central.Africa.Republic","Chad","Comoro.Islands","Congo",
	"Cote.d.Ivoire","Djibouti","Egypt","Equatorial.Guinea","Eritrea.and.Ethiopia","Gabon","Gambia","Ghana","Guinea","Guinea.Bissau","Kenya","Lesotho","Liberia","Libya","Madagascar",
	"Malawi","Mali","Mauritania","Mauritius","Morocco","Mozambique","Namibia","Niger","Nigeria","Rwanda","Sao.Tome.and.Principe","Senegal","Seychelles","Sierra.Leone","Somalia",
	"South.Africa","Sudan","Swaziland","Tanzania","Togo","Tunisia","Uganda","Zaire","Zambia","Zimbabwe","Three.Small.Afr.")
names(AfricaPerCapitaGDP) <- c("year", "Algeria","Angola","Benin","Botswana","Burkina.Faso","Burundi","Cameroon","Cape.Verde","Central.Africa.Republic","Chad","Comoro.Islands","Congo",
	"Cote.d.Ivoire","Djibouti","Egypt","Equatorial.Guinea","Eritrea.and.Ethiopia","Gabon","Gambia","Ghana","Guinea","Guinea.Bissau","Kenya","Lesotho","Liberia","Libya","Madagascar",
	"Malawi","Mali","Mauritania","Mauritius","Morocco","Mozambique","Namibia","Niger","Nigeria","Rwanda","Sao.Tome.and.Principe","Senegal","Seychelles","Sierra.Leone","Somalia",
	"South.Africa","Sudan","Swaziland","Tanzania","Togo","Tunisia","Uganda","Zaire","Zambia","Zimbabwe","Three.Small.Afr.")


## Set data types to numeric
for (i in 2:3) {
	NorthAmericaPopulation[ , i] <- as.numeric(as.character(NorthAmericaPopulation[ , i]))	
	NorthAmericaGDP[ , i] <- as.numeric(as.character(NorthAmericaGDP[ , i]))
	NorthAmericaPerCapitaGDP[ , i] <- as.numeric(as.character(NorthAmericaPerCapitaGDP[ , i]))
}

for (i in 2:15) {
	EuropePopulation[ , i] <- as.numeric(as.character(EuropePopulation[ , i]))	
	EuropeGDP[ , i] <- as.numeric(as.character(EuropeGDP[ , i]))
	EuropePerCapitaGDP[ , i] <- as.numeric(as.character(EuropePerCapitaGDP[ , i]))
}

for (i in 2:24) {
	CentralAndSouthAmericaPopulation[ , i] <- as.numeric(as.character(CentralAndSouthAmericaPopulation[ , i]))	
	CentralAndSouthAmericaGDP[ , i] <- as.numeric(as.character(CentralAndSouthAmericaGDP[ , i]))
	CentralAndSouthAmericaPerCapitaGDP[ , i] <- as.numeric(as.character(CentralAndSouthAmericaPerCapitaGDP[ , i]))
}

for (i in 2:41) {
	AsiaPopulation[ , i] <- as.numeric(as.character(AsiaPopulation[ , i]))	
	AsiaGDP[ , i] <- as.numeric(as.character(AsiaGDP[ , i]))
	AsiaPerCapitaGDP[ , i] <- as.numeric(as.character(AsiaPerCapitaGDP[ , i]))	
}

for (i in 2:54) {
	AfricaPopulation[ , i] <- as.numeric(as.character(AfricaPopulation[ , i]))	
	AfricaGDP[ , i] <- as.numeric(as.character(AfricaGDP[ , i]))
	AfricaPerCapitaGDP[ , i] <- as.numeric(as.character(AfricaPerCapitaGDP[ , i]))	
}
## Fill in the 1870 values where they are null
CentralAndSouthAmericaGDP1870 = c(); CentralAndSouthAmericaGDP1950 = c();
CentralAndSouthAmericaPerCapitaGDP1870 = c(); CentralAndSouthAmericaPerCapitaGDP1950 = c();

AsiaPopulation1870 = c(); AsiaPopulation1950 = c();
AsiaGDP1870 = c(); AsiaGDP1950 = c();
AsiaPerCapitaGDP1870 = c(); AsiaPerCapitaGDP1950 = c();

AfricaPopulation1870 = c(); AfricaPopulation1950 = c();
AfricaGDP1870 = c(); AfricaGDP1950 = c();
AfricaPerCapitaGDP1870 = c(); AfricaPerCapitaGDP1950 = c();
# Pull the row with nulls (1870) and the row with no nulls (1950).
for (i in 2:24) {
	CentralAndSouthAmericaGDP1870[i-1] <- CentralAndSouthAmericaGDP[[i]][[1]]
	CentralAndSouthAmericaGDP1950[i-1] <- CentralAndSouthAmericaGDP[[i]][[81]]
	CentralAndSouthAmericaGDPgood <- complete.cases(CentralAndSouthAmericaGDP1870,CentralAndSouthAmericaGDP1950)

	CentralAndSouthAmericaPerCapitaGDP1870[i-1] <- CentralAndSouthAmericaPerCapitaGDP[[i]][[1]]
	CentralAndSouthAmericaPerCapitaGDP1950[i-1] <- CentralAndSouthAmericaPerCapitaGDP[[i]][[81]]
	CentralAndSouthAmericaPerCapitaGDPgood <- complete.cases(CentralAndSouthAmericaPerCapitaGDP1870,CentralAndSouthAmericaPerCapitaGDP1950)
}

for (i in 2:41) {
	AsiaPopulation1870[i-1] <- AsiaPopulation[[i]][[1]]
	AsiaPopulation1950[i-1] <- AsiaPopulation[[i]][[81]]
	AsiaPopulationgood <- complete.cases(AsiaPopulation1870,AsiaPopulation1950)

	AsiaGDP1870[i-1] <- AsiaGDP[[i]][[1]]
	AsiaGDP1950[i-1] <- AsiaGDP[[i]][[81]]
	AsiaGDPgood <- complete.cases(AsiaGDP1870,AsiaGDP1950)

	AsiaPerCapitaGDP1870[i-1] <- AsiaPerCapitaGDP[[i]][[1]]
	AsiaPerCapitaGDP1950[i-1] <- AsiaPerCapitaGDP[[i]][[81]]
	AsiaPerCapitaGDPgood <- complete.cases(AsiaPerCapitaGDP1870,AsiaPerCapitaGDP1950)
}

for (i in 2:54) {
	AfricaPopulation1870[i-1] <- AfricaPopulation[[i]][[1]]
	AfricaPopulation1950[i-1] <- AfricaPopulation[[i]][[81]]
	AfricaPopulationgood <- complete.cases(AfricaPopulation1870,AfricaPopulation1950)

	AfricaGDP1870[i-1] <- AfricaGDP[[i]][[1]]
	AfricaGDP1950[i-1] <- AfricaGDP[[i]][[81]]
	AfricaGDPgood <- complete.cases(AfricaGDP1870,AfricaGDP1950)

	AfricaPerCapitaGDP1870[i-1] <- AfricaPerCapitaGDP[[i]][[1]]
	AfricaPerCapitaGDP1950[i-1] <- AfricaPerCapitaGDP[[i]][[81]]
	AfricaPerCapitaGDPgood <- complete.cases(AfricaPerCapitaGDP1870,AfricaPerCapitaGDP1950)
}

# Find the average change from 1870 to 1950
CentralAndSouthAmericaGDPArr <- array(dim=c(23,1)); CentralAndSouthAmericaPerCapitaGDPArr <- array(dim=c(23,1))
for (i in 1:23) {
	if (CentralAndSouthAmericaGDPgood[i]) {
		CentralAndSouthAmericaGDPArr[i] <- CentralAndSouthAmericaGDP1950[i] / CentralAndSouthAmericaGDP1870[i]	
	}
	if (CentralAndSouthAmericaPerCapitaGDPgood[i]) {
		CentralAndSouthAmericaPerCapitaGDPArr[i] <- CentralAndSouthAmericaPerCapitaGDP1950[i] / CentralAndSouthAmericaPerCapitaGDP1870[i]	
	}	
}
CentralAndSouthAmericaGDPAverageChange <- mean(CentralAndSouthAmericaGDPArr, na.rm=TRUE)
CentralAndSouthAmericaPerCapitaGDPAverageChange <- mean(CentralAndSouthAmericaPerCapitaGDPArr, na.rm=TRUE)

AsiaPopulationArr <- array(dim=c(40,1)); AsiaGDPArr <- array(dim=c(40,1)); AsiaPerCapitaGDPArr <- array(dim=c(40,1))
for (i in 1:40) {
	if (AsiaPopulationgood[i]) {
		AsiaPopulationArr[i] <- AsiaPopulation1950[i] / AsiaPopulation1870[i]	
	}	
	if (AsiaGDPgood[i]) {
		AsiaGDPArr[i] <- AsiaGDP1950[i] / AsiaGDP1870[i]	
	}
	if (AsiaPerCapitaGDPgood[i]) {
		AsiaPerCapitaGDPArr[i] <- AsiaPerCapitaGDP1950[i] / AsiaPerCapitaGDP1870[i]	
	}	
}
AsiaPopulationAverageChange <- mean(AsiaPopulationArr, na.rm=TRUE)
AsiaGDPAverageChange <- mean(AsiaGDPArr, na.rm=TRUE)
AsiaPerCapitaGDPAverageChange <- mean(AsiaPerCapitaGDPArr, na.rm=TRUE)

AfricaPopulationArr <- array(dim=c(53,1)); AfricaGDPArr <- array(dim=c(53,1)); AfricaPerCapitaGDPArr <- array(dim=c(40,1))
for (i in 1:53) {
	if (AfricaPopulationgood[i]) {
		AfricaPopulationArr[i] <- AfricaPopulation1950[i] / AfricaPopulation1870[i]	
	}	
	if (AfricaGDPgood[i]) {
		AfricaGDPArr[i] <- AfricaGDP1950[i] / AfricaGDP1870[i]	
	}
	if (AfricaPerCapitaGDPgood[i]) {
		AfricaPerCapitaGDPArr[i] <- AfricaPerCapitaGDP1950[i] / AfricaPerCapitaGDP1870[i]	
	}	
}
AfricaPopulationAverageChange <- mean(AfricaPopulationArr, na.rm=TRUE)
AfricaGDPAverageChange <- mean(AfricaGDPArr, na.rm=TRUE)
AfricaPerCapitaGDPAverageChange <- mean(AfricaPerCapitaGDPArr, na.rm=TRUE)

# Apply this average change to 1850 data
for (i in 2:24) {
	if(is.na(CentralAndSouthAmericaGDP[[i]][[1]])) {
		CentralAndSouthAmericaGDP[[i]][[1]] <- CentralAndSouthAmericaGDP[[i]][[81]] / CentralAndSouthAmericaGDPAverageChange
	}
	if(is.na(CentralAndSouthAmericaPerCapitaGDP[[i]][[1]])) {
		CentralAndSouthAmericaPerCapitaGDP[[i]][[1]] <- CentralAndSouthAmericaPerCapitaGDP[[i]][[81]] / CentralAndSouthAmericaPerCapitaGDPAverageChange
	}	
}

for (i in 2:41) {
	if(is.na(AsiaPopulation[[i]][[1]])) {
		AsiaPopulation[[i]][[1]] <- AsiaPopulation[[i]][[81]] / AsiaPopulationAverageChange
	}	
	if(is.na(AsiaGDP[[i]][[1]])) {
		AsiaGDP[[i]][[1]] <- AsiaGDP[[i]][[81]] / AsiaGDPAverageChange
	}
	if(is.na(AsiaPerCapitaGDP[[i]][[1]])) {
		AsiaPerCapitaGDP[[i]][[1]] <- AsiaPerCapitaGDP[[i]][[81]] / AsiaPerCapitaGDPAverageChange
	}	
}

for (i in 2:54) {
	if(is.na(AfricaPopulation[[i]][[1]])) {
		AfricaPopulation[[i]][[1]] <- AfricaPopulation[[i]][[81]] / AfricaPopulationAverageChange
	}	
	if(is.na(AfricaGDP[[i]][[1]])) {
		AfricaGDP[[i]][[1]] <- AfricaGDP[[i]][[81]] / AfricaGDPAverageChange
	}
	if(is.na(AfricaPerCapitaGDP[[i]][[1]])) {
		AfricaPerCapitaGDP[[i]][[1]] <- AfricaPerCapitaGDP[[i]][[81]] / AfricaPerCapitaGDPAverageChange
	}	
}
## Linear interpolation NA values in between 1870 and 1950
#Population
CentralAndSouthAmericaPopulationZoo <- zoo(CentralAndSouthAmericaPopulation)
index(CentralAndSouthAmericaPopulationZoo) <- CentralAndSouthAmericaPopulationZoo[,1]
CentralAndSouthAmericaPopulation <- na.approx(CentralAndSouthAmericaPopulationZoo)

CentralAndSouthAmericaGDPZoo <- zoo(CentralAndSouthAmericaGDP)
index(CentralAndSouthAmericaGDPZoo) <- CentralAndSouthAmericaGDPZoo[,1]
CentralAndSouthAmericaGDP <- na.approx(CentralAndSouthAmericaGDPZoo)

CentralAndSouthAmericaPerCapitaGDPZoo <- zoo(CentralAndSouthAmericaPerCapitaGDP)
index(CentralAndSouthAmericaPerCapitaGDPZoo) <- CentralAndSouthAmericaPerCapitaGDPZoo[,1]
CentralAndSouthAmericaPerCapitaGDP <- na.approx(CentralAndSouthAmericaPerCapitaGDPZoo)


AsiaPopulationZoo <- zoo(AsiaPopulation)
index(AsiaPopulationZoo) <- AsiaPopulationZoo[,1]
AsiaPopulation <- na.approx(AsiaPopulationZoo)

AsiaGDPZoo <- zoo(AsiaGDP)
index(AsiaGDPZoo) <- AsiaGDPZoo[,1]
AsiaGDP <- na.approx(AsiaGDPZoo)

AsiaPerCapitaGDPZoo <- zoo(AsiaPerCapitaGDP)
index(AsiaPerCapitaGDPZoo) <- AsiaPerCapitaGDPZoo[,1]
AsiaPerCapitaGDP <- na.approx(AsiaPerCapitaGDPZoo)


AfricaPopulationZoo <- zoo(AfricaPopulation)
index(AfricaPopulationZoo) <- AfricaPopulationZoo[,1]
AfricaPopulation <- na.approx(AfricaPopulationZoo)

AfricaGDPZoo <- zoo(AfricaGDP)
index(AfricaGDPZoo) <- AfricaGDPZoo[,1]
AfricaGDP <- na.approx(AfricaGDPZoo)

AfricaPerCapitaGDPZoo <- zoo(AfricaPerCapitaGDP)
index(AfricaPerCapitaGDPZoo) <- AfricaPerCapitaGDPZoo[,1]
AfricaPerCapitaGDP <- na.approx(AfricaPerCapitaGDPZoo)

## Assign data types again after zoo
CentralAndSouthAmericaPopulation <- data.frame(CentralAndSouthAmericaPopulation)
CentralAndSouthAmericaGDP <- data.frame(CentralAndSouthAmericaGDP)
CentralAndSouthAmericaPerCapitaGDP <- data.frame(CentralAndSouthAmericaPerCapitaGDP)
for (i in 2:24) {
	CentralAndSouthAmericaPopulation[ , i] <- as.numeric(as.character(CentralAndSouthAmericaPopulation[ , i]))	
	CentralAndSouthAmericaGDP[ , i] <- as.numeric(as.character(CentralAndSouthAmericaGDP[ , i]))
	CentralAndSouthAmericaPerCapitaGDP[ , i] <- as.numeric(as.character(CentralAndSouthAmericaPerCapitaGDP[ , i]))
}

AsiaPopulation <- data.frame(AsiaPopulation)
AsiaGDP <- data.frame(AsiaGDP)
AsiaPerCapitaGDP <- data.frame(AsiaPerCapitaGDP)
for (i in 2:41) {
	AsiaPopulation[ , i] <- as.numeric(as.character(AsiaPopulation[ , i]))	
	AsiaGDP[ , i] <- as.numeric(as.character(AsiaGDP[ , i]))
	AsiaPerCapitaGDP[ , i] <- as.numeric(as.character(AsiaPerCapitaGDP[ , i]))
}

AfricaPopulation <- data.frame(AfricaPopulation)
AfricaGDP <- data.frame(AfricaGDP)
AfricaPerCapitaGDP <- data.frame(AfricaPerCapitaGDP)
for (i in 2:54) {
	AfricaPopulation[ , i] <- as.numeric(as.character(AfricaPopulation[ , i]))	
	AfricaGDP[ , i] <- as.numeric(as.character(AfricaGDP[ , i]))
	AfricaPerCapitaGDP[ , i] <- as.numeric(as.character(AfricaPerCapitaGDP[ , i]))
}

## Melt down to 3 columns each
NorthAmericaPopulationMelt <- melt(NorthAmericaPopulation,id="year")
NorthAmericaGDPMelt <- melt(NorthAmericaGDP,id="year")
NorthAmericaPerCapitaGDPMelt <- melt(NorthAmericaPerCapitaGDP,id="year")

EuropePopulationMelt <- melt(EuropePopulation,id="year")
EuropeGDPMelt <- melt(EuropeGDP,id="year")
EuropePerCapitaGDPMelt <- melt(EuropePerCapitaGDP,id="year")

CentralAndSouthAmericaPopulationMelt <- melt(CentralAndSouthAmericaPopulation,id="year")
CentralAndSouthAmericaGDPMelt <- melt(CentralAndSouthAmericaGDP,id="year")
CentralAndSouthAmericaPerCapitaGDPMelt <- melt(CentralAndSouthAmericaPerCapitaGDP,id="year")

AsiaPopulationMelt <- melt(AsiaPopulation,id="year")
AsiaGDPMelt <- melt(AsiaGDP,id="year")
AsiaPerCapitaGDPMelt <- melt(AsiaPerCapitaGDP,id="year")

AfricaPopulationMelt <- melt(AfricaPopulation,id="year")
AfricaGDPMelt <- melt(AfricaGDP,id="year")
AfricaPerCapitaGDPMelt <- melt(AfricaPerCapitaGDP,id="year")

## Rename columns after melting
names(NorthAmericaPopulationMelt) <- c("year", "country", "population")
names(NorthAmericaGDPMelt) <- c("year", "country", "gdp")
names(NorthAmericaPerCapitaGDPMelt) <- c("year", "country", "per_capita_gdp")

names(EuropePopulationMelt) <- c("year", "country", "population")
names(EuropeGDPMelt) <- c("year", "country", "gdp")
names(EuropePerCapitaGDPMelt) <- c("year", "country", "per_capita_gdp")

names(CentralAndSouthAmericaPopulationMelt) <- c("year", "country", "population")
names(CentralAndSouthAmericaGDPMelt) <- c("year", "country", "gdp")
names(CentralAndSouthAmericaPerCapitaGDPMelt) <- c("year", "country", "per_capita_gdp")

names(AsiaPopulationMelt) <- c("year", "country", "population")
names(AsiaGDPMelt) <- c("year", "country", "gdp")
names(AsiaPerCapitaGDPMelt) <- c("year", "country", "per_capita_gdp")

names(AfricaPopulationMelt) <- c("year", "country", "population")
names(AfricaGDPMelt) <- c("year", "country", "gdp")
names(AfricaPerCapitaGDPMelt) <- c("year", "country", "per_capita_gdp")

## Convert to correct units; We may want to convert; I don't know the right conversion we want to use;
#NorthAmericaPopulationMelt <- mutate(NorthAmericaPopulationMelt, population = population * 1000)
#NorthAmericaGDPMelt <- mutate(NorthAmericaGDPMelt, gdp = gdp * 1000000)

#EuropePopulationMelt <- mutate(EuropePopulationMelt, population = population * 1000)
#EuropeGDPMelt <- mutate(EuropeGDPMelt, gdp = gdp * 1000000)

#CentralAndSouthAmericaPopulationMelt <- mutate(CentralAndSouthAmericaPopulationMelt, population = population * 1000)
#CentralAndSouthAmericaGDPMelt <- mutate(CentralAndSouthAmericaGDPMelt, gdp = gdp * 1000000)

### CONVERT YEAR TO DATE
##  Add 0101 to dates  paste function
#NorthAmericaPopulation <- mutate(NorthAmericaPopulation, year = paste(NorthAmericaPopulation$date,"0101", sep = ""))
#NorthAmericaGDP <- mutate(NorthAmericaGDP, year = paste(NorthAmericaGDP$year,"0101", sep = ""))
##  ymd read in with lubridate
#NorthAmericaPopulation <- mutate(NorthAmericaPopulation, year = ymd(NorthAmericaPopulation$date))
#NorthAmericaGDP <- mutate(NorthAmericaGDP, year = ymd(NorthAmericaGDP$year))

##  Merge data into one set
yearly_stats1 <- merge(NorthAmericaPopulationMelt,NorthAmericaGDPMelt)
yearly_stats1 <- merge(yearly_stats1,NorthAmericaPerCapitaGDPMelt)

yearly_stats2 <- merge(EuropePopulationMelt,EuropeGDPMelt)
yearly_stats2 <- merge(yearly_stats2,EuropePerCapitaGDPMelt)

yearly_stats3 <- merge(CentralAndSouthAmericaPopulationMelt,CentralAndSouthAmericaGDPMelt)
yearly_stats3 <- merge(yearly_stats3,CentralAndSouthAmericaPerCapitaGDPMelt)

yearly_stats4 <- merge(AsiaPopulationMelt,AsiaGDPMelt)
yearly_stats4 <- merge(yearly_stats4,AsiaPerCapitaGDPMelt)

yearly_stats5 <- merge(AfricaPopulationMelt,AfricaGDPMelt)
yearly_stats5 <- merge(yearly_stats5,AfricaPerCapitaGDPMelt)

## Write to file (Test Purposes)
#write.table(year_fact1, "./year_fact1.csv", sep = ",",row.names=FALSE)
#write.table(year_fact2, "./year_fact2.csv", sep = ",",row.names=FALSE)
#write.table(year_fact3, "./year_fact3.csv", sep = ",",row.names=FALSE)
#write.table(year_fact4, "./year_fact4.csv", sep = ",",row.names=FALSE)
#write.table(year_fact5, "./year_fact5.csv", sep = ",",row.names=FALSE)

## Create combined year_fact with sqldf
yearly_stats <- sqldf("
SELECT
	year,
	country,
	population,
	gdp,
	per_capita_gdp
FROM
	(SELECT
		year,
		country,
		population,
		gdp,
		per_capita_gdp
	FROM
		yearly_stats1
	UNION ALL
	SELECT
		year,
		country,
		population,
		gdp,
		per_capita_gdp
	FROM
		yearly_stats2
	UNION ALL
	SELECT
		year,
		country,
		population,
		gdp,
		per_capita_gdp
	FROM
		yearly_stats3
	UNION ALL
	SELECT
		year,
		country,
		population,
		gdp,
		per_capita_gdp
	FROM
		yearly_stats4
	UNION ALL
	SELECT
		year,
		country,
		population,
		gdp,
		per_capita_gdp
	FROM
		yearly_stats5
	) x
ORDER BY
	1 ASC, 2 ASC
")

yearly_stats[ , 1] <- as.numeric(as.character(yearly_stats[ , 1]))	
write.table(yearly_stats, "./yearly_stats.csv", sep = ",",row.names=FALSE)

## Create stats_across_five_years using sqldf
# concat isn't allowed so wasn't able to add 'display_year'
# 	CONCAT(CAST(five_years_ago.year AS char), '-', CAST(main_year.year AS char)) AS display_year,
stats_across_five_years <- sqldf("
SELECT
	main_year.country AS Country,
	five_years_ago.year AS start_year,	
	main_year.year AS end_year,
	main_year.population - five_years_ago.population AS Delta_Population,
	main_year.gdp - five_years_ago.gdp AS Delta_GDP,
	main_year.per_capita_gdp - five_years_ago.per_capita_gdp AS Delta_Per_Capita_GDP,
	(main_year.population - five_years_ago.population) / five_years_ago.population AS pct_change_Population,
	(main_year.gdp - five_years_ago.gdp) / five_years_ago.gdp AS pct_change_GDP,
	(main_year.per_capita_gdp - five_years_ago.per_capita_gdp) / five_years_ago.per_capita_gdp AS pct_change_Per_Capita_GDP
FROM
	(SELECT
		year,
		country,
		population,
		gdp,
		per_capita_gdp
	FROM
		yearly_stats
	) AS main_year
INNER JOIN
	(SELECT
		year,
		country,
		population,
		gdp,
		per_capita_gdp
	FROM
		yearly_stats
	) AS five_years_ago ON
		five_years_ago.country = main_year.country and
		five_years_ago.year = main_year.year - 5
WHERE
	main_year.year % 5 == 0
ORDER BY
  1 ASC, 2 ASC
")

write.table(stats_across_five_years, "./stats_across_five_years.csv", sep = ",",row.names=FALSE)

top_5_year_period_per_country <- sqldf("
SELECT
	fact.country,
	fact.start_year,
	fact.end_year,
	fact.Delta_Population,
	fact.Delta_GDP,
	fact.Delta_Per_Capita_GDP,
	fact.pct_change_Population,
	fact.pct_change_GDP,
	fact.pct_change_Per_Capita_GDP,
	a.greatest_change_in AS Greatest_Change1,
	b.greatest_change_in AS Greatest_Change2,
	c.greatest_change_in AS Greatest_Change3,
	d.greatest_change_in AS Greatest_Change4,
	e.greatest_change_in AS Greatest_Change5,
	f.greatest_change_in AS Greatest_Change6				

FROM
	stats_across_five_years fact
LEFT JOIN
	(SELECT
		country,
		MAX(Delta_Population) AS Delta_Population,
		max('Delta Population') AS greatest_change_in
	FROM
		stats_across_five_years
	group by
		1
	) a on
		a.country = fact.country and
		a.Delta_Population = fact.Delta_Population
LEFT JOIN
	(SELECT
		country,
		MAX(Delta_GDP) AS Delta_GDP,
		max('Delta_GDP') AS greatest_change_in
	FROM
		stats_across_five_years
	group by
		1
	) b on
		b.country = fact.country and
		b.Delta_GDP = fact.Delta_GDP
LEFT JOIN
	(SELECT
		country,
		MAX(Delta_Per_Capita_GDP) AS Delta_Per_Capita_GDP,
		max('Delta_Per_Capita_GDP') AS greatest_change_in
	FROM
		stats_across_five_years
	group by
		1
	) c on
		c.country = fact.country and
		c.Delta_Per_Capita_GDP = fact.Delta_Per_Capita_GDP
LEFT JOIN
	(SELECT
		country,
		MAX(pct_change_Population) AS pct_change_Population,
		max('%_change_Population') AS greatest_change_in
	FROM
		stats_across_five_years
	group by
		1
	) d on
		d.country = fact.country and
		d.pct_change_Population = fact.pct_change_Population
LEFT JOIN
	(SELECT
		country,
		MAX(pct_change_GDP) AS pct_change_GDP,
		max('% change_GDP') AS greatest_change_in
	FROM
		stats_across_five_years
	group by
		1
	) e on
		e.country = fact.country and
		e.pct_change_GDP = fact.pct_change_GDP
LEFT JOIN
	(SELECT
		country,
		MAX(pct_change_Per_Capita_GDP) AS pct_change_Per_Capita_GDP,
		max('% change_Per_Capita_GDP') AS greatest_change_in
	FROM
		stats_across_five_years
	group by
		1
	) f on
		f.country = fact.country and
		f.pct_change_Per_Capita_GDP = fact.pct_change_Per_Capita_GDP
WHERE
	a.country is not null OR b.country is not null OR c.country is not null OR d.country is not null OR e.country is not null OR f.country is not null
")

write.table(top_5_year_period_per_country, "./top_5_year_period_per_country.csv", sep = ",",row.names=FALSE)