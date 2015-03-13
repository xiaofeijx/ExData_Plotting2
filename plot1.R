#plot1

nei <- readRDS("./data/summarySCC_PM25.rds")

scc <- readRDS("./data/Source_Classification_Code.rds")


library(dplyr)
nei <- tbl_df(nei)
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


