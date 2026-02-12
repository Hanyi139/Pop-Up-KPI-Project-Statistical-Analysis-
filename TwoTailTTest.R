library(car)
setwd("~/Desktop/MIS7700 Group 4 Project")
data = read.csv("MIS7700 PopUp Cleaned Dataset.csv", head = TRUE, sep = ",")

###Shapiro tests on Latin America and North America samples lease length days variable 
la_data = subset(data, data$region == "Latin America")
na_data = subset(data, data$region == "North America")
shapiro.test(la_data$lease_length_days)
shapiro.test(na_data$lease_length_days)

###Transforming lease length days variable with log 
data[,'lease_length_days_log'] = NA
for(i in 1:nrow(data))
{
  data$lease_length_days_log[i] = log(data$lease_length_days[i])
}

###Shapiro test on each sample's transformed lease length days variable 
la_data2 = subset(data, data$region == "Latin America")
na_data2 = subset(data, data$region == "North America")
shapiro.test(la_data2$lease_length_days_log)
shapiro.test(na_data2$lease_length_days_log)

###Levene's test on the untransformed lease length days variable
americas_data = subset(data, region %in% c("Latin America", "North America"))
americas_data$region = as.factor(americas_data$region)
leveneTest(lease_length_days~region, data = americas_data)

###F test on the untransformed lease length days variable 
var.test(lease_length_days~region, data = americas_data)

###Welch two sample t-test on the untransformed lease length days variable 
t.test(lease_length_days~region, data = americas_data)



