# PCR-Results

This R script processes COVID-19 PCR test results from one or more CSV files. It calculates positive/negative outcomes based on a Ct threshold, summarizes the results, displays tables and plots, and optionally allows saving the results to a CSV file.

---

## Features

- Supports single or multiple CSV files in one run.
- Computes Positive/Negative results using a Ct threshold (default: 35).
- Displays a per-patient results table and saves the results to a CSV file.
- Generates summary statistics of Positive/Negative samples.
- Plots a bar chart of the result distribution.
- Plots a time-series chart showing daily Positive/Negative counts.
- Saves the processed results to a CSV file

---

## Project Structure

- .gitignore
- LICENSE
- -README.md
- - covid_pcr_analysis.R
- files
  - input_file
    - pcr_results.csv
  - input_multiple_files
    - pcr_results_1.csv
    - pcr_results_2.csv
    - pcr_results_3.csv
    - results
      - pcr_results_with_outcome

---

##  How It Works

The user inputs the CSV file(s) to process. Multiple files can be entered, separated by commas.
The script reads and merges the files into a single dataset.
- It calculates the result for each sample based on the Ct value:
  - Positive if Ct < 35
  - Negative otherwise
- Displays a formatted per-patient table in the console.
  - Asks the user whether to save the results as a CSV file.
- Computes summary statistics and prints them in a clean table.
- Generates two plots:
  - Bar chart of Positive vs Negative counts
  - Time-series chart of Positive/Negative counts over sample dates

---

## Example Usage

- Run the script in R: source("pcr_analysis.R")
- Enter one or multiple CSV filenames when prompted:
Enter the CSV file(s) to process (comma-separated if multiple): pcr_results_1.csv, pcr_results_2.csv, pcr_results_3.csv
- View the per-patient table 

PCR Test Results per Patient:
Patient_Name    Sample_ID  Result    
Patient_001       S001            Positive  
Patient_002       S002            Positive  
Patient_003       S003            Negative 

- Decide whether to save the results when prompted:
Do you want to save the results to a CSV file? (y/n): y
"Results saved as: pcr_results_with_outcome.csv

- View the summary statistics in the console.

Summary statistics:
Result     Count      Percent  
Negative    32        21.3%     
Positive   118        78.7%

- The script will generate two plots: bar chart and time-series chart.

---

## Input Files
Each CSV file should have the following columns:
- Sample_ID
- Patient_Name
- Ct_value
- Date

There are already some CSV files, ready to use
pcr_results_2.csv
pcr_results_2.csv
pcr_results_3.csv
pcr_results.csv

Example of CSV file contents:

Sample_ID     Patient_Name     Ct_value       Date
S001               Patient_001         29.53            2023-01-21
S002               Patient_002        19.87             2023-01-19
S003               Patient_003        39.13             2023-01-16

---

## Installation
Download the zip file and unzip it.
Open R and set your working directory to the folder containing the script and CSV files.
Install the required packages if not already installed.

---

## Requirements
- R (tested on R ≥ 4.3)
- Packages: dplyr, ggplot2, readr
- helpful commands:
Install packages if needed:
install.packages(c("dplyr", "ggplot2", "readr"))

---

## Compilation
No compilation needed.

---

## Execution
Open R (or RStudio).
Source the script:
source("pcr_analysis.R")
Follow the interactive prompts for file input and saving results.

---

## Notes

- Ensure CSV filenames are correct and the files exist in your working directory.
- The script merges multiple CSVs automatically into a single dataset.
- Dates must be in the format YYYY-MM-DD for the time-series chart to work correctly.
- Results are displayed in the console and optionally saved to pcr_results_with_outcome.csv.
- Plots are generated using ggplot2 and will appear in the R plotting window.

---

## License

This project is licensed under the MIT License.
