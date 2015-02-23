workwd <- "/Users/sun/Documents/Work_place/R/learning/Exploratory_data_analysis"
setwd(paste(workwd,"/Assignment2/",sep=""))
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

library(plyr)
library(ggplot2)

NEI$year <- factor(NEI$year)
NEI$type <- factor(NEI$type)
# subset data for coal combustion 
SCC.coal<- SCC[union(grep("Coal", SCC[,"SCC.Level.Four"] ),grep("Coal",SCC[,"SCC.Level.Three"])),]
NEI.coal <- NEI[which(NEI$SCC %in% as.character(SCC.coal$SCC)),]
PM25.coal <- ddply(NEI.coal, "year", summarise,sum=sum(Emissions,na.rm=T))
# make the plot
p <-  ggplot(PM25.coal,aes(x=year,y=sum))
p + 
        geom_bar(stat="identity") +
        ggtitle("Changes of coal combustion-related emission")
        

dev.copy(png,"plot4.png")
dev.off()

# yet another subset using EI.Sector
SCC.coal1 <- SCC[grep("Coal",SCC$EI.Sector),]
NEI.coal1 <- NEI[which(NEI$SCC %in% as.character(SCC.coal1$SCC)),]
PM25.coal1 <- ddply(NEI.coal1, "year", summarise,sum=sum(Emissions,na.rm=T))

q <- ggplot(PM25.coal1,aes(x=year,y=sum))
q +
        geom_bar(stat="identity")+
        ggtitle("Changes of coal combustion-related emission")
dev.copy(png,"plot4-1.png")
dev.off()
