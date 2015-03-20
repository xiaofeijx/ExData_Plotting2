#plot3
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
#variable, which of these four sources have seen decreases in emissions from 1999–2008 
#for Baltimore City? Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

nei <- readRDS("./data/summarySCC_PM25.rds")

library(dplyr)
nei <- tbl_df(nei)
typedf <- filter(nei,fips=="24510") %>%
  group_by(year,type) %>% 
  summarise(totalemission = sum(Emissions)) %>% 
  mutate(totalemission = totalemission )

library(ggplot2)
png("./figure/plot3.png")
p <-  ggplot(data=typedf,aes(x=year,y=totalemission))+
  geom_line()+
  geom_point()+
  facet_wrap(~type,scales="free_y")+
  labs(x="Year",y="PM2.5 emission(tons)",title="Total PM2.5 emission of four types of souces in Baltimore City")

p + theme_light()

dev.off()



