library(dplyr)
rm(list=ls())
setwd("~/R/Coursera/4-ExploratoryDataAnalysis/courseproject1")
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "Electric power consumption.zip")
dateDownloaded<-date()
unzip("Electric power consumption.zip")

#The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate 
#of how much memory the dataset will require in memory before reading into R. 
#Make sure your computer has enough memory (most modern computers should be fine).

if (memory.size (max=TRUE) > 2075259 * 9 * 8) {
  warning("There is insufficient memory.  Stop")
} else {
  
  EPC<-read.table("Household_power_consumption.txt", header=TRUE, stringsAsFactors=FALSE, sep=";")
  # We will only be using data from the dates 2007-02-01 and 2007-02-02.
  EPCsubset<- filter(EPC, Date=="1/2/2007" | Date=="2/2/2007")
  EPCsubset$DTG<-strptime(paste(EPCsubset$Date, EPCsubset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

  png("plot3.png", width=480, height=480)
  plot(EPCsubset$DTG, EPCsubset$Sub_metering_1, col="black", type='l', ylab="Energy sub metering", xlab="")
  lines(EPCsubset$DTG, EPCsubset$Sub_metering_2, col="red", type='l')
  lines(EPCsubset$DTG, EPCsubset$Sub_metering_3, col="blue", type='l')
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))
  dev.off()
}