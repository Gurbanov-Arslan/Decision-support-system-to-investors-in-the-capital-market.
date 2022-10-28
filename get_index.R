library(quantmod)
library(magrittr)
library(lubridate)
library(dplyr)
library(memoise)

get_index <- memoise(
  function(
    index,
    from,
    to,
    periodicity = "daily"
  ){
    stock <- as.zoo(
      getSymbols(
        index,
        from = from,
        to = to,
        periodicity = periodicity,
        auto.assign = FALSE
      )
    ) %>% data.frame() 
    
    prices <- data.frame(
        date = rownames(stock),
        open = stock[, paste0(index, ".Open")],
        high = stock[, paste0(index, ".High")],
        low = stock[, paste0(index, ".Low")],
        close = stock[, paste0(index, ".Close")],
        volume = stock[, paste0(index, ".Volume")],
        adjusted = stock[, paste0(index, ".Adjusted")]
      ) %>% 
      mutate(
        date = ymd(date),
        price = close,
        green_red = ifelse(open-close > 0, "red", "green"))
    return(prices)
  }
)







