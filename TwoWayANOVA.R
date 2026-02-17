library (dplyr)
library(car)
library(ggplot2)
setwd("~/Desktop/Pop Up KPI Project")
data = read.csv("Pop Up Cleaned Dataset.csv", head = TRUE, sep = ",")

#Identify how the brand names are stored and changing variable name  
unique(data$brand)
data$brand[
  data$brand == "Est\x8ee Lauder"] = "Estée Lauder"

###Filter required regions and brands 
regions_brands_data = data %>%
  filter(region %in% c("Asia-Pacific", "Europe", "North America"),
         brand %in% c("Hourglass", "Estée Lauder", "Tom Ford Beauty"))

is.numeric(regions_brands_data$avg_daily_footfall)

###Remove missing values and define factors 
regions_brands_data2 = regions_brands_data %>%
  select(avg_daily_footfall, region, brand) %>%
  na.omit() %>%
  mutate(
    region = droplevels(as.factor(region)),
    brand = droplevels(as.factor(brand))
    )

###Shapiro test on regions and brands sample average daily footfall variable 
shapiro.test(regions_brands_data2$avg_daily_footfall)

###Shapiro test on regions and brands sample log transformed average daily footfall variable 
regions_brands_data3 =  regions_brands_data %>%
  select(avg_daily_footfall_log, region, brand) %>%
  na.omit() %>%
  mutate(
    region = droplevels(as.factor(region)),
    brand = droplevels(as.factor(brand))
    )
shapiro.test(regions_brands_data3$avg_daily_footfall_log)

###Levene's test on regions and brands sample log transformed average daily footfall variable 
leveneTest(avg_daily_footfall_log~region * brand, data = regions_brands_data3)

###Two way ANOVA on regions and brands sample log transformed average daily footfall variable 
two_way_anova = aov(avg_daily_footfall_log~region * brand, data = regions_brands_data3)
summary(two_way_anova)

###Tukey HSD test 
TukeyHSD(two_way_anova)

###Summary table for reporting insight: mean, sd, n 
summary_table = regions_brands_data2 %>%
  group_by(region, brand) %>%
  summarise(
    mean = mean(avg_daily_footfall),
    sd = sd(avg_daily_footfall),
    n = n(),
    .groups = "drop"
    )
print(summary_table)

###Boxplots of categorical variables 
boxplot(avg_daily_footfall_log~brand, data = regions_brands_data3,
        col = "lightblue",
        main = "Natural Log of Average Daily Footfall by Brand",
        xlab = "Brand", ylab = "Log(Average Daily Footfall)"
        )

boxplot(avg_daily_footfall_log~region, data = regions_brands_data3,
        col = "lightblue",
        main = "Natural Log of Average Daily Footfall by Region",
        xlab = "Region", ylab = "Log(Average Daily Footfall)"
        )

###Interaction plot of region x brand 
interaction.plot(regions_brands_data3$region,
                 regions_brands_data3$brand,
                 regions_brands_data3$avg_daily_footfall_log,
                 col = c("red", "blue", "green"),
                 main = "Interaction Plot of Region x Brand",
                 xlab = "Region", ylab = "Log(Average Daily Footfall)"
                 )
