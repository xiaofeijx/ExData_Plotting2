#plot4
#Across the United States, how have emissions from coal combustion-related 
#sources changed from 1999–2008?

nei <- readRDS("./data/summarySCC_PM25.rds")
# str(nei)

scc <- readRDS("./data/Source_Classification_Code.rds")

# find rows where the variable SCC.Level.Three   have "Coal" in it
coalfilter <- grep("Coal",scc$SCC.Level.Three)


library(dplyr)
#filter SCC according coalfilter 
coalscc <- scc[coalfilter,c("SCC","SCC.Level.Three")]

##filter nei according SCC code that is in coalscc$SCC
coalnei <- filter(nei,SCC %in% coalscc$SCC) %>%
  group_by(year) %>%
  summarise(totalemission = sum(Emissions)/10000)


#joindf <- left_join(coalscc,nei,by=c("SCC"="SCC"))
library(ggplot2)
png("./figure/plot4.png")
ggplot(coalnei,aes(x=year,y=totalemission))+
  geom_point()+
  geom_line(linetype="dotted")+
  labs(x="Year",
       y="PM2.5 emission(10 thousands tons)",
       title="PM2.5 emission from coal combustion-related souces")+
  theme_light(base_size=15)
 
dev.off()
  
  

