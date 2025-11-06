library(dplyr)
library(ggplot2)
library(readr)

repeat {
  file_input <- readline(prompt = "Enter the CSV file(s) to process (comma-separated if multiple): ")

  file_names <- strsplit(file_input, ",")[[1]]
  file_names <- trimws(file_names)

  missing_files <- file_names[!file.exists(file_names)]
  
  if (length(missing_files) == 0) {
    cat("All files found:\n")
    cat(paste(" -", file_names), sep = "\n")
    cat("\n")
    break
  } else {
    cat("The following files were not found:\n")
    cat(paste(" -", missing_files), sep = "\n")
    cat("Please check the file names and try again.\n\n")
  }
}

data_list <- lapply(file_names, read_csv)
data <- bind_rows(data_list)

ct_threshold <- 35

data <- data %>%
  mutate(Result = ifelse(Ct_value < ct_threshold, "Positive", "Negative"))

cat("PCR Test Results per Patient:\n")
cat("--------------------------------------------\n")
cat(sprintf("%-15s %-10s %-10s\n", "Patient_Name", "Sample_ID", "Result"))
cat("--------------------------------------------\n")
invisible(apply(data, 1, function(row) {
  cat(sprintf("%-15s %-10s %-10s\n", row["Patient_Name"], row["Sample_ID"], row["Result"]))
}))
cat("--------------------------------------------\n\n")

save_answer <- readline(prompt = "Do you want to save the results to a CSV file? (y/n): ")

if (tolower(save_answer) == "y") {
  write_csv(data, "pcr_results_with_outcome.csv")
  cat("Results saved as: pcr_results_with_outcome.csv\n\n")
} else {
  cat("Results were not saved.\n\n")
}

summary_stats <- data %>%
  group_by(Result) %>%
  summarise(Count = n(), Percentage = round(100 * n() / nrow(data), 1), .groups = "drop")

cat("Summary statistics:\n")
cat("--------------------------------\n")
cat(sprintf("%-10s %-10s %-10s\n", "Result", "Count", "Percent"))
cat("--------------------------------\n")
invisible(apply(summary_stats, 1, function(row) {
  cat(sprintf("%-10s %-10s %-10s\n", row["Result"], row["Count"], paste0(row["Percentage"], "%")))
}))
cat("--------------------------------\n\n")

ggplot(summary_stats, aes(x = Result, y = Count, fill = Result)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = paste("PCR Test Results -", file_name),
       y = "Number of Samples",
       x = "Result")

data <- data %>%
  mutate(Date = as.Date(Date))  

daily_summary <- data %>%
  group_by(Date, Result) %>%
  summarise(Count = n(), .groups = "drop")

ggplot(daily_summary, aes(x = Date, y = Count, color = Result, group = Result)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  theme_minimal() +
  labs(title = "PCR Results Over Time",
       x = "Date",
       y = "Number of Samples",
       color = "Result") +
  scale_x_date(date_breaks = "1 week", date_labels = "%d-%b") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
