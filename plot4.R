library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

mergedData <- merge(NEI, SCC, by="SCC")

#Across the United States, 
#how have emissions from coal combustion-related sources changed from 1999–2008?

# find the index related with coal within the records
index  <- grepl("coal", mergedData$Short.Name, ignore.case=TRUE)
subsetofmerge <- mergedData[index, ]

aggregatByYear <- aggregate(Emissions ~ year, data = subsetofmerge, sum)

png("plot4.png", width=600, height=450)
g <- ggplot(aggregatByYear, aes(factor(year), Emissions))
g <- g + theme_bw() + geom_bar(fill="red",stat="identity") +
        xlab("years") +
        ylab("PM2.5 Emissions") +
        ggtitle("PM2.5 Emissions from coal sources of different years")
print(g)
dev.off()
