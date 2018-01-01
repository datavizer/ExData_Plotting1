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

  
#  Create histogram of Global Active Power
   setwd("..")
   png(file = "plot1.png")
 
   hist(cons_set$Global_active_power, col = "red", main = "Global Active Power",
       xlab = "Global Active Power (kilowatts)")
   
   dev.off()
