#plot6
#Compare emissions from motor vehicle sources in Baltimore City with emissions
#from motor vehicle sources in Los Angeles County, California (fips == "06037").
#Which city has seen greater changes over time in motor vehicle emissions?

nei <- readRDS("./data/summarySCC_PM25.rds")
# str(nei)

scc <- readRDS("./data/Source_Classification_Code.rds")
# str(scc)
library(dplyr)
#I just make thing simple to select from rows that have "Mobile Sources" in SCC.Level.One
mobilefilter <- filter(scc,SCC.Level.One=="Mobile Sources") %>%
  select(SCC,SCC.Level.One)


twocitymobilenei <- filter(nei,SCC %in% mobilefilter$SCC,fips %in% c("24510","06037")) %>%
  group_by(year,fips) %>%
  summarise(totalemission = sum(Emissions)) %>%
  mutate(City=factor(fips,labels=c("Los Angeles","Baltimore City")),
         logemission=log(totalemission))

#reshape the dataset to feed the ggplot function(long dataset)
library(tidyr)
tidynei <- gather(twocitymobilenei,emissions,tons,-year,-fips,-City)
tidynei$emissions <- factor(tidynei$emissions,levels=c("totalemission","logemission"),
                            labels = c("absolute change(tons)","relative change(log)"))


#joindf <- left_join(coalscc,nei,by=c("SCC"="SCC"))
library(ggplot2)
png("./figure/plot6.png")
ggplot(tidynei,aes(x=year,y=tons,colour=City))+
  geom_point()+
  geom_line(linetype="dotted")+
  labs(x="Year",
       y="PM2.5 emission",
       title="PM2.5 emission from mobile sources")+
  facet_wrap(~emissions,scales = "free_y")+
  theme_light(base_size=15)

dev.off()
