library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mergedData <- merge(NEI, SCC, by="SCC")

#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

# find the index related with motor vehicle in Baltimore and LA
BaltimoreLA <- mergedData[mergedData$fips=="24510"|mergedData$fips=="06037", ]
index  <- grepl("vehicles", BaltimoreLA$SCC.Level.Two, ignore.case=TRUE)
subsetofmerge <- BaltimoreLA[index, ]

aggregatedByYearFips <- aggregate(Emissions ~ year + fips, data = subsetofmerge, sum)
# change the fips names
aggregatedByYearFips$fips[aggregatedByYearFips$fips=="06037"] <- "Los Angeles, CA"
aggregatedByYearFips$fips[aggregatedByYearFips$fips=="24510"] <- "Baltimore, MD"



png("plot6.png", width=1200, height=900)
g <- ggplot(aggregatedByYearFips, aes(factor(year), Emissions))
g <- g + theme_bw() + facet_grid(. ~ fips) + geom_bar(fill="red",stat="identity") +
        xlab("years") +
        ylab("PM2.5 Emissions") +
        ggtitle("PM2.5 Emissions of Baltimore City vs Los Angeles from motor vehicle sources of different years")
print(g)
dev.off()
