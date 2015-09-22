library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mergedData <- merge(NEI, SCC, by="SCC")

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# find the index related with motor vehicle in Baltimore City
BaltimoreMerged <- mergedData[mergedData$fips=="24510", ]
index  <- grepl("vehicles", BaltimoreMerged$SCC.Level.Two, ignore.case=TRUE)
subsetofmerge <- BaltimoreMerged[index, ]

aggregatByYear <- aggregate(Emissions ~ year, data = subsetofmerge, sum)

png("plot5.png", width=600, height=450)
g <- ggplot(aggregatByYear, aes(factor(year), Emissions))
g <- g + theme_bw() + geom_bar(fill="red",stat="identity") +
        xlab("years") +
        ylab("PM2.5 Emissions") +
        ggtitle("PM2.5 Emissions of Baltimore City from motor vehicle sources of different years")
print(g)
dev.off()
