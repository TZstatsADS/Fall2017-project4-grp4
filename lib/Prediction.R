

# Prediction for data set 1 (Microsoft data)
Rating_Normalization1=function(weight,write.file=T,timer=T,return=F)
{
  start=Sys.time()
  # Prepare Rating Data
  Rating=read.csv('./Data/MS_train2.csv',header=T,check.names=F)
  rownames(Rating)=as.character(Rating[,1])
  User=as.integer(Rating[,1])
  Film=as.integer(colnames(Rating)[-1])
  Users=length(User)
  Films=length(Film)
  Rating=as.matrix(Rating[,-1])
  # Prepare Weight Data
  Weight=read.csv(paste('./Data/Weight/',weight,'.csv',sep=''),header=T)
  Weight[is.na(Weight)]=0
  rownames(Weight)=as.character(Weight[,1])
  Weight=as.matrix(Weight[,-1])
  Prediction=matrix(nrow=Users,ncol=(Films+1))
  colnames(Prediction)=c('User',as.character(Film))
  Prediction[,1]=as.character(User)
  r_bar=apply(Rating,1,sum)/Films
  # Matrix Computation
  Rating_Centered=Rating-r_bar
  Rating_Weighted=Weight%*%Rating_Centered
  Rating_Normalized=Rating_Weighted/apply(Weight,1,sum)
  Rating_Constrained=Rating_Normalized+r_bar
  Rating_Constrained[Rating_Constrained>6]=6
  Rating_Constrained[Rating_Constrained<0]=0
  Prediction[,-1]=Rating_Constrained
  # Modification
  Prediction=as.data.frame(Prediction)
  if(write.file)
    data.table::fwrite(Prediction,file=paste('./Data/Prediction/MS_',weight,'.csv',sep=''))
  stop=Sys.time()
  if(timer)
    print(stop-start)
  if(return)
    return(Prediction)
}


Rating_Normalization1('User_SimRank')
Rating_Normalization1('mse1.sw.wt0.002')
Rating_Normalization1('mse1.wt0.04')
Rating_Normalization1('pearson1.bn50')
Rating_Normalization1('pearson1.bn100')
Rating_Normalization1('entropy1.bn100')




# Prediction for data set 2 (Each movie)
Rating_Normalization2=function(weight,write.file=T,timer=T,return=F)
{
  start=Sys.time()
  # Prepare Rating Data
  Rating=read.csv('./Data/EM_train2.csv',header=T,check.names=F)
  rownames(Rating)=as.character(Rating[,1])
  User=as.integer(Rating[,1])
  Film=as.integer(colnames(Rating)[-1])
  Users=length(User)
  Films=length(Film)
  Rating=as.matrix(Rating[,-1])
  Rating[is.na(Rating)]=0
  # Prepare Weight Data
  Weight=read.csv(paste('./Data/Weight/',weight,'.csv',sep=''),header=T)
  Weight[is.na(Weight)]=0
  rownames(Weight)=as.character(Weight[,1])
  Weight=as.matrix(Weight[,-1])
  Prediction=matrix(nrow=Users,ncol=(Films+1))
  colnames(Prediction)=c('User',as.character(Film))
  Prediction[,1]=as.character(User)
  r_bar=apply(Rating,1,sum)/apply(Rating>0,1,sum)
  # Matrix Computation
  Rating_Centered=Rating-r_bar
  Rating_Weighted=Weight%*%Rating_Centered
  Rating_Normalized=Rating_Weighted/apply(Weight,1,sum)
  Rating_Constrained=Rating_Normalized+r_bar
  # Modification
  Rating_Constrained[Rating_Constrained>6]=6
  Rating_Constrained[Rating_Constrained<0]=0
  Prediction[,-1]=Rating_Constrained
  Prediction=as.data.frame(Prediction)
  if(write.file)
    data.table::fwrite(Prediction,file=paste('./Data/Prediction/EM_',weight,'.csv',sep=''))
  stop=Sys.time()
  if(timer)
    print(stop-start)
  if(return)
    return(Prediction)
}

Rating_Normalization2('entropy2.bn100')






