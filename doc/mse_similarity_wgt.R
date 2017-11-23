###Dataset 1
train<-read.csv("MS_train2.csv",header=T)
train<-data.frame(train[,-c(1,2)],row.names = train[,2])
train[is.na(train)]=0
###MSE=(a-b)^2=a^2+b^2-2ab
i_matrix<-!is.na(train)
#2ab
dff<-train
dff[is.na(dff)]=0
two.a.b<-2*as.matrix(dff) %*% t(dff)
sqr<-train^2
sqr[is.na(sqr)]=0
a.square<-sqr %*% t(i_matrix)
b.square<-i_matrix %*% t(sqr)
se<-a.square+b.square-two.a.b
common.no<-i_matrix %*% t(i_matrix)
mse<-se/common.no
mean.square.diff<-as.data.frame(mse)
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


