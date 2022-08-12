#' Fetch data function
#'
#' @export model_RMSE csv, file includes exper_n, exper_id, model_type & rmse

fetch <- function(){
  
  # Check for existence of out subfolder
  dir.exists("1_fetch/out")
  
  # Get the data from ScienceBase
  item_file_download('5d925066e4b0c4f70d0d0599', names = 'me_RMSE.csv', 
                     destinations = '1_fetch/out/model_RMSEs.csv', overwrite_file = TRUE)
  
}

# run fetch function
fetch()