library(broom)
ibrary(purrr)
library(tidyverse)
data_<-read.csv("csvs/msci_day.csv")
white_noise<-rnorm(nrow(data_),0,1)
data_$wn<-white_noise
head(data_,2)
formulas<-



formulas<-colnames(data_)[2:(ncol(data_)-1)] %>% 
    paste(.,'~wn')  %>% set_names %>%  map(as.formula) %>%  map(lm, data = data_) %>% map(summary)




################




result<-colnames(data_)[2:(ncol(data_)-1)] %>% 
    paste(.,'~wn') %>% 
    map(as.formula) %>% 
    map(lm, data = data_)%>%map(summary)


