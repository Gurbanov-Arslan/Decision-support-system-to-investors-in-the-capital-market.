library(tidyverse)
library(plotly)

candle_stick_plot <- function(
  data,
  index = "",
  from = "",
  to = ""
){
  p <- data %>% 
    ggplot() +
    geom_segment(aes(x = date, xend = date, y = open, yend = close, colour = green_red), size = 1) +
    geom_segment(aes(x = date, xend = date, y = low, yend = high, colour = green_red)) +
    theme_minimal()+
    scale_color_manual(values=c("Forest Green","Red"))+
    ggtitle(paste0(index," (",from," - ",to,")"))+
    theme(legend.position ="none",
          axis.title.y = element_blank(),
          axis.title.x=element_blank(),
          axis.text.x = element_text(angle = 45, vjust = 1, hjust=1),
          plot.title= element_text(hjust=0.5))
  return(ggplotly(p))
}

