library (dplyr)
library(car)
library(ggplot2)
setwd("~/Desktop/MIS7700 Group 4 Project")
data = read.csv("MIS7700 PopUp Cleaned Dataset.csv", head = TRUE, sep = ",")

###Creating subset with the 3 required regions 
regions_data = subset(data, region %in% c("Asia-Pacific", "Europe", "North America"))
regions_data$region = as.factor(regions_data$region)
table(regions_data$region)

###Shapiro test on the regions sample average daily footfall variable 
shapiro.test(regions_data$avg_daily_footfall)

###Transforming average daily footfall variable with log 
data[,'avg_daily_footfall_log'] = NA
for(i in 1:nrow(data))
{
  data$avg_daily_footfall_log[i] = log(data$avg_daily_footfall[i])
}

###Shapiro test on the regions sample transformed average daily footfall variable 
regions_data2 = subset(data, region %in% c("Asia-Pacific", "Europe", "North America"))
shapiro.test(regions_data2$avg_daily_footfall_log)

###Levene's test on regions sample untransformed average daily footfall variable 
leveneTest(avg_daily_footfall~region, data = regions_data)

###Kruskal Wallis rank sum test on regions sample untransformed average daily footfall variable 
kruskal.test(avg_daily_footfall~region, data = regions_data)

###Boxplot visualization of regions sample untransformed average daily footfall variable 
ggplot(regions_data, aes(x = region, y = avg_daily_footfall, fill = region)) +
  geom_boxplot() +
  labs(title = "Average Daily Footfall Across Regions",
       x = "Region",
       y = "Average Daily Footfall") +
  theme_minimal() +
  theme(legend.position = "none")


