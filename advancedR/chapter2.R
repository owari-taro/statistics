library(lobstr)
#2
obj_addr(mean)
obj_addr(base::mean)
obj_addr(get("mean"))
#TODO:rewrite R markdown
make.names("!_test")

#copy-on-modify
x<-c(3,2,1)
y<-x