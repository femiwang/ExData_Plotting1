##load libraries
library(dplyr)
library(tidyr)
library(sqldf)

##read only required data from text file with read.csv.sql() package

data1 <- read.csv.sql(file = "./household_power_consumption.txt", sep = ";", 
          sql = "select * from file where Date = '1/2/2007'")
data2 <- read.csv.sql(file = "./household_power_consumption.txt", sep = ";", 
          sql = "select * from file where Date = '2/2/2007'")

data <- bind_rows(sdata1, sdata2)

##convert all names to lower case

colnames(data) <- tolower(colnames(data))

##convert Date and Time variables using as.Date() and strptime() 
##consider using chainin
data_date <- transform(data, date = as.Date(date, "%d/%m/%Y"))
data_time <- transform(data_date, time = strptime(paste(date, time), 
                                             format = "%Y-%m-%d %H:%M:%S"))
data <- data_time

##set device and file name to copy to
dev.copy(device = png, file = "plot1.png",width = 480, height = 480)

##first plot
hist(data$global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

dev.off()