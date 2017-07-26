# community.R
# linkcomm for module detection
library(linkcomm)

el_thali <- get.edgelist(gr2, names=TRUE)
c1 <- getLinkCommunities(el_thali, hcmethod = "single")

data(hedenfalk)
stat <- hedenfalk$stat
stat0 <- hedenfalk$stat0 #vector from null distribution

p.pooled <- empPvals(stat=stat, stat0=stat0)
p.testspecific <- empPvals(stat=stat, stat0=stat0, pool=FALSE)

#compare pooled to test-specific p-values
qqplot(p.pooled, p.testspecific); abline(0,1)

# calculate q-values and view results
qobj <- qvalue(p.pooled)
summary(qobj)
hist(qobj)
plot(qobj)



