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
# http://www.pnas.org/content/98/20/11462.abstract
# West et al. (2001) breast cancer data: westdataclean.rda.gz.
load("C:\\R-files\\dataCANCER\\westdataclean.rda")
setwd("C:/R-files/informationtheory")    # point to where my code lives
source("somefunctions.R") 

library(linkcomm) 
library(infotheo)
library(GeneNet)
library("graph")  # creates graphNEL objects
library("Rgraphviz")
library(ontologyIndex)
data(go)
library(ontologySimilarity)
data(gene_GO_terms)
data(GO_IC)

# remove entries without a gene name, that is the colnames, there are 70 such entries.
#west.mat.clean <- west.mat.clean[complete.cases(west.mat.clean * 0), , drop=FALSE]
delete.idx <-(colnames(west.mat.clean) =="NA")
delete.idx <- which(is.na(delete.idx))
west.mat.clean <- subset(west.mat.clean,select= -delete.idx)
symbol.name.clean <- symbol.name.clean[-delete.idx]

# remove duplicated column names i.e. genes approx 500 !
west.mat.clean <- west.mat.clean[, !duplicated(colnames(west.mat.clean))]
symbol.name.clean <- unique(symbol.name.clean)

# Compute Partial Correlations and Select Relevant Edges
pcor.dyn <- ggm.estimate.pcor(west.mat.clean, method = "dynamic")
west.edges <- network.test.edges(pcor.dyn,direct=TRUE)
#dim(west.edges)

# We use the strongest 350 edges:
west.net <- extract.network(west.edges, method.ggm="number", cutoff.ggm=350)
node.labels <- symbol.name.clean # 
#node.labels<- as.character(1:length(symbol.name.clean)) # use numbers rather than plot gene lengthy names 
gr <- network.make.graph(west.net,node.labels,drop.singles=TRUE) 
plot_west(gr)


gr2 <- igraph.from.graphNEL(gr) # convert from graphNEL to igraph object
el_west <- get.edgelist(gr2, names=TRUE) # get edgelist
west_single <- getLinkCommunities(el_west, hcmethod = "single")  # edgelist required for linkcomm
west_comp <- getLinkCommunities(el_west, hcmethod = "complete")  # edgelist required for linkcomm
west_ave <- getLinkCommunities(el_west, hcmethod = "average")  # edgelist required for linkcomm
west_ward <- getLinkCommunities(el_west, hcmethod = "ward.D2")  # edgelist required for linkcomm
west_cent <- getLinkCommunities(el_west, hcmethod = "centroid")  # edgelist required for linkcomm

plot(west_single, type = "graph", layout = "spencer.circle")
plot(west_single, type = "graph",layout = "spencer.circle")
plot(west_comp, type = "graph", layout = "spencer.circle")
plot(west_comp, type = "graph",layout = "spencer.circle")

# -----------------------------------------
# https://cran.r-project.org/web/packages/ontologySimilarity/vignettes/ontologySimilarity-GO-example.html
# Use GO and KEGG for enrichment
test <- gene_GO_terms[c("LRBA", "LYST", "NBEA", "NBEAL1", "NBEAL2", "NSMAF", "WDFY3", "WDFY4", "WDR81")]

# some sort of for loop to get all GO terms for each gene in each cluster (community)
GO_cluster <- gene_GO_terms[getNodesIn(west_single, clusterids = 1)]
go$name[GO_cluster$FGF7]




# just some pretty printing of various graphs -------
ef <- graph.feature(west_single, type = "edges", indices = getEdgesIn(west_single, clusterids = 14),features = 5, default = 1)
plot(west_single, type="graph", ewidth = ef)

graph.feature(west_single, indices = getNodesIn(west_single, type = "indices"), features = 20, default = 5)
plot(west_single, type = "members")
graph.feature(west_comp, indices = getNodesIn(west_comp, type = "indices"), features = 20, default = 5)
plot(west_comp, type = "members")

cm <- getCommunityConnectedness(west_single, conn = "modularity")
plot(west_single, type = "commsumm", summary = "modularity")
cm <- getCommunityConnectedness(west_comp, conn = "modularity")
plot(west_comp, type = "commsumm", summary = "modularity")
nf <- graph.feature(west_comp, type = "nodes", indices = which(V(west_comp$igraph)$name == "Valjean"),features = 30, default = 5)
plot(west_comp, type = "graph", vsize = nf, vshape = "circle", shownodesin = 4)

#================================================================
# Calculate mutual information from link communities
commun <- west_single$pdens
nbins<- sqrt(NROW(commun))
dat <- infotheo::discretize(commun,"equalwidth", nbins) # use full package extension
MI <- mutinformation(dat,method= "emp")
MI2 <- mutinformation(dat[,1],dat[,2])
H <- entropy(infotheo::discretize(commun),method="shrink")

# ------ example of GCC ----------
x1 <- c(1, 0, 1, 1, 1, 1, 0)
y1 <- c(0, 1, 1, 1, 1, 1, 0)
MI <- mutinformation(x1,y1) 
GCC <- (1 - exp(-2*MI))^(1/2)  # global correlation coeff

# to calculate the MI. You actually need a separate contingency table for each attribute. 
# For example, this is the table for A1 (from the figure):
# https://www.biostars.org/p/13815/
# McGarry's method of verifying clusters by checking their mutual information against GO terms. 
# A cluster/annotation contingency matrix is produced, indicating that for cluster r and GO term c, 
# each element indicates the number of occurrences of a specific GO term (the column) for the genes 
# in that group. Then, mutual information is calculated.
# The reason that each attribute is considered separately is that a single gene can have multiple 
# attributes (or none), however, this is not all at clear from the figure which implies that each 
# gene has exactly one attribute. Furthermore, the contingency table in this figure is NOT the one 
# you need to calculate the MI. You actually need a separate contingency table for each attribute. 
# For example, this is the table for A1 (from the figure):
#
#   cluster   |  A1 = yes  |  A1 = no
#   ---------------------------------
#   C = 1     |    5       |     1
#   C = 2     |    0       |     7
#   C = 3     |    1       |     6

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





