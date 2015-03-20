#plot5
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City


nei <- readRDS("./data/summarySCC_PM25.rds")
# str(nei)

scc <- readRDS("./data/Source_Classification_Code.rds")
# str(scc)
library(dplyr)
#I just make thing simple to select from rows that have "Mobile Sources" in SCC.Level.One
mobilefilter <- filter(scc,SCC.Level.One=="Mobile Sources") %>%
  select(SCC,SCC.Level.One)

#filter the nei rows which SCC was contian in mobilefilter$SCC and 
#fips==24510
mobilenei <- filter(nei,SCC %in% mobilefilter$SCC,fips=="24510") %>%
  group_by(year) %>%
  summarise(totalemission = sum(Emissions)/1000)

#joindf <- left_join(coalscc,nei,by=c("SCC"="SCC"))
library(ggplot2)
png("./figure/plot5.png")
ggplot(mobilenei,aes(x=year,y=totalemission))+
  geom_point()+
  geom_line(linetype="dotted")+
  labs(x="Year",
       y="PM2.5 emission(thousands tons)",
       title="PM2.5 emission from mobile sources in Baltimore city")+
  theme_light(base_size=15)

dev.off()

