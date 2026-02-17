library(ggplot2)

install.packages("car")
library(car)
setwd("~/Desktop/Pop Up KPI Project")
data = read.csv("Pop Up Cleaned Dataset.csv", head = TRUE, sep = ",")

###Does average daily footfall predict sell through percentage?
linmod = lm(sell_through_pct~avg_daily_footfall, data = data )
ggplot(data = data, aes(x= avg_daily_footfall, y= sell_through_pct)) +
  geom_point() +
  geom_smooth(method = "lm", se= FALSE)
summary(linmod)

###Does lease length days predict sell through percentage?
linmod2 = lm(sell_through_pct~lease_length_days, data = data )
ggplot(data = data, aes(x= lease_length_days, y=sell_through_pct)) +
  geom_point() +
  geom_smooth(method = "lm", se= FALSE)
summary(linmod2)

###Does price and average daily footfall predict units sold?
multimod = lm(units_sold~price_usd + avg_daily_footfall, data= data)
summary(multimod)

###Calculating multicollinearity 
vif(multimod)

###Does average daily footfall, lease length days, and price predict sell through percentage?
multimod2 = lm(sell_through_pct~avg_daily_footfall + lease_length_days + price_usd, data= data)
summary(multimod2)

###Calculating multicollinearity 
vif(multimod2)

