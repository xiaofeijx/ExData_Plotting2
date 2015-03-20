#plot2
#Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system 
#to make a plot answering this question.


nei <- readRDS("./data/summarySCC_PM25.rds")

scc <- readRDS("./data/Source_Classification_Code.rds")


library(dplyr)
nei <- tbl_df(nei)
marygroupbyyear <- 
  filter(nei,fips=="24510") %>%
  group_by(year) %>% 
  summarise(totalemission = sum(Emissions)) %>% 
  mutate(totalemission = totalemission )

png("./figure/plot2.png")

plot(marygroupbyyear$year,marygroupbyyear$totalemission,
     type="b",
     lty=3,
     pch=19,
     main="Total PM2.5 emission in Baltimore City,Maryland",
     xlab="year",
     ylab="PM2.5 emission(tons)")

dev.off()
