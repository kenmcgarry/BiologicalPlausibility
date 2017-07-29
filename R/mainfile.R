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
library(GeneCycle)
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
c1 <- getLinkCommunities(el_west, hcmethod = "single")  # edgelist required for linkcomm
plot(c1, type = "graph", layout = "spencer.circle")


#-------------------------------------------------------------------------------------------
# build network on Hedenfalk data
load("C:\\R-files\\dataCANCER\\hedenfalk.rda")









