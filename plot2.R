#plot2
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
     main="Total PM2.5 emission in Maryland,Baltimore City",
     xlab="year",
     ylab="PM2.5 emission(tons)")

dev.off()
