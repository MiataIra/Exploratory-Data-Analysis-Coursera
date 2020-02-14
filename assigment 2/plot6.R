NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

head(NEI)
library(dplyr)

# summing emission data per year

total_emissions_two_city_on_road<-NEI %>%
  filter(fips %in% c("06037", "24510"), type=="ON-ROAD") %>%
  group_by_at(vars(fips, year)) %>%
  summarise(summen=sum(Emissions)) %>%
  as.data.frame()
total_emissions_two_city_on_road$year<-as.character(total_emissions_two_city_on_road$year)
total_emissions_two_city_on_road$fips<-gsub("24510", "Baltimore", total_emissions_two_city_on_road$fips)
total_emissions_two_city_on_road$fips<-gsub("06037", "Los Angeles", total_emissions_two_city_on_road$fips)

#plotting
png("plot6.png")
ggplot(total_emissions_two_city_on_road, aes(fill=fips, y=summen, x=year) ) + 
  geom_bar(position="dodge", stat="identity") + 
  ylab("Total Emission") + xlab("Year") + 
  ggtitle("Total Emission in Baltimore og Los Angeles on the road per year")

dev.off()
