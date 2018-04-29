library(dplyr)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(data.table)

setwd("~/Desktop/NYCDSA/R/Shiny_App_Project/data-science-for-good-kiva-crowdfunding")

#create Kiva Loans Datasets and merge
kiva_loans = fread('kiva_loans.csv', nrows = -1, header = T, stringsAsFactors = TRUE)
#kiva_geompi = fread('kiva_mpi_region_locations.csv', nrows = -1, header = T, stringsAsFactors = T)
#kiva_compliled = merge(kiva_loans,kiva_geompi)

# Sum of loans, count of borrowers by country
funds_by_countrypart1 = kiva_loans %>% group_by(., country) %>%
  summarise(.,funded_total = sum(funded_amount),loan_total = sum(loan_amount), countTotalBorrow = n()) %>%
  arrange(., -funded_total)

# Number of Repeat Borrowers
countReborrow = kiva_loans %>% 
  group_by(country) %>% 
  filter(tags%like% "#Repeat Borrower") %>% 
  summarise(countReborrow = n())

#Joined tables with Repeat Borrower Ratio
funds_by_country = left_join(funds_by_countrypart1, countReborrow, by = c("country" = "country"))
funds_by_country$reborrow_ratio = funds_by_country$countReborrow/funds_by_country$countTotalBorrow*100
reborrow_by_country = arrange(funds_by_country, -funds_by_country$reborrow_ratio) %>%
  group_by(., country)


#export clean csv
write.csv(funds_by_country, file = '~/Desktop/NYCDSA/R/Shiny_App_Project/data-science-for-good-kiva-crowdfunding/Kiva_clean.csv')

#import csv's
mpi = fread('mpi.csv', nrows = -1, header = T, stringsAsFactors = TRUE)
kiva_clean = read.csv('~/Desktop/NYCDSA/R/Shiny_App_Project/data-science-for-good-kiva-crowdfunding/Kiva_clean.csv')



kiva_clean = left_join(kiva_clean,mpi, by='name')
kiva_clean
#geoloc = fread('countrygeocoderefined.csv', nrows = -1, header = T, stringsAsFactors = TRUE)
#kivafullyclean = left_join(funds_by_country,mpi, by='country')
#kivafullyclean = left_join(kivafullyclean, geoloc, by= 'country')
#write.csv(kivafullyclean, file = '~/Desktop/NYCDSA/R/Shiny_App_Project/data-science-for-good-kiva-crowdfunding/Kivafullyclean.csv')







