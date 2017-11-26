###Dataset 1
train<-read.csv("MS_train2.csv",header=T)
train<-data.frame(train[,-c(1,2)],row.names = train[,2])
train[is.na(train)]=0
meandiff<-function(x){
  out <- matrix(NA, nrow=nrow(x),ncol=nrow(x),dimnames=list(rownames(x),rownames(x)))
  #out <- as.data.frame(out)
  for (i in 1:nrow(x)){
    for (j in i:nrow(x)){
      out[j,i]<-0
      out[i,j]<-sum((x[i,]-x[j,])^2)/ncol(x)
      out[j,i]=out[i,j]
    }
  }
  return(out)
}
mean.square.diff<-meandiff(train)
write.csv(mean.square.diff,"mse.csv")

###Dataset 2
train2<-read.csv("train2.csv",header=T)
train2<-data.frame(train2[,-1],row.names = train2[,1])
i_matrix<-!is.na(train2)
#2ab
dff<-train2
dff[is.na(dff)]=0
two.a.b<-2*as.matrix(dff) %*% t(dff)
sqr<-train2^2
sqr[is.na(sqr)]=0
a.square<-sqr %*% t(i_matrix)
b.square<-i_matrix %*% t(sqr)
se<-a.square+b.square-two.a.b
common.no<-i_matrix %*% t(i_matrix)
mse<-se/common.no
mean.square.diff<-as.data.frame(mse)
write.csv(mean.square.diff,"mse2.csv")


