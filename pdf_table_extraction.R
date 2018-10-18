#Reference: https://datascienceplus.com/extracting-tables-from-pdfs-in-r-using-the-tabulizer-package/
library(tabulizer)
library(dplyr)
library(tidyverse)
# Location of WARN notice pdf file
location <- 'C:/Users/uuunm/Downloads/Atlas-8e-regional-fact-sheet-1899-EUR.pdf'
# Extract the table
europe_table <- extract_tables(location)
#europe_table
europe_df <- as.data.frame(europe_table, header=T)
#europe_df
header_true <- function(df) {
  names(df) <- as.character(unlist(df[1,]))
  df[-1,]
}
final_europe_df <- header_true(europe_df)
#final_europe_df

columns_wanted <- c("Country/territory", 
                    "Adult\rpopulation\r(18-99 years)", 
                    "Diabetes\rcases (18-99\ryears)",
                    "Diabetes\r(18-99)\rnational\rprevalence\r(%)",
                    "Diabetes\rage-adjusted\r(18-99)\rcomparative\rprevalence (%)",
                    "Diabetes\rrelated\rdeath\r(18-99\ryears)",
                    "Cost per\rperson\rwith\rdiabetes\r(USD)",
                    "Undiagnosed\rdiabetes cases\r(18-99 years)",
                    "One in X\radults has\rdiabetes")
final_europe_df <- final_europe_df[columns_wanted]
colnames(final_europe_df) <- c("COUNTRY", 
                           "POPULATION", 
                           "CASES",
                           "PREVALENCE",
                           "AGE_ADJUSTED_PREVALENCE",
                           "DEATHS",
                           "COST_PER_PERSON",
                           "UNDIAGNOSED_CASES",
                           "ONE_IN_X_HAS_DIABETES")
rownames(final_europe_df) <- 1:nrow(final_europe_df)
final_europe_df %>% head()
#saving to csv
write.csv(final_europe_df, file = "C:/Users/uuunm/Downloads/Europe.csv", row.names = FALSE)
