## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

baltimore <- subset(NEI, fips == "24510")

# Transform year to factor of year
baltimore <- transform(baltimore, year = factor(year))

# construct dataframe of total emissions
df <- data.frame(Total = with(baltimore, tapply(Emissions, year, sum, na.rm = T)))

# Initiate the png file 
png("Plot2.png", width = 480, height = 480)

# Plot the First part of quiz
plot(rownames(df),
     df$Total, 
     type = "l", 
     col = "green", 
     lwd = 2, 
     ylab = "Total emissions",
     xlab="Year",
     main = "PM2.5 decreased in the Baltimore from 1999 to 2008")

# Just for fun, add data points over the line
points(rownames(df),df$Total, cex=1, col="red", lwd=2)

## Save the plot in png file
dev.off()