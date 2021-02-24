### k-means assignment Nathan Mahler INFO 4130
install.packages("cluster")
library(cluster)
head(ruspini)
tail(ruspini)
plot(ruspini)
kmeans(ruspini,3,nstart = 25)
km4 <- kmeans(ruspini,4,nstart = 25)
#natural clusters with heuristic elbow plot
