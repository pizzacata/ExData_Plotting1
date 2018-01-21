data.file <- tempfile()
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', data.file, mode="wb")
data.df <- subset(
  read.table(
    unz(data.file, filename = 'household_power_consumption.txt'),
    header=T,
    na.strings = '?',
    sep=";"),
  Date %in% c('1/2/2007','2/2/2007')
)

data.df$datetime <- strptime(paste(data.df$Date, data.df$Time), format = '%e/%m/%Y %H:%M:%S')

Sys.setlocale("LC_ALL","English")
par(bg=NA, mfcol = c(2,2))
with(data.df, {
  # top left
  plot(x = datetime, y = Global_active_power, type = 'l', ylab = 'Global Active Power', xlab = '')
  # bottom left
  plot(x = datetime, y = Sub_metering_1, type = 'l', ylab = 'Energy sub metering', xlab = '')
  lines(x = datetime, y = Sub_metering_2, col = 'red')
  lines(x = datetime, y = Sub_metering_3, col = 'blue')
  legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty = 1, bty = 'n')
  # top right
  plot(x = datetime, y = Voltage, type = 'l')
  # bottom right
  plot(x = datetime, y = Global_reactive_power, type = 'l')
})

dev.copy(png, file = 'plot4.png')
dev.off()