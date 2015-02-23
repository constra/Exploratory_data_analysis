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

## PCA and SVD
#matrix data
set.seed(12345)
par(mar = rep(0.2,4))
dataMatrix <- matrix(rnorm(400),nrow = 40)
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1])
par(mar= rep(0.2,4))
heatmap(dataMatrix)

# add some patter
set.seed(678910)
for (i in 1:40){
        coinFlip <- rbinom(1,size=1,prob=0.5)
        if (coinFlip){
                dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,3), each = 5)
        }
}
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1])
heatmap(dataMatrix)

hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order, ]
par(mfrow = c(1, 3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1]) 
plot(rowMeans(dataMatrixOrdered), 40:1, , xlab = "Row Mean", ylab = "Row", pch = 19) 
plot(colMeans(dataMatrixOrdered), xlab = "Column", ylab = "Column Mean", pch = 19)

## SVD
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd1$u[,1],40:1,,xlab="Row",ylab = "First left singular vector",pch=19)
plot(svd1$v[,1],xlab= "Column",ylab="First right singular vector",pch = 19)

## components of the SVD= Variance explained
par(mfrow=c(1,2))
plot(svd1$d,xlab="Column",ylab="Singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab="Column",ylab="Prop. of variance explained",pch=19)

## SVD and PCA