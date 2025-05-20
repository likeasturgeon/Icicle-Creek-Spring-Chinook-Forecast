##############

##############

# Load libraries and import PTAGIS dataset
library(dplyr)
library(readr)
library(tidyr)
library(tibble)
library(XLConnect)
library(lubridate)

setwd("C:/Users/kubab/Documents/DataProjects/GitHub/Icicle-Creek-Spring-Chinook-Forecast")
#Import PTAGIS Dataset; Data was queried on PTAGIS for LNFH tagged fish
# migrating up the mainstem, including overshoots at TUF and RRF.
# The raw data is a ftp connection updated daily.

dataURL <- "C:/Users/kubab/Downloads/LNFH_PIT_IS.csv" # temporary path while connection is fixed
#dataURL <- "https://api.ptagis.org/reporting/reports/likeasturgeon/file/LNFH_PIT_IS.csv"
LNFH_Returns <- read.csv(dataURL, 
                         fileEncoding = "UTF-16LE",
                        stringsAsFactors = FALSE)

LNFH_Returns$Release.Date <- mdy(
  LNFH_Returns$Release.Date.MMDDYYYY, format = "%M/%d/%Y") #


LNFH_Returns$First.Obs.Date.Max <- ymd(
  LNFH_Returns$First.Obs.Date.Max)

LNFH_Returns$Last.Obs.Date.Max<- mdy(
  LNFH_Returns$Last.Obs.Date.Max)


#Import Run Reconstruction for pasmdy()#Import Run Reconstruction for past years' comparison
filepathRun <- "Icicle R  Spring Chinook Run Reconstruction_01092018.xlsx"
RunReconTble <- read_xlsx(path = filepathRun, 
                          sheet = "Icicle Run ReconstructionUpdate", 
                          range = 'B4:M23') %>% 
  select(Year, Run)

PITratios <- read.csv("PITratios.csv")
PITratios <- PITratios %>%
  select(Release.Year, Release.Number, X..PIT, PIT.Ratio.Non.Tag.Tag)%>%
  rename(RelYear = Release.Year, Ratio = PIT.Ratio.Non.Tag.Tag)

# Select  most useful fields in PTAGIS query, and add Age column using mutate()
myReturns <- LNFH_Returns %>% 
  select(Tag, Site, First.Obs.Date.Max, Brood.Year, Release.Date
  ) %>% mutate(
    Age = as.integer(format(LNFH_Returns$First.Obs.Date.Max,"%Y")) - Brood.Year 
  )

#CLEANUP
### Cleanup colnames
colnames(myReturns) <- c("Tagcode", "SiteName", "FirstDate", "BroodYear", "RelYear", "Age")
### Abbreviate Site
myReturns$SiteName = substr(myReturns$SiteName, 1,3) 

# Filter on age 3,4,5
Adult_migrants <- myReturns %>%
  filter( Age > 2 & Age < 6)

# Convert detection date to migration year
Adult_migrants$FirstDate <- year(Adult_migrants$FirstDate)
Adult_migrants$RelYear <- year(Adult_migrants$RelYear)

# Pivot Adult_migrants and get counts
pivot <- Adult_migrants %>%
  filter(duplicated(paste(Adult_migrants$Tagcode, Adult_migrants$SiteName) != TRUE)) %>% # remove dupes
  count(FirstDate, SiteName) %>% 
  spread(SiteName, n, fill=0) %>% 
  arrange(FirstDate) %>% 
  mutate(BON = BCC+BO1+BO2+BO3+BO4, 
         MCN = MC1+MC2)%>%
  mutate(GrandTotal=BON+ICL) %>%
  rename(Year = FirstDate)

#Calculate Conversion and view key sites
ConversionTbl <- pivot %>%
  select(Year,BON, MCN, ICL) %>%
  mutate("Conversion" = round( ( (ICL / ICLefficiency) / BON),3)) %>%
  filter( Year > 2011)


# This is the ICL array efficiency 
# used to correct the ICL detection rate in next step
ICLefficiency <- 0.87

#Find Average and correct it by factor of ICLefficiency
conversionRate <- round(mean(ConversionTbl$Conversion), 3)

Run Script
