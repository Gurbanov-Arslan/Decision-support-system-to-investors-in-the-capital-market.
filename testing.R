source("stock-prediction/get_index.R")
source("stock-prediction/candle_stick_plot.R")
source("stock-prediction/generate_date_features.R")

index <- "AAPL"
from <-  Sys.Date() - 730
to <- Sys.Date()
  
idx <- get_index(index, from, to)
candle_stick_plot(idx, index, from, to)

generate_date_features(idx)
