###Dataset 1
train<-read.csv("MS_train2.csv",header=T)
train<-data.frame(train[,-c(1,2)],row.names = train[,2])
train[is.na(train)]=0   
# in process:
meandiff<-function(x){
  out <- matrix(NA, nrow=nrow(x),ncol=nrow(x),dimnames=list(rownames(x),rownames(x)))
  #out <- as.data.frame(out)
  for (i in 1:nrow(x)){
    for (j in i:nrow(x)){
      out[j,i]<-0
      out[i,j]<-sum((x[i,]-x[j,])^2)/ncol(x)
      out[j,i]=out[i,j]
    }
    if(i %% 100 == 0){
      print(paste("---Finish computing mse for number",i,"users---"))
    }
  }
  
  return(out)
}
mean.square.diff<-meandiff(train)
#convert to similarity scores
mse.similarity<-1-mean.square.diff
#save to file
write.csv(mse.similarity,"mse1.csv")

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
#a^2
a.square<-sqr %*% t(i_matrix)
#b^2
b.square<-i_matrix %*% t(sqr)
#squared difference
se<-a.square+b.square-two.a.b
#denominator(number of common rating)
common.no<-i_matrix %*% t(i_matrix)
#MSE
mse<-se/common.no
mean.square.diff<-as.data.frame(mse)
#MIN-MAX normalization(in process)
mse.similarity2<-(max(mean.square.diff)-mean.square.diff)/(max(mean.square.diff)-min(mean.square.diff))
#deal with NA values
mse.similarity2[is.na(mse.similarity2)]=0
#save to file
write.csv(mse.similarity2,"mse2.csv")

