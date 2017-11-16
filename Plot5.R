library("data.table")
setwd("~/Downloads/Quiz/")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

SCCt <- data.table(SCC)

# Filter for all vehicles in SCC dataset
vehicles <- SCCt[grep("Vehicles",EI.Sector, ignore.case = TRUE), "SCC"]

# Select all the observations which are vehicles-based and located in baltimore.
baltimore_vehicles <- subset(NEI, SCC %in% vehicles$SCC & fips == "24510")

# Transform year to factor of year
baltimore_vehicles <- transform(baltimore_vehicles, year = factor(year))

# construct dataframe of total emissions
df <- data.frame(Total = with(baltimore_vehicles, tapply(Emissions, year, sum, na.rm = T)))

# Initiate the png file
png("Plot5.png", width = 480, height = 480)

plot(rownames(df),
     df$Total, 
     type = "l", 
     col = "green", 
     lwd = 2, 
     ylab = "Emissions",
     xlab="Year",
     main = "Motor vehicle sources changed from 1999-2008")

# Just for fun, add data points over the line
points(rownames(df),df$Total, cex=1, col="red", lwd=2)

## Save the plot in png file
dev.off()