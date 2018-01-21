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

par(bg=NA)
with(data.df, {
  hist(x = Global_active_power, bg = NA, col = 'red', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')
})

dev.copy(png, file = 'plot1.png')
dev.off()