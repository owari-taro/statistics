
n=100000

x<-rnorm(n)
y<-rnorm(n)
result<-c()
for (i in 1:n)
{
	result<-c(result,min(x[i],y[i]))
}


hist(result)

result_square=result**2
cat("mean",mean(result_square))
cat("var",var(result_square))



#########################################
N<-1000
result<-c()


for (i in 1:N){
	
}


print(mean(result))
print(sd(result))

simu <- function(n,N) {
	summary<-c()
	for (i in 1:N){
		x<-rnorm(n,mea=3,sd=3)
		coef<-c(1:n)
		total<-(2/(n*(n+1)))*sum(x*coef)
		result<-c(result,total)
	}	
	paste(result)
	return (c(mean(result),sd(result)))
}







 mydouble <- function(x) {
   return( c(x))              # ã‚Æ“¯‚¶ŠÖ”’è‹`
 }