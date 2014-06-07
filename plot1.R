

plotMe <- function( workingDirectory ){
				setwd(workingDirectory)
				data <- read.table( "household_power_consumption.txt", header=TRUE, na.strings="?", sep=";", stringsAsFactors=FALSE)
				tidy <- data[( as.Date( data$Date, "%d/%m/%Y") == "2007-02-01" |  as.Date( data$Date, "%d/%m/%Y") == "2007-02-02"),]
				png("plot1.png")
				hist(tidy$Global_active_power, col="red", xlab="Global Active Power(kilowatts)", main="Global Active Power")
				dev.off()
}