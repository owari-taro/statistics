##tmp_codes

library(ggplot2)
library(urca)
data<-read.csv("csvs/BREAK.csv",header=T)
head(data,n=2)

ggplot(data,aes(x=X,y=y1))+geom_line()

res<-ur.df((data$y1),"drift", lags=1, "Fixed")
summary(res)

###############################
ggplot(data,aes(x=x,y=y2))+geom_line()
ts.plot(diff(data$y2))
res<-ur.df(data$y2,"drift",lags=1,"Fixed")
summary(res)