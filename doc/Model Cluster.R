
data<-read.csv('/home/vassily/Desktop/Link to Fall 2017/Applied Data Science/Project 4/movieData.csv',sep=";")
data<-data[ ,!(colnames(data) %in% c("X"))]

#parameters & useful variables
C=5 #number of unobserved class
maxValue <- max(data$rating)
nbMovies <- length(unique(data$movieID))
listUser <- unique(data$userID)
I<-list() #list of films rated by user i >> I[[i]]
for(userID in listUser){
  I[[userID]]<-c(unique(data[data$userID==userID,]$movieID))
}

# EM algorithm:

# step 1: initialization
mu<-rep(1/C, C) #create a vector of 1/C value

iniVector <- rep(1/6, nbMovies*(maxValue+1))
gamma.array <- array(iniVector,dim = c(nbMovies,(maxValue+1),C))

# step 2: Expectation
userID=55
c=1
mu[c]

for(j in I[[i]]){
  
  gamma.array[j, v[i,j], c]
}
gamma.array[]





