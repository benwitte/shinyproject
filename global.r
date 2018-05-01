library(dplyr)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(data.table)
library(shiny)
library(data.table)
library(shinydashboard)
library(leaflet)
library(geojson)
library(geojsonio)
library(rgdal)
library(sp)
library(tigris)
library(sf)
library(shinythemes)
library(googleVis)
library(RSQLite)
library(dashboardthemes)



mpi = fread('mpi.csv', nrows = -1, header = T, stringsAsFactors = TRUE)
mpi$country = mpi$name
kiva_joined = read.csv('~/Desktop/NYCDSA/R/Shiny_App_Project/data-science-for-good-kiva-crowdfunding/Kiva_clean.csv')
kiva_joined = left_join(kiva_joined,mpi, by='country')
kiva_clean = kiva_joined
kiva_clean$X = NULL
kiva_clean$funded_total = NULL
kiva_clean$name = NULL
kiva_clean = kiva_clean %>% arrange(., country)

#kiva_clean$X = NULL

kivasummary = kiva_clean %>%
  summarise(mean(kiva_clean$loan_total), 
            mean(kiva_clean$countTotalBorrow),
            mean(kiva_clean$countReborrow, na.rm = T),
            mean(kiva_clean$reborrow_ratio, na.rm = T),
            mean(kiva_clean$MPI, na.rm = T),
            mean(kiva_clean$Percent_in_Poverty, na.rm = T))

#test <- kiva_clean %>% filter(., country %in% c("All"))
#transpose(test)


kivasummaryasdf = transpose(data.frame(kivasummary))
names(kivasummaryasdf)[names(kivasummaryasdf) == 'V1'] <- 'Global_Averages'
kivasummaryasdf$Measure = c('Sum of Loans', 
                            'Number of borrowers', 
                            'Number of Repeat Borrowers', 
                            'Repeat/First Time Borrower Ratio',
                            'MPI',
                            'Percent in Poverty')
kivasummaryasdf =  kivasummaryasdf[c(2,1)]



userchoice <- c('loan_total', 'countTotalBorrow', 'countReborrow', 'reborrow_ratio', 'MPI', 'Percent_in_Poverty')

countrychoice = c('All', kiva_clean$country)

filtered_map = kiva_clean

