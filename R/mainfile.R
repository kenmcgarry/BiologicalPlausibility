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

# load in protein data
library(care)
library("GeneCycle")
library("qvalue")

# Lu et al. (2004) brain aging gene expression data: see lu2004 data.
data("lu2004")
dim(lu2004$x)

# http://www.pnas.org/content/98/20/11462.abstract]
# West et al. (2001) breast cancer data: westdataclean.rda.gz.

# http://www.nejm.org/doi/full/10.1056/NEJM200102223440801
# Hedenfalk et al. (2001) breast cancer data: hedenfalk.rda.gz.

# http://www.molbiolcell.org/content/13/6/1977.abstract
# Whitfield et al. (2002) human HeLa cell-cycle data: humanhela.rda.gz.
load("C:\\R-files\\dataCANCER\\humanhela.rda")

dim(score1)      # 12 x 14728
dim(score2)      # 26 x 15472
dim(score3)      # 48 x 39724
dim(score4)      # 19 x 39192
dim(score5)      #  9 x 34890









