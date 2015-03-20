#plot1
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
#for each of the years 1999, 2002, 2005, and 2008.

nei <- readRDS("./data/summarySCC_PM25.rds")

scc <- readRDS("./data/Source_Classification_Code.rds")


library(dplyr)
#make nei to a tbl_df object
nei <- tbl_df(nei)
#group the data by year and caculate total emissions each year in million tons
groupbyyear <- 
  group_by(nei,year) %>% 
  summarise(totalemission = sum(Emissions)) %>% 
  mutate(totalemission = totalemission/1000000 )

png("./figure/plot1.png")

plot(groupbyyear$year,groupbyyear$totalemission,
     type="b",
     lty=3,
     pch=19,
     main="Total PM2.5 emission from all sources from 1999 to 2008",
     xlab="year",
     ylab="PM2.5 emission(million tons)")

dev.off()


