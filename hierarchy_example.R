### Hierarchical clustering
set.seed(1234)
par(mar=c(0,0,0,0))
x <- rnorm(12,mean = rep(1:3,each = 4),sd = 0.2)
y <- rnorm(12,mean = rep(c(1,2,1), each = 4),sd = 0.2)
plot(x,y,col = "blue", pch = 19, cex = 2)
text(x+0.05,y+0.05,label = as.character(1:12))

## calculate the distance
dataFrame <- data.frame(x=x,y=y)
dist(dataFrame) ### default is euclidean 

## clustering
distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering)

## mypclust
source("http://rafalab.jhsph.edu/batch/myplclust.R")
myplclust(hClustering,lab=rep(1:3,each=4),lab.col=rep(1:3,each=4))

## Merge the points
## complete linkage
## average linkage

## heatmap
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
heatmap(dataMatrix)

## K-means
kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)
kmeansObj$cluster
# plot K-means
par(mar=rep(0.2,4))
plot(x,y, col=kmeansObj$cluster,pch = 19, cex= 2)
points(kmeansObj$centers,col=1:3,pch=3,cex=3,lwd=3)

# heatmap
set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
kmeansObj2 <- kmeans(dataMatrix,centers = 3)
par(mfrow = c(1,2),mar = c(2,4,0.1,0.1))
image(t(dataMatrix)[,nrow(dataMatrix):1],yaxt = "n")
image(t(dataMatrix)[, order(kmeansObj$cluster)],yaxt = "n")
