# Input the data from our SQL query
converted_ad <- 14423
total_ad <- 564577

converted_psa <- 420
total_psa <- 23524

# Run the Two-Proportion Z-Test
# Testing if the ad group is greater than the psa group (alternative = "greater")
test_result <- prop.test(
  x = c(converted_ad, converted_psa), 
  n = c(total_ad, total_psa), 
  alternative = "greater",
  correct = FALSE
)

# results
print(test_result)

# Calculate the confidence interval for the lift
lift <- (converted_ad/total_ad) - (converted_psa/total_psa)
print(paste("Absolute Lift:", round(lift * 100, 2), "%"))

