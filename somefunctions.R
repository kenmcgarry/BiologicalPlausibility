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

