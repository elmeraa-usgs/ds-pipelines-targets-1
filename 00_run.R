# Load libraries
library(dplyr)
library(readr)
library(stringr)
library(sbtools)
library(whisker)

# Source functions
source("1_fetch/src/fetch.R")
source("2_process/src/process.R")
source("3_visualize/src/visualize.R")
source("3_visualize/src/diagnostics.R")

# Run fetch function
fetch(file_out = '1_fetch/out/model_RMSEs.csv')

# Run process function
process(file_in = '1_fetch/out/model_RMSEs.csv', 
        file_out = '2_process/out/model_summary_results.csv',
        col = c('#1b9e77', '#d95f02', '#7570b3'),
        pch = c(21, 22, 23))

# Run visualize function
visualize(file_in = '2_process/out/model_summary_results.csv',
          file_out = '3_visualize/out/figure_1.png', 
          width = 8, height = 10, res = 200, units = 'in' )

# Run diagnostics function
diagnostics(file_in = '2_process/out/model_summary_results.csv',
            file_out = '3_visualize/out/model_diagnostic_text.txt')

