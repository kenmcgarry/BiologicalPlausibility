# mainfile.R
# July 2017

library(infotheo)
#library(entropy)      # discretize() is over written by entropy packages - see warning.
#library(Information)  # weight of evidence (WOE) and information value (IV)

library(dplyr)
library(tidyr)
library(xtable)
library(ggplot2)

library(clusterProfiler)
library(ClustOfVar)
library(ReactomePA)
library(igraph)
library(minet)
library(linkcomm) 

# load in gene data via the packages
library(care)
#library(GeneCycle)
library(qvalue)
library(GeneNet)

setwd("C:/R-files/informationtheory")    # point to where my code lives
source("somefunctions.R") 

# Lu et al. (2004) brain aging gene expression data: see lu2004 data.
#data("lu2004")
#dim(lu2004$x)

# http://www.pnas.org/content/98/20/11462.abstract
# West et al. (2001) breast cancer data: westdataclean.rda.gz.
load("C:\\R-files\\dataCANCER\\westdataclean.rda")

# http://www.nejm.org/doi/full/10.1056/NEJM200102223440801
# Hedenfalk et al. (2001) breast cancer data: hedenfalk.rda.gz.
load("C:\\R-files\\dataCANCER\\hedenfalk.rda")

# http://www.molbiolcell.org/content/13/6/1977.abstract
# Whitfield et al. (2002) human HeLa cell-cycle data: humanhela.rda.gz.
load("C:\\R-files\\dataCANCER\\humanhela.rda")

# https://www.ncbi.nlm.nih.gov/pmc/articles/PMC523333/
# Smith et al. (2004) A. thaliana time series expression of  800 genes during diurnal cycle.  
#data("arth800")  # derived from GeneNet package
#summary(arth800.expr)

#-------------------------------------------------------------------------------------------
# build network on West data
library("graph")  # creates graphNEL objects
library("Rgraphviz")

# Compute Partial Correlations and Select Relevant Edges
pcor.dyn <- ggm.estimate.pcor(west.mat.clean, method = "dynamic")
west.edges <- network.test.edges(pcor.dyn,direct=TRUE)
#dim(arth.edges)

# We use the strongest 250 edges:
west.net <- extract.network(west.edges, method.ggm="number", cutoff.ggm=250)
node.labels <- as.character(1:length(symbol.name.clean)) # use numbers rather than plot gene lengthy names 
gr <- network.make.graph(west.net, node.labels, drop.singles=TRUE) 
plot_west(gr)

gr2 <- igraph.from.graphNEL(gr) # convert from graphNEL to igraph object
el_west <- get.edgelist(gr2, names=TRUE) # get edgelist
west_single <- getLinkCommunities(el_west, hcmethod = "single")  # edgelist required for linkcomm
west_comp <- getLinkCommunities(el_west, hcmethod = "complete")  # edgelist required for linkcomm
west_ave <- getLinkCommunities(el_west, hcmethod = "average")  # edgelist required for linkcomm
west_ward <- getLinkCommunities(el_west, hcmethod = "ward.D2")  # edgelist required for linkcomm
west_cent <- getLinkCommunities(el_west, hcmethod = "centroid")  # edgelist required for linkcomm

plot(west_ward, type = "graph", layout = "spencer.circle")

# Calculate mutual information from link communities
commun <- west_single$pdens
nbins<- sqrt(NROW(commun))
dat <- infotheo::discretize(commun,"equalwidth", nbins) # use full package extension
IXY <- mutinformation(dat,method= "emp")
IXY2 <- mutinformation(dat[,1],dat[,2])
H <- entropy(infotheo::discretize(commun),method="shrink")
 


#-------------------------------------------------------------------------------------------
# build network on Hedenfalk data
load("C:\\R-files\\dataCANCER\\hedenfalk.rda")


library(BoolNet)
data(cellcycle)
plotNetworkWiring(cellcycle)
# get attractors
attractors <- getAttractors(cellcycle)
# calculate number of different attractor lengths,
# and plot attractors side by side in "table" mode
par(mfrow=c(1, length(table(sapply(attractors$attractors, 
                                    function(attractor){length(attractor$involvedStates)})))))
plotAttractors(attractors)
# plot attractors in "graph" mode
par(mfrow=c(1, length(attractors$attractors)))
plotAttractors(attractors, mode="graph")
# identify asynchronous attractors
attractors <- getAttractors(cellcycle, type="asynchronous")
# plot attractors in "graph" mode
par(mfrow=c(1, length(attractors$attractors)))
plotAttractors(attractors, mode="graph")





