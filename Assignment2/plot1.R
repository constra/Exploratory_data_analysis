workwd <- "/Users/sun/Documents/Work_place/R/learning/Exploratory_data_analysis"
setwd(paste(workwd,"/Assignment2/",sep=""))
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

library(plyr)

NEI$year = factor(NEI$year)
# sum the emissions for each year
PM25sum <- ddply(NEI, "year",summarise,sum=sum(Emissions,na.rm=T))
# make the plot
barplot(t(PM25sum$sum),names.arg = PM25sum$year,xlab="year",ylab="total emission",main="Total emission of PM2.5")
dev.copy(png,"plot1.png")
dev.off()
