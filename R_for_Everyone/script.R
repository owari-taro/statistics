test<-c(1,NA,123)
#返り値はtrue,falseのvector
is.na(test)

test<-c(2,12,NA)
mean(test)
#NAを無視して計算
mean(test,na.rm = True)

#nullは存在しない
a<-c(1,NULL,123)


####pipe
library(magrittr)
x<-1:10
mean(x)

x%>%mean


##################################
x<-1:10
y<- -2:7
z<-rep("a,",10)

#specify name for each clumn 
test_data<-data.frame(hoge=x,hogehoge=y,gehogeho=z)
#get colulmn names
names(test_data)
rownames(test_data)
#display  the first 3 rows of dataframes
head(test_data,3)



##################
test_list<-list(x,y,z)
names(test_list)<-c("hoge","geho","hogehoge")
test_list2<-list(hoge=x,geho=y,hogehoge=z)



###############

a<-matrix(c(1:10),nrow=5)
b<-matrix(c(11:20),nrow=5)
#t create transpose of argument matrix
a%*%t(b)