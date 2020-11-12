data = read.csv("BSE_Sensex_Index.csv", header = TRUE)

View(data)
summary(data)
data$Date = as.Date(data$Date, format='%m/%d/%Y')

successive_difference <- function(x) {
  n = length(x)
  for (i in 1:(length(x))) {
    x[i] <- (x[i] - x[i + 1]) / x[i + 1]
  }
  x[length(x)] = (x[length(x) - 1] + x[length(x) - 2] + x[length(x) - 3]) / 3
  return(x)
}

data$successive_growth <- successive_difference(data$Close)


#calc_Z-scores
sgrmean <- mean(data$successive_growth, na.rm=TRUE)
sgrsd <- sd(data$successive_growth,na.rm=TRUE)
z<-(data$successive_growth - sgrmean) / sgrsd
sort(z)
data$zscores <- z

#outliers
dates<-subset(data[,1],data[,"zscores"] >= 3.0 | data[,"zscores"] <= -3.0)
View(dates)

write.csv(dates, "OutliersDatesData_.csv", quote = FALSE, row.names = TRUE)