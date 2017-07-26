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

# Smith et al. (2004) A. thaliana time series data:
#  the  temporal  expression  of  800  genes  of A.thaliana during  the  diurnal cycle.  
data("arth800")  # from GeneNet package
summary(arth800.expr)








