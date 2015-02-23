workwd <- "/Users/sun/Documents/Work_place/R/learning/Exploratory_data_analysis"
setwd(paste(workwd,"/Assignment2/",sep=""))
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

library(plyr)
library(ggplot2)

NEI$year <- factor(NEI$year)
NEI$type <- factor(NEI$type)
# subset data for Baltimore city and sum the emissions for each year
NEI.baltimore <- subset(NEI,subset = NEI$fips=="24510")
PM25.baltimore <- ddply(NEI.baltimore, c("year","type"),summarise,sum=sum(Emissions,na.rm=T))
# make the plot
p <-  ggplot(PM25.baltimore,aes(x=year,y=sum,fill=type))
p + 
        geom_bar(stat="identity",position="dodge") +
        ggtitle("Total emission of PM2.5 in Baltimore split by type")
        

dev.copy(png,"plot3.png")
dev.off()
