## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

BaltimoreNEI  <- NEI[NEI$fips=="24510", ]

aggregatByYear <- aggregate(Emissions ~ year, data = BaltimoreNEI, sum)

png('plot2.png')
barplot(height=aggregatByYear$Emissions, names.arg=aggregatByYear$year, col="red", xlab="years", ylab="PM2.5 emissions", main="PM2.5 emissions of Baltimore City of different yeaers")
dev.off()
