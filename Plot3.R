library("data.table")
library("ggplot2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

baltimore <- subset(NEI, fips == "24510")

dt <- data.table(baltimore)
res <- dt[, .(sum(Emissions)), by = .(type,year)]
names(res) <- c("Type", "Year", "Emissions")

# Initiate the png file 
png("Plot3.png", width = 480, height = 480)

# Plot the First part of quiz
qplot(Year, Emissions , data = res, col = Type, geom = "line", main = "Baltimore PM2.5 changes in various types")

## Save the plot in png file
dev.off()