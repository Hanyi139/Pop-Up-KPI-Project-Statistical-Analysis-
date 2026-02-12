###Shapiro test
install.packages("dplyr")
install.packages("stats")
library (dplyr)
library(stats)
###To calculate numerical variables skewness & kurtosis
install.packages("moments")
library(moments)

###Shapiro test on Europe sample units sold variable 
setwd("~/Desktop/MIS7700 Group 4 Project")
data = read.csv("MIS7700 PopUp Cleaned Dataset.csv", head = TRUE, sep = ",")
eu_data = subset(data, data$region == "Europe")
nrow(eu_data)
shapiro.test(eu_data$units_sold)

####Transforming units sold variable with log 
data[,'units_sold_log'] = NA
for(i in 1:nrow(data))
{
  data$units_sold_log[i] = log(data$units_sold[i])
}

is.numeric(data$units_sold_log)

###Shapiro test on Europe sample transformed units sold variable 
eu_data2 = subset(data, data$region == "Europe")
shapiro.test(eu_data2$units_sold_log)

###Histogram of original column
hist(eu_data$units_sold,
     breaks = 10,
     main = "Distribution of Units Sold for Europe",
     xlab = "units_sold",
     col = "lightblue",
     border = "white",
     probability = TRUE)
###Add density curve
lines(density(eu_data$units_sold), col = "red", lwd = 2)


###skewness and kurtosis of histogram
skewness(eu_data$units_sold)
kurtosis(eu_data$units_sold)


###Z statistic calculation 
x_bar = mean(eu_data$units_sold)
mu = mean(data$units_sold)
sigma = sd(data$units_sold)
n = nrow(eu_data)
z_stat = (x_bar - mu) / (sigma / sqrt(n))
z_stat

###Calculating the p-value 
p_value = pnorm(z_stat)
p_value
