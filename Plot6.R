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

# Select all the observations which are vehicles-based and located in LA.
LA_vehicles <- subset(NEI, SCC %in% vehicles$SCC & fips == "06037")

# Transform year to factor of year
baltimore_vehicles <- transform(baltimore_vehicles, year = factor(year))

# Transform year to factor of year
LA_vehicles <- transform(LA_vehicles, year = factor(year))

# construct dataframe of total emissions
baltimore <- data.frame(Total = with(baltimore_vehicles, tapply(Emissions, year, sum, na.rm = T)))

# construct dataframe of total emissions
LA <- data.frame(Total = with(LA_vehicles, tapply(Emissions, year, sum, na.rm = T)))

# Initiate the png file
png("Plot6.png", width = 480, height = 480)

par(mfrow=c(1,2))

plot(rownames(baltimore),
baltimore$Total,
type = "o",
col = "green",
lwd = 2,
ylab = "Emissions",
xlab="Year",
main = "Baltimore", ylim = c(0,5000))


plot(rownames(LA),
     LA$Total,
     type = "o",
     col = "green",
     lwd = 2,
     ylab = "Emissions",
     xlab="Year",
     main = "Los Angles", ylim = c(0,5000))

## Save the plot in png file
dev.off()