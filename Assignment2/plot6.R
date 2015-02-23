workwd <- "/Users/sun/Documents/Work_place/R/learning/Exploratory_data_analysis"
setwd(paste(workwd,"/Assignment2/",sep=""))
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

library(plyr)
library(ggplot2)

NEI$year <- factor(NEI$year)
NEI$type <- factor(NEI$type)

# subset data for coal combustion 
SCC.vehicle<- SCC[grep("Vehicles",SCC$EI.Sector),]
NEI.vehicle <- NEI[which(NEI$SCC %in% as.character(SCC.vehicle$SCC)),]
NEI.vehicle.dual <- NEI.vehicle[NEI.vehicle$fips %in% c("24510","06037"),]
PM25.vehicle.dual <- ddply(NEI.vehicle.dual[complete.cases(NEI.vehicle.dual),], c("year","fips"), summarise,sum=sum(Emissions,na.rm=T))

# make the plot
p <-  ggplot(PM25.vehicle.dual,aes(x=year,y=sum,fill=fips))
p + 
        geom_bar(stat="identity",position="dodge") +
        ggtitle("Motor vehicle total emission in Baltimore and LA") +
        labs(x="Year",y="sum of the emission") + 
        scale_fill_discrete(labels=c("LA","Baltimore"))


dev.copy(png,"plot6.png")
dev.off()

