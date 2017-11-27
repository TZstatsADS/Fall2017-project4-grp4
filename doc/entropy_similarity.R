train2 = read.csv('train2.csv')
train1 <- read.csv("MS_train2.csv")
entropy1<- read.csv("entropy1.csv")
entropy2<- read.csv("entropy.csv")
entropy1<-entropy1[,-1]
entropy2<-entropy2[,-1]
rownames(entropy1)<-train1[,2] 
colnames(entropy1)<-train1[,2]
rownames(entropy2)<-train2[,1] 
colnames(entropy2)<-train2[,1]

###Dataset 1
new.entropy1<-1-entropy1
write.csv(new.entropy1,"entropy_data1.csv")
###Dataset 2
df<-entropy2
df[df==999]<--999
m<-max(df)
#min=0,max=3.442524
#MAX-MIN normalization:
new.entropy2<-(m-entropy2)/(m-0)
new.entropy2[new.entropy2<0]<-0
write.csv(new.entropy2,"entropy_data2.csv")


