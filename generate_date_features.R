library(lubridate)
library(tidyverse)

generate_date_features <- function(df){
  df_date_features <- df %>%
    mutate(
      Weekday = lubridate::wday(date, week_start = 1),
      Month = month(date),
      MonthDay = day(date),
      Year = year(date),
      Quarter = quarter(date)
      )
  return(df_date_features)
}

