library(ggplot2)
data(diamonds)
head(diamonds)
#3 vector
class(diamonds)
hist(diamonds$carat,main="carat histogram",xlab="carat")

plot(price~carat,data=diamonds)
#create exactly same graph
plot(diamonds$carat,diamonds$price)

#
ggplot(data=diamonds)+geom_histogram(aes(x=carat))

ggplot(data=diamonds)+geom_density(aes(x=carat),fill="grey50")


##
ggplot(diamonds,aes(x=carat,y=price))+geom_point()
ggplot(diamonds)+geom_point(aes(x=carat,y=price))

g<-ggplot(diamonds,aes(x=carat,y=price))
g+geom_point(aes(color=color))


#
g+geom_point(aes(color=color))+facet_wrap(~color)



ggplot(diamonds,aes(x=carat))+geom_histogram()+facet_wrap(~color)



ggplot(diamonds,aes(x=carat))+geom_histogram()


###box plot,boxplot only require y 
ggplot(diamonds,aes(y=carat,x=1.0))+geom_boxplot()


ggplot(diamonds,aes(y=carat,x=cut))+geom_boxplot()

ggplot(diamonds,aes(y=carat,x=cut))+geom_violin()

ggplot(economics,aes(x=date,y=pop))+geom_line()


library(lubridate)
economics$year<-year(economics$date)
#True month as a character
economics$month<-month(economics$date,label=TRUE)
econ2000<-economics[which(economics$year>=2000),]

library(scales)

g<-ggplot(econ2000,aes(x=month,y=pop))
g+geom_line(aes(color=factor(year),group=year))
