predicted <- pivot %>%
  select(Year, Age, BON) %>%
  mutate(RelYear = Year-(Age - 2)) %>%
  inner_join(PITratios) %>%
  mutate(forecast = round(BON*Ratio*conversionRate, 0)) %>%
  group_by(Year) %>%
  summarize(forecast = sum(forecast)) %>%
  left_join(RunReconTble) %>%
  mutate('Proportion Of Actual' = round(forecast / Run, 2))

plot(
  predicted$Year, 
  predicted$forecast,
  main = "Comparing PIT Expansion to Actual Run Size",
  ylab = "Num. spring Chinook Salmon",
  xlab = "Year", 
  type = "o", 
  cex.lab = .75,
  cex.axis = .7,
  lty = 2,
  xaxp = c(2006, 2017, 11)
)
lines(
  predicted$Year, 
  predicted$Run,
  type = "o"
)
