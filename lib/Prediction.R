
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


names=list.files(path='./Data/Weight')
names=substr(names,start=1,stop=nchar(names)-4)
#names.new=list.files(path='./Data/Prediction')
#names.new=substr(names.new,start=4,stop=nchar(names.new)-4)
#names=setdiff(names,names.new)

reg1='[a-z]{1,7}1\\.'
reg2='[a-z]{1,7}2\\.'
weight1=c(grep(names,pattern=reg1,value=T),grep(names,pattern='simrank',value=T))
weight2=grep(names,pattern=reg2,value=T)

for(i in 1:length(weight1))
  Rating_Normalization1(weight1[i])

for(i in 1:length(weight2))
  Rating_Normalization2(weight2[i])



