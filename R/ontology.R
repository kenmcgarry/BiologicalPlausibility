# ontology.R

library(ontologyIndex)
library(ontologyPlot)
library(ontologySimilarity)

# Human Phenotype Ontology (HPO),
data(hpo)

ont_t <- get_term_property(ontology=hpo, property="ancestors", term="HP:0001873", as_names=TRUE)
onto_plot(hpo, terms=get_ancestors(hpo, names(ont_t)))

# computes a mutual information matrix
library(c3net)
data(expdata)
expdata <- copula(expdata)
mim <- makemim(expdata)


