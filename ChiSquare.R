setwd("~/Desktop/Pop Up KPI Project")
data = read.csv("Pop Up Cleaned Dataset.csv", head = TRUE, sep = ",")

###Creating factors for location and event type variables 
data$location_type = as.factor(data$location_type)
data$event_type = as.factor(data$event_type)

###Choosing 3 locations and event type values 
select_locations = c("Airport Duty-Free", "High-Street", "Luxury Mall")
select_events = c("Flash Event", "Mall Kiosk", "Standalone Pop-Up")

###Creating subset of the select locations and events 3x3
location_event_data = subset(
  data,
  location_type %in% select_locations &
    event_type %in% select_events
)

###Dropping unused factor levels
location_event_data = droplevels(location_event_data)

###Creating 3x3 contingency table 
contingency_table = table(location_event_data$location_type,
                         location_event_data$event_type)
print(contingency_table)

###Chi square test
chisq.test(contingency_table)
