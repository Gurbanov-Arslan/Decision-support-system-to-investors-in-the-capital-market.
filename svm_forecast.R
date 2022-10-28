library(tidyverse)
library(e1071)
set.seed(101)

svm_forecast <- function(
  data,
  svm_type = "eps-regression",
  svm_kernel = "linear",
  svm_cost = 10,
  svm_gamma = 1
){
  features <- generate_date_features(data)
  splitted <- train_test_split(features, type = "random")
  train <- splitted$train
  test <- splitted$test
  
  svmfit = svm(price ~ ., 
               data = train, 
               type = svm_type,
               kernel = svm_kernel,
               cost = svm_cost, 
               gamma = svm_gamma)
  
  df_train_predictions <- train %>%
    select(date, price) %>%
    mutate(Predict = svmfit$fitted)
  graph_train_prediction <- df_train_predictions %>%
    ggplot(aes(date, price)) +
    geom_point(color = "blue") +
    geom_line(color = "blue") +
    geom_point(aes(y = Predict), color = "red") +
    geom_line(aes(y = Predict), color = "red") +
    labs(title = "Stock Prices Predicted vs Real on Train set") +
    theme_minimal()
  return(list(plot = graph_train_prediction))
  
}

