# plotfigures.R
# plots the figures in the paper.
library(igraph)

# Example nets used in main system diagram.
nodes <- read.csv("Dataset1-Media-Example-NODES.csv", header=TRUE, as.is=TRUE)
links <- read.csv("Dataset1-Media-Example-EDGES.csv", header=TRUE, as.is=TRUE)
fig1net <- graph_from_data_frame(d=links, vertices=nodes, directed=FALSE) 
fig1net <- simplify(fig1net)
# Example fake nets used in main system diagram
colrs <- c("gray50", "tomato", "gold")
V(fig1net)$color <- colrs[V(fig1net)$media.type]

# Set node size 
V(fig1net)$size <- V(fig1net)$audience.size*0.7

# The labels are currently node IDs.
# Setting them to NA will render no labels:
V(fig1net)$label.color <- "black"
V(fig1net)$label <- NA

# Set edge width based on weight:
E(fig1net)$width <- E(fig1net)$weight/6
#change edge color
E(fig1net)$edge.color <- "gray80"

colrs <- c("blue", "green", "pink")
V(fig1net)$color <- colrs[V(fig1net)$media.type]
plot(fig1net) 

colrs <- c("orange", "pink", "tomato")
V(fig1net)$color <- colrs[V(fig1net)$media.type]
plot(fig1net) 



