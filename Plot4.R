library("data.table")
setwd("~/Downloads/Quiz/")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

SCCt <- data.table(SCC)

# Filter for all Coal consumer in SCC dataset
coal <- SCCt[grep("Coal",EI.Sector), "SCC"]

# Select all the observations which used coal as fuel.
coal_metrics <- subset(NEI, SCC %in% coal$SCC)

# Transform year to factor of year
coal_metrics <- transform(coal_metrics, year = factor(year))

# construct dataframe of total emissions
df <- data.frame(Total = with(coal_metrics, tapply(Emissions, year, sum, na.rm = T)))

# Initiate the png file
png("Plot4.png", width = 480, height = 480)

plot(rownames(df),
     df$Total, 
     type = "l", 
     col = "green", 
     lwd = 2, 
     ylab = "Emissions",
     xlab="Year",
     main = "Coal combustion-related sources changed from 1999-2008")

# Just for fun, add data points over the line
points(rownames(df),df$Total, cex=1, col="red", lwd=2)

## Save the plot in png file
dev.off()