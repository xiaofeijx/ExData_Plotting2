#plot3

nei <- readRDS("./data/summarySCC_PM25.rds")

library(dplyr)
nei <- tbl_df(nei)
groupdf <- 
  group_by(nei,year,type) %>% 
  summarise(totalemission = sum(Emissions)) %>% 
  mutate(totalemission = totalemission/10000 )

library(ggplot2)
png("./figure/plot3.png")
p <-  ggplot(data=groupdf,aes(x=year,y=totalemission))+
  geom_line()+
  geom_point()+
  facet_wrap(~type,scales="free_y")+
  labs(x="Year",y="PM2.5 emission(10 thousands tons)",title="Total PM2.5 emission of four types of souces")

p + theme_light()

dev.off()



