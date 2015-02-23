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
NEI.vehicle.baltimore <- subset(NEI.vehicle,subset = NEI$fips=="24510")
PM25.vehicle.baltimore <- ddply(NEI.vehicle.baltimore[complete.cases(NEI.vehicle.baltimore),], "year", summarise,sum=sum(Emissions,na.rm=T))

# make the plot
p <-  ggplot(PM25.vehicle.baltimore,aes(x=year,y=sum))
p + 
        geom_bar(stat="identity") +
        ggtitle("Motor vehicle total emission in Baltimore")
        

dev.copy(png,"plot5.png")
dev.off()
