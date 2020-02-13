
n=100000

x<-rnorm(n)
y<-rnorm(n)
result<-c()
for (i in 1:n)
{
	result<-c(result,min(x[i],y[i]))
}


hist(result)