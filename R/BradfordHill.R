# BradfordHill.R
# July 2017
# Implements aspects of the nine Bradford-Hill criteria for biological plausibility and coherence.

# 1. Strength of the association, the stronger the association the more likely that the association is causal.
# 2. Consistency, if more studies find similar results, the more likely it is that the association is causal.
# 3. Specificity, a specific exposure should exert a specific effect. There are causal associations that are not specific, for example, cigarette smoking,  which are associated with multiple carcino-genic effects.
# 4. Temporality, the causal exposure should precede the caused disease in time.
# 5. Biological gradient or dose response. If is seen then more likely that the association is causal. 
# 6. Plausibility depends on the current knowledge of the etiology of the disease. For instance, is it known that the agent or metabolite reaches the target organ, are studies in animal models positive?
# 7. Coherence, refers to other observed biological ef  logical changes in the target organ.
# 8. Experimental evidence,if the disease rates go down after the causal agent has been eliminated, it is support for a causal association.
# 9. Analogy, if a similar agent exerts similar effects, it is more likely that the association is causal.

 
# a) Non-causality  b) Weak causality  c) Strong causality

# From http://google.github.io/CausalImpact/CausalImpact.html
library(CausalImpact)

set.seed(1)
x1 <- 100 + arima.sim(model = list(ar = 0.999), n = 100)
y <- 1.2 * x1 + rnorm(100)
y[71:100] <- y[71:100] + 10
data <- cbind(y, x1)

matplot(data, type = "l")
# To estimate a causal effect, we begin by specifying which period in the data should be 
# used for training the model (pre-intervention period) and which period for computing a 
# counterfactual prediction (post-intervention period).
pre.period <- c(1, 70)
post.period <- c(71, 100)

# assemble a structural time-series model, perform posterior inference, and compute estimates 
# of the causal effect. The return value is a CausalImpact object.
impact <- CausalImpact(data, pre.period, post.period)

# The first panel shows the data and a counterfactual prediction for the post-treatment period. 
# The second panel shows the difference between observed data and counterfactual predictions. 
# This is the pointwise causal effect, as estimated by the model. The third panel adds up the 
# pointwise contributions from the second panel, resulting in a plot of the cumulative effect 
# of the intervention. Remember, once again, that all of the above inferences depend critically 
# on the assumption that the covariates were not themselves affected by the intervention. 
# The model also assumes that the relationship between covariates and treated time series, as 
# established during the pre-period, remains stable throughout the post-period.
plot(impact)

time.points <- seq.Date(as.Date("2014-01-01"), by = 1, length.out = 100)
data <- zoo(cbind(y, x1), time.points)
head(data)

# specify the pre-period and the post-period in terms of time points rather than indices:
pre.period <- as.Date(c("2014-01-01", "2014-03-11"))
post.period <- as.Date(c("2014-03-12", "2014-04-10"))

impact <- CausalImpact(data, pre.period, post.period)
plot(impact)




