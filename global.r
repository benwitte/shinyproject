library(dplyr)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(data.table)
library(shiny)
library(data.table)
library(shinydashboard)
library(shinyGlobe)
library(leaflet)
library(geojson)
library(geojsonio)
library(rgdal)
library(sp)
library(tigris)


#maybe ignore this stuff
Kivaclean = fread('~/Desktop/NYCDSA/R/Shiny_App_Project/data-science-for-good-kiva-crowdfunding/Kivafullyclean.csv', drop = 'V1')
kivaglob = Kivaclean[,c('lat','long','MPI')]


#import geojson
borders = geojson_read("~/Desktop/NYCDSA/R/Shiny_App_Project/data-science-for-good-kiva-crowdfunding/countries.geo.json", what = "sp")

# Match data
kivamap <- geo_join(borders, kiva_clean, 'name', "name")
class(kivamap)
View(kivamap)


kiva_clean$loan_total <- as.numeric(as.character(kiva_clean$loan_total))
pal <- colorBin("Reds", c(1000, 55342225
), na.color = "#808080")
#, alpha = FALSE, reverse = FALSE)


# Create a popup
country_popup <- paste0("<strong>Country: </strong>", 
                      kivamap$name, 
                      "<br><strong>Sum of loans: </strong>", 
                      kivamap$loan_total)



userchoice <- c('funded_total', 'loan_total', 'countTotalBorrow', 'countReborrow', 'reborrow_ratio', 'MPI', 'Percent_in_Poverty')

userchoice


# Create a map
#leaflet(kivamap) %>% 
#  addProviderTiles(providers$Stamen.TonerLite) %>%  
 # setView(lng = 00.00, lat = 00.00, zoom=0.5) %>%  
#  addPolygons(color = "#444444", weight = 1, 
              # opacity = 0.5, 
 #             fillOpacity = 0.7,
#              fillColor = ~pal(kivamap$loan_total),
#              popup = country_popup) %>%
#  addLegend("bottomright", pal = pal, values = ~kivamap$loan_total, 
#            opacity = 1,
#            title = "Sum of Loans by Country")


#kivamap$MPI

