###SETUP###

#clean workspace
rm(list=ls())

#generate some 'random' data
dat <- as.data.frame(cbind(input1=c(rnorm(50),rnorm(50)+1.5),input2=c(rnorm(50),rnorm(50)-0.1),input3=rnorm(100),output=c(rnorm(50),rnorm(50)+1)))


###PREPARATORY EXPLORATION###

#build the linear regression model (interaction) for input 1 and 2
mod <- lm(output~input1*input2,data=dat)

#show the summary
summary(mod)

#extract the coefficients and their significances
summary(mod)$coeff

#extract the 95% confidence interval
confint(mod)

#combine both
cbind(summary(mod)$coeff,confint(mod))


###THE LOOP###

results <- NULL
for(i in 1:(length(colnames(dat))-2)) {
  for(j in (i+1):(length(colnames(dat))-1)) {
    var1 <- colnames(dat)[i]
	var2 <- colnames(dat)[j]
	print(paste(var1,"_x_",var2,sep=""))
	mod <- eval(parse("",-1,paste("lm(output~",var1,"*",var2,",data=dat)",sep="")))
	res <- cbind(summary(mod)$coeff,confint(mod))
	results[[paste(var1,"_x_",var2,sep="")]] <- res
	#rm(var1,var2,mod,res)
  }
}
