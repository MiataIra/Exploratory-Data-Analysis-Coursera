rm(list = ls())
library(hms)
library(dplyr)
Sys.setlocale("LC_ALL", "English") # for English weekday
Sys.setenv("LANGUAGE"="En")

My_data<-read.table("./exdata_data_household_power_consumption/household_power_consumption.txt",
                    sep=";",header=TRUE,
                    stringsAsFactors = FALSE) #load dataset

My_data$Date<-as.Date(My_data$Date, format='%d/%m/%Y')


My_data<-filter(My_data, Date=="2007-02-01" | Date=="2007-02-02")
My_data$Time<-as_hms(My_data$Time)
My_data$Global_active_power<-as.numeric(My_data$Global_active_power)
My_data$Global_reactive_power<-as.numeric(My_data$Global_reactive_power)
My_data$Voltage<-as.numeric(My_data$Voltage)
My_data$Global_intensity<-as.numeric(My_data$Global_intensity)
My_data$Sub_metering_1<-as.numeric(My_data$Sub_metering_1)
My_data$Sub_metering_2<-as.numeric(My_data$Sub_metering_2)

My_data<-mutate((My_data), date_time=paste(Date, Time, sep=" "))

My_data$date_time<-as.POSIXlt(My_data$date_time)


png("plot2.png", width=480, height=480)
plot(x=My_data$date_time, y=My_data$Global_active_power, type="n", xlab =" ", ylab = "Global Active Power (kilowatts)")
lines(x=My_data$date_time, y=My_data$Global_active_power)
dev.off()


