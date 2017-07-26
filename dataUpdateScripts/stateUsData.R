#stateData <- full_join(laborForceParticipationRateKY, laborForceSizeKY, by = joinAllDataByThisVariable)
stateData <- full_join(laborForceParticipationRateKY, laborForceSizeKY, by = joinAllDataByThisVariable)
stateData <- full_join(stateData, medianHomeValueKY, by = joinAllDataByThisVariable)
stateData <- full_join(stateData, medianHouseholdWageKY, by = joinAllDataByThisVariable)
stateData <- full_join(stateData, medianMonthlyRentKY, by = joinAllDataByThisVariable)
stateData <- full_join(stateData, populationKY, by = joinAllDataByThisVariable)
stateData <- full_join(stateData, unemploymentRateKY, by = joinAllDataByThisVariable)
stateData <- full_join(stateData, oesStateData, by = joinAllDataByThisVariable)

# US DATA
usData <- full_join(laborForceParticipationRateUS , laborForceSizeUS, by = joinAllDataByThisVariable)
usData <- full_join(usData, medianHomeValueUS, by = joinAllDataByThisVariable)
usData <- full_join(usData, medianHouseholdWageUS, by = joinAllDataByThisVariable)
usData <- full_join(usData, medianMonthlyRentUS, by = joinAllDataByThisVariable)
usData <- full_join(usData, populationUS, by = joinAllDataByThisVariable)
usData <- full_join(usData, unemploymentRateUS, by = joinAllDataByThisVariable)
usData <- full_join(usData, oesNationData, by = joinAllDataByThisVariable)


## MERGE STATE AND US DATA
stateUsData <- rbind(usData, stateData)
stateUsData <- stateUsData %>% mutate(Area = ifelse(area_code == 1, "United States", "Kentucky"))
stateUsData <- stateUsData %>% select(10, 2:9)

stateUsData$`Annual Median Wage (USD)` <- as.numeric(as.character(stateUsData$`Annual Median Wage (USD)`))
# Add Louisville data
louisvilleAllData <- allData %>% filter(MSA == "Louisville") %>% select(2:9)
louisvilleAllData$Area <- "Louisville"

stateUsData <- rbind(stateUsData, louisvilleAllData)
stateUsData$`Median Home Value` <- paste0("$", format(stateUsData$`Median Home Value`, big.mark = ","))
stateUsData$`Median Household Wage` <- paste0("$", format(stateUsData$`Median Household Wage`, big.mark = ","))
stateUsData$`Median Monthly Rent` <- paste0("$", format(stateUsData$`Median Monthly Rent`, big.mark = ","))
stateUsData$`Annual Median Wage (USD)` <- paste0("$", format(stateUsData$`Annual Median Wage (USD)`, big.mark = ","))
