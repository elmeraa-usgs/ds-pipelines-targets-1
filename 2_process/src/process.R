#' Prepare the data for plotting
#' @ param file_in, specifying file path for input 
#' @ param file out, specifying file path for output
#' @param col vector, three colors associated with each model type: pb, dl, & pgdl
#' @param pch vector, three values associated with each model: pb, dl, & pgdl
#' @export model_summary_results csv, file includes exper_n, exper_id, model_type, rmse, col, pch, and n_proof 

process <- function(file_in, file_out, col, pch){
  
  # Check for existence of out subfolder; returns false if directory already exists and true if it did not but was successfully created 
  ifelse(!dir.exists(file.path(file_out)), dir.create(file.path(file_out)), FALSE)
  
  # prepare data to visualize
  eval_data <- read_csv(file_in, col_types = 'iccd') %>%
    filter(str_detect(exper_id, 'similar_[0-9]+')) %>%
    mutate(col = case_when(
      model_type == 'pb' ~ col[1],
      model_type == 'dl' ~ col[2],
      model_type == 'pgdl' ~ col[3]
    ), pch = case_when(
      model_type == 'pb' ~ pch[1],
      model_type == 'dl' ~ pch[2],
      model_type == 'pgdl' ~ pch[3]
    ), n_prof = as.numeric(str_extract(exper_id, '[0-9]+')))
  
  # export eval data
  write_csv(eval_data, file = file_out)
}
