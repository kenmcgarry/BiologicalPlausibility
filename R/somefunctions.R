# somefunctions.R

# plot_thali() as its says plots the network of A. thaliana time series data.
plot_thali <- function(anet){
  # Set global node and edge attributes:
  globalAttrs = list()
  globalAttrs$edge = list(color = "black", lty = "solid", lwd = 1, arrowsize=1)
  globalAttrs$node = list(fillcolor = gray(.95), shape = "ellipse", fixedsize = FALSE)

  # Set attributes of some particular nodes:
  nodeAttrs = list()
  nodeAttrs$fillcolor = c('570' = "red", "81" = "red") # highlight hub nodes

  # Set edge attributes:
  edi = edge.info(anet) # edge directions and correlations
  edgeAttrs = list()
  edgeAttrs$dir =  edi$dir # set edge directions 
  cutoff = quantile(abs(edi$weight), c(0.2, 0.8)) # thresholds for line width / coloring
  edgeAttrs$lty = ifelse(edi$weight < 0, "dotted", "solid") # negative correlation
  edgeAttrs$color = ifelse( abs(edi$weight <= cutoff[1]), "grey", "black") # lower 20% quantile
  edgeAttrs$lwd = ifelse(abs(edi$weight >= cutoff[2]), 2, 1) # upper 20% quantile

  # fig.width=8, fig.height=7
  plot(anet, attrs = globalAttrs, nodeAttrs = nodeAttrs, edgeAttrs = edgeAttrs, "fdp")

}

find.periodic.genes <- function(dataset)
{
  cat("Computing p-values ...\n")
  pval = fisher.g.test(dataset)
  
  n1 = sum(qvalue(pval, lambda=0)$qvalues < 0.05)
  n2 = sum(qvalue(pval)$qvalues < 0.05)
  
  fdr.out <- fdrtool(pval, statistic="pvalue", plot=FALSE)
  n3 <- sum(fdr.out$qval < 0.05) 
  n4 <- sum(fdr.out$lfdr < 0.2) 
  
  cat("Conservative estimate (Wichert et al.) =", n1, "\n")
  cat("Less conservative estimate =", n2, "\n")
  cat("Semiparametric Fdr < 0.05 (fdrtool) =", n3, "\n")
  cat("Semiparametric fdr < 0.2 (fdrtool) =", n4, "\n")
}
