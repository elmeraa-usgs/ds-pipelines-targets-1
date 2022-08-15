#' Export model diagnostics
#' @ param file_in, specifying file path for input 
#' @ param file out, specifying file path for output
#' @export model_diagnostics_text txt, file contains mean RSME for three model types as well as a breakdown of training temperature profiles for the different models 

diagnostics <- function(file_in, file_out){
  
  # Check for existence of out subfolder; returns false if directory already exists and true if it did not but was successfully created 
  ifelse(!dir.exists(file.path(file_out)), dir.create(file.path(file_out)), FALSE)
  
  # Read in eval data 
  eval_data <- read_csv(file_in)

  # Create function to compile performance mean details
  render_compile <- function(model, exper){
    filter(eval_data,
           model_type == model, 
           exper_id == exper) %>% 
      pull(rmse) %>% 
      mean %>% 
      round(2)
  }
  
  # Create a list of models
  model_means <- c('pgdl_980mean',
                   'dl_980mean',
                   'pb_980mean',
                   'dl_500mean',
                   'pb_500mean',
                   'dl_100mean',
                   'pb_100mean',
                   'pgdl_2mean',
                   'pb_2mean')
  
  # Use sapply to iterate over the list of models and extract model means 
  render_data <-  sapply(model_means, 
                         function(X) render_compile(sub("_.*", "", X), paste0("similar_", gsub("[^0-9]", "", X))),USE.NAMES = TRUE, simplify = FALSE)
  
  
  template_1 <- 'resulted in mean RMSEs (means calculated as average of RMSEs from the five dataset iterations) of {{pgdl_980mean}}, {{dl_980mean}}, and {{pb_980mean}}°C for the PGDL, DL, and PB models, respectively.
  The relative performance of DL vs PB depended on the amount of training data. The accuracy of Lake Mendota temperature predictions from the DL was better than PB when trained on 500 profiles 
  ({{dl_500mean}} and {{pb_500mean}}°C, respectively) or more, but worse than PB when training was reduced to 100 profiles ({{dl_100mean}} and {{pb_100mean}}°C respectively) or fewer.
  The PGDL prediction accuracy was more robust compared to PB when only two profiles were provided for training ({{pgdl_2mean}} and {{pb_2mean}}°C, respectively). '
  
  # export 
  whisker.render(template_1 %>% str_remove_all('\n') %>% str_replace_all('  ', ' '), render_data ) %>% cat(file = file_out)
  
  
}

