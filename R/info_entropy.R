# info_entropy.r
# Ken McGarry 18/12/13

library(entropy)

x1 = runif(1000)
hist(x1,xlim=c(0,1),freq=FALSE)

# make 10 discrete categories
y1 = discretize(x1, numBins=10,r =c(0,1))
y1




