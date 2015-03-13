#plot6

nei <- readRDS("./data/summarySCC_PM25.rds")
# str(nei)

scc <- readRDS("./data/Source_Classification_Code.rds")
# str(scc)
library(dplyr)
mobilefilter <- filter(scc,SCC.Level.One=="Mobile Sources") %>%
  select(SCC,SCC.Level.One)


mobilenei <- filter(nei,SCC %in% mobilefilter$SCC,fips %in% c("24510","06037")) %>%
  group_by(year,fips) %>%
  summarise(totalemission = sum(Emissions)/1000) %>%
  mutate(City=factor(fips,labels=c("California","Maryland")))

#joindf <- left_join(coalscc,nei,by=c("SCC"="SCC"))
library(ggplot2)
png("./figure/plot6.png")
ggplot(mobilenei,aes(x=year,y=totalemission,colour=City))+
  geom_point()+
  geom_line(linetype="dotted")+
  labs(x="Year",
       y="PM2.5 emission(thousands tons)",
       title="PM2.5 emission from mobile sources")+
  theme_light(base_size=15)

dev.off()
