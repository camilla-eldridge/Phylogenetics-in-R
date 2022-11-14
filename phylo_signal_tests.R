library(phylosignal)
library(adephylo)
library(ape)
library(phylobase)


# http://www.francoiskeck.fr/phylosignal/demo_general.html
data(carni19)
tre <- read.tree(text=carni19$tre)
hist(tre$edge.length)

dat <- list()
dat$mass <- carni19$bm
dat$random <- rnorm(19, sd = 10)
dat$bm <- rTraitCont(tre)
dat <- as.data.frame(dat)

# combine traits with tree to make phylo4D object
p4d <- phylo4d(tre, dat)
barplot.phylo4d(p4d, tree.type = "phylo", tree.ladderize = TRUE)
phyloSignal(p4d = p4d, method = "all")
phylosim <- phyloSim(tree = tre, method = "all", nsim = 100, reps = 99)

# Assessing the behavior of these methods with this phylogeny along a Brownian-Motion influence gradient
plot(phylosim, stacked.methods = FALSE, quantiles = c(0.05, 0.95))
plot.phylosim(phylosim, what = "pval", stacked.methods = TRUE)

# Assessing the signal depth with correlograms
mass.crlg <- phyloCorrelogram(p4d, trait = "mass")
random.crlg <- phyloCorrelogram(p4d, trait = "random")
bm.crlg <- phyloCorrelogram(p4d, trait = "bm")

plot(mass.crlg)
plot(random.crlg)
plot(bm.crlg)

# Locating the signal with LIPA
carni.lipa <- lipaMoran(p4d)
carni.lipa.p4d <- lipaMoran(p4d, as.p4d = TRUE)

barplot.phylo4d(p4d, bar.col=(carni.lipa$p.value < 0.05) + 1, center = FALSE , scale = FALSE)
barplot.phylo4d(carni.lipa.p4d, bar.col = (carni.lipa$p.value < 0.05) + 1, center = FALSE, scale = FALSE)



