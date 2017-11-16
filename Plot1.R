## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./exdata%2Fdata%2FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata%2Fdata%2FNEI_data/Source_Classification_Code.rds")

# Transform year to factor of year
NEI <- transform(NEI, year = factor(year))

# construct dataframe of total emissions
df <- data.frame(Total = with(NEI, tapply(Emissions, year, sum, na.rm = T)))

# Initiate the png file 
png("Plot1.png", width = 480, height = 480)

# Plot the First part of quiz
plot(rownames(df),
     df$Total, 
     type = "l", 
     col = "green", 
     lwd = 2, 
     ylab = "Total emissions",
     xlab="Year",
     main = "PM2.5 decreased in the US from 1999 to 2008")

# Just for fun, add data points over the line
points(rownames(df),df$Total, cex=1, col="red", lwd=2)

## Save the plot in png file
dev.off()