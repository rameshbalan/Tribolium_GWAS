# All the necessary packages
library(adegenet)
library(vcfR)
library(poppr)
library(ape)
library(RColorBrewer)
library(igraph)
library(ggplot2)

# Input file
Ordered_All_Pop_file <- read.vcfR("Ordered_All_Samples.vcf")

# "pop.txt" file has two columns separated by tab. First column is the name of the sample and the second column is the population to which it belongs.
pop.data <- read.table("pop.txt", sep = "\t", header = TRUE)

# Checking if all the samples in the vcf file are presenting the "pop.txt" file
all(colnames(Ordered_All_Pop_file@gt)[-1] == pop.data$sample)

# Coverting into a genlight object which is just a formot that other functions recognize.
All_Pop_gl <- vcfR2genlight(Ordered_All_Pop_file)

# Adding Ploidy
ploidy(All_Pop_gl) <- 2

# Adding Population names
pop(All_Pop_gl) <- pop.data$pop

# Checking if everything looks alright
print(All_Pop_gl)

# #UPGMA Based Distance Tree
# tree <- aboot(All_Pop_gl, tree = "upgma", distance = bitwise.dist, sample = 100, showtree = F, cutoff = 50, quiet = T)
cols <- brewer.pal(n = nPop(All_Pop_gl), name = "Dark2")
# plot.phylo(tree, cex = 0.8, font = 2, adj = 0, tip.color =  cols[pop(All_Pop_gl)])
# nodelabels(tree$node.label, adj = c(1.3, -0.5), frame = "n", cex = 0.8,font = 3, xpd = TRUE)
# legend('topleft', legend = c("01","02","11","12","13","18","20","24"), fill = cols, border = FALSE, bty = "n", cex = 0.6)
# axis(side = 1)
# title(xlab = "Genetic distance (proportion of loci that are different)")
# 
# #Another useful independent analysis to visualize population structure is a minimum spanning network (MSN). MSN clusters multilocus genotypes (MLG) by genetic distances between them
# #MSN Plot
# Pop_dist <- bitwise.dist(All_Pop_gl)
# Pop_msn <- poppr.msn(All_Pop_gl, Pop_dist, showplot = FALSE, include.ties = T)
# node.size <- rep(2, times = nInd(All_Pop_gl))
# names(node.size) <- indNames(All_Pop_gl)
# set.seed(9)
# plot_poppr_msn(All_Pop_gl, Pop_msn , palette = brewer.pal(n = nPop(All_Pop_gl), name = "Dark2"), gadj = 70)

#PCA Analysis
Pop_pca <- glPca(x = All_Pop_gl, nf = 7)
barplot(100*Pop_pca$eig/sum(Pop_pca$eig), col = heat.colors(50), main="PCA Eigenvalues")
title(ylab="Percent of variance\nexplained", line = 2)
title(xlab="Eigenvalues", line = 1)

# PCA Plot
pop.pca.scores <- as.data.frame(Pop_pca$scores)
pop.pca.scores$pop <- pop(All_Pop_gl)
set.seed(9)
p <- ggplot(pop.pca.scores, aes(x=PC1, y=PC2, colour=pop)) 
p <- p + geom_point(size=2)
p <- p + stat_ellipse(level = 0.95, size = 1)
p <- p + scale_color_manual(values = cols) 
p <- p + geom_hline(yintercept = 0) 
p <- p + geom_vline(xintercept = 0) 
p <- p + theme_bw()
p

# DAPC Analysis
pop_dapc <- dapc(All_Pop_gl, n.pca = 4, n.da = 3)
pop.dapc <- dapc(All_Pop_gl, var.contrib = TRUE, scale = FALSE, n.pca = 4, n.da = nPop(All_Pop_gl) - 1)

# A scatter plot
scatter(pop_dapc, col = cols, cex = 2, legend = TRUE, clabel = F, posi.leg = "bottomleft", scree.pca = TRUE,
        posi.pca = "topleft", cleg = 0.75)

# Structure Plot
compoplot(pop_dapc,col = cols, posi = 'top')
