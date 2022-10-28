library(tidyverse)

train_test_split <- function(data, type = "random"){
  data <- data %>% arrange(date)
  df_length <- nrow(data)
  train_size <- trunc(df_length*0.75)
  
  if (type == "random") {
    train_idxs <- sample(1:df_length, train_size)
    train <- data[train_idxs, ]
    test <- data[-train_idxs, ] %>% select(-price)
  } else {
    train <- data[1:train_size, ]
    test <- data[(train_size+1):df_length, ] %>% select(-price)
  }
  
  return(list(train = train, test = test))
}

