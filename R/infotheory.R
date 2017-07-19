# infotheory.R
# Using information theoretic measures in combination with Bradford-Hill criteria to 
# assess biological plausibility.
# Ken McGarry, July 2017

library(infotheo)
#library(entropy)      # discretize() is over written by entropy packages
#library(Information)  # weight of evidence (WOE) and information value (IV)

library(dplyr)
library(tidyr)
library(xtable)
library(ggplot2)

library(clusterProfiler)
library(ClustOfVar)
library(ReactomePA)
library(igraph)
library(linkcomm) 


# load in clustering datasets
data(USArrests)
head(USArrests)
nbins<- sqrt(NROW(USArrests))
dat <- infotheo::discretize(USArrests,"equalwidth", nbins) # use full package extension

# mutinformation() computes the mutual information I(X;Y) in nats.
IXY <- mutinformation(dat,method= "emp")
IXY2<- mutinformation(dat[,1],dat[,2])

# computes entropy (High entropy = high uncertainty; low entropy = low uncertainty )
H <- entropy(discretize(USArrests),method="shrink")

# condentropy() returns the conditional entropy, H(X|Y), of X given Y in nats. 
HXY <- condentropy(dat[,1], dat[,2], method = "mm")

# interinformation() returns the interaction information (also called synergy or complementarity), 
# in nats, among the random variables (columns of the data.frame).
ii <- interinformation(dat, method = "sg")

# WOE describes the relationship between a predictive variable and a binary target variable.
# IV measures the strength of that relationship.



## EXAMPLE FROM VIGNETTE ##-------------------------
g <- swiss[,3:4]
lc <- getLinkCommunities(g)

## Plot a graph layout of the link communities.
plot(lc, type = "graph")

## Use a Spencer circle layout.
plot(lc, type = "graph", layout = "spencer.circle")

## Calculate a community-based measure of node centrality.
getCommunityCentrality(lc)

## Find nested communities.
getAllNestedComm(lc)

## Uncover the relatedness between communities.
getClusterRelatedness(lc)





