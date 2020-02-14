NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

head(NEI)

library(dplyr)


#SCC with coal values
coal  <- SCC[grep("coal", SCC$Short.Name),"SCC"]

# summing emission data per year
total_emission_coal<-NEI %>%
  filter(SCC %in% coal) %>%
  group_by(year) %>%
  summarise(summen=sum(Emissions)) %>%
  as.data.frame()

#plotting
png("plot4.png")
barplot(total_emission_coal$summen, names.arg=total_emission_coal$year,
        xlab = "Year", ylab = "Total Emissions", 
        main = "Total Coal Emissions by year")
dev.off()
