workwd <- "/Users/sun/Documents/Work_place/R/learning/Exploratory_data_analysis"
setwd(paste(workwd,"/Assignment2/",sep=""))
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

library(plyr)

NEI$year = factor(NEI$year)
# subset data for Baltimore city and sum the emissions for each year
NEI.baltimore <- subset(NEI,subset = NEI$fips=="24510")
PM25.baltimore <- ddply(NEI.baltimore, "year",summarise,sum=sum(Emissions,na.rm=T))
# make the plot
barplot(t(PM25.baltimore$sum),names.arg = PM25.baltimore$year,xlab="year",ylab="total emission",main="Total emission of PM2.5 in Baltimore")
dev.copy(png,"plot2.png")
dev.off()