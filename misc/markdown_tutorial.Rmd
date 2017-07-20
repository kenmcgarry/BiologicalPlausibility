---
title: "Using R Markdown and Knitr for Documentation"
author: Ken McGarry
date: "19-07-2017"
output: pdf_document
---
Any text highlighted by a grey background (running the length of the page) is meant to be R code to be typed into the Editor and then sent to the Console. Any text in red (also seen highlighted grey) are comments, these are optional and do not have to be typed in, they always start with a # character. In your RStudio editor they make any text after the # symbol appear green and informs R that these are only comments and not active code.

Anything starting with two ## is the output you should expect to see from the R Console after typing in commands. 

```{r}
   # Required to create this PDF document
library(dplyr)
```

The code below will read in data from Daniel Himmelstein's file, it contains 7759 entries with 8 variables. You will need to change the filepath to where you have saved it on your computer. Its two years old so not a recent image of drugbank but so far the best we can do. https://github.com/dhimmel/drugbank/tree/gh-pages/data


```{r}
DB <- file.path('C://R-files//drugbank//','similardrugs.csv') %>%
  read.delim(na.strings='',sep=',',header=T,comment.char="#",stringsAsFactors = FALSE)

```

## Various bits of R code 
Incredible as it sounds, R can actually can do addition. 
```{r}
4+4  # the [1] refers to the 1st bit of data and the 8 is the result of the maths operation
```

```{r}
# Add two numbers together
add <- function(a, b) a + b
add(10, 20)
```

```{r}
# create some tidy data
names(DB)

# display the first six entries
head(DB)

```

```{r, echo=TRUE,results='hide',fig.keep='all'}
library(linkcomm)

g <- swiss[,3:4]
lc <- getLinkCommunities(g,verbose = FALSE)
```

```{r, echo=TRUE,results='hide',fig.keep='all'}
# Plot a graph layout of the link communities.
plot(lc, type = "graph")
```

```{r, echo=TRUE,results='hide',fig.keep='all'}
# Use a Spencer circle layout.
plot(lc, type = "graph", layout = "spencer.circle")
```

```{r, echo=TRUE,results='hide',fig.keep='all'}
# Calculate a community-based measure of node centrality.
getCommunityCentrality(lc)
```

```{r, echo=TRUE,results='hide',fig.keep='all'}
# Find nested communities.
getAllNestedComm(lc)
```

```{r, echo=TRUE}
## Uncover the relatedness between communities.
getClusterRelatedness(lc,verbose = FALSE)
```



