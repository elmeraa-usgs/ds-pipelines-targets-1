#' Fetch data function
#' @ param file out, specifying file path for output
#' @export model_RMSE csv, file includes exper_n, exper_id, model_type & rmse

fetch <- function(file_out){
  
  # Check for existence of out subfolder; returns false if directory already exists and true if it did not but was successfully created
  lapply(file_out, function(x) if(!dir.exists(x)) dir.create(paste(getwd(),"1_fetch", "out",sep = "/"))) 
  
  
  # Get the data from ScienceBase and export as csv
  item_file_download('5d925066e4b0c4f70d0d0599', 
                     names = 'me_RMSE.csv', 
                     destinations = file_out, 
                    overwrite_file = TRUE)

}



