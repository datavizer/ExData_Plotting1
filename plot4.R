# Initiailization and retrieve data -------------------------------------------------
  wd <- "~/GitHub/ExData_Plotting1"
  setwd(wd)

# Estimate size of data file
  m <- matrix(1,nrow=2e6,ncol=9)
  m <- as.data.frame(m)
  print(object.size(m),units="Mb")
  rm(m)

# Load base table, convert characters to data, add date time
  setwd("./data")
  consump <- read.table("household_power_consumption.txt", 
                      sep = ";", header = TRUE, as.is = TRUE,
                      na.strings = "?", colClasses = 
                              c("character", "character", rep("numeric",7)))

  datetime <- with(consump, paste(Date, Time))
  consump$Date_Time <- strptime(datetime, "%d/%m/%Y %H:%M:%S" )
  consump$Date  <- as.Date(consump$Date, "%d/%m/%Y" )
  consump$Time  <- strptime(consump$Time, format = "%H:%M:%S")
  rm(datetime)

# Subset applicable date range
  cons_set <- subset(consump, Date >= "2007-02-01" 
                   & Date <= "2007-02-02")
  rm(consump)

# Create graphs ----------------------------------------------------------------

# Set parameters
  setwd(wd)
  png(file = "plot4.png")
  par(mfrow=c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

# Create line graph of Global Active Power over time
  plot(cons_set$Date_Time, cons_set$Global_active_power, type = "l",
     xlab = NA, ylab = "Global Active Power (kilowatts)")

# Create line graph of voltage
  plot(cons_set$Date_Time, cons_set$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")

# Line graph of energy sub metering 1, 2, and 3
  plot(cons_set$Date_Time, cons_set$Sub_metering_1, type = "l",
     xlab = NA, ylab = "Energy sub metering", col = "black")
  lines(cons_set$Date_Time, cons_set$Sub_metering_2, type = "l", 
      col = "red")
  lines(cons_set$Date_Time, cons_set$Sub_metering_3, type = "l", 
      col = "blue")
  legend("topright", lty = 1, col=c("black", "red","blue"),
       legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"))
  
# Create line graph of voltage
  plot(cons_set$Date_Time, cons_set$Global_reactive_power, type = "l",
       xlab = "datetime", ylab = "Global reactive power")  

# Add title  
  mtext("Plot 4", outer = TRUE)

# Turn png device off
  dev.off()
