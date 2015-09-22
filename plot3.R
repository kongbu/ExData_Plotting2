
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

BaltimoreNEI  <- NEI[NEI$fips=="24510", ]

aggregatedByYearType <- aggregate(Emissions ~ year + type, data = BaltimoreNEI, sum)

png("plot3.png", width=600, height=450)
g <- ggplot(aggregatedByYearType, aes(year, Emissions, color = type))
g <- g + theme_bw() + geom_line(size=1.5) + xlab("years") + ylab("PM2.5 Emissions") +
            ggtitle("PM2.5 Emissions of Baltimore City of different years")
print(g)
dev.off()
