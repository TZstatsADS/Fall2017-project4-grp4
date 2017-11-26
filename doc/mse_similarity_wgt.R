###Dataset 1
train<-read.csv("MS_train2.csv",header=T)
train<-data.frame(train[,-c(1,2)],row.names = train[,2])
train[is.na(train)]=0   
sqrt.dissim<-dist(train,method = "euclidean",diag = T,upper = T)
mse<-(sqrt.dissim^2)/ncol(train)
mmm<-as.data.frame(mse)
mse.similarity1<-1-mmm
mmmm<-as.matrix(mse.similarity1)
write.csv(mmmm,"mse1.csv")

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
#MIN-MAX normalization 
max(mean.square.diff,na.rm = T) #max=25
min(mean.square.diff,na.rm = T) #min=0
mse.similarity2<-(25-mean.square.diff)/25
#deal with NA values
mse.similarity2[is.na(mse.similarity2)]=0
#save to file
write.csv(mse.similarity2,"mse2.csv")


