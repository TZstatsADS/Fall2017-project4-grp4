###Dataset 1
train<-read.csv("MS_train2.csv",header=T)
train<-data.frame(train[,-c(1,2)],row.names = train[,2])
train[is.na(train)]=0
mv_cor<- cor(t(train),use="pairwise.complete.obs",method="pearson")
write.csv(mv_cor,"pearson1.csv")

### Dataset 2
train2<-read.csv("train2.csv",header=T)
train2<-data.frame(train2[,-1],row.names = train2[,1])
mv_cor<- cor(t(train2[,-1]),use="pairwise.complete.obs",method="pearson")
write.csv(mv_cor,"pearson2.csv")
