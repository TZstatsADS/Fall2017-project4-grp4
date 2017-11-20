library(reshape2)
data2_train<-read.csv("data_train.csv")
data2_test<-read.csv("data_test.csv")
ratings_train <- data2_train[,-1]
train<-acast(ratings_train, User ~ Movie)
train<-as.matrix(train)
train<-as.data.frame(train)
write.csv(train,"train2.csv")

ratings_test <- data2_test[,-1]
test<-acast(ratings_test, User ~ Movie)
test<-as.matrix(test)
test<-as.data.frame(test)
write.csv(test,"test2.csv")
