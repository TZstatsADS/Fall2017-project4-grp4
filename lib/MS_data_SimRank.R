
#---------------------------------
# preprocess function for the MS_data. The output will be matrix.
MS_data_preprocess=function(filename)
{
  data_source=paste(filename,'.csv',sep='')
  # read in data
  Data=read.csv(data_source)[,2:3]
  # get rows and cols for matrix
  User.row=sum(Data=='C')
  User.col=length(unique(Data[Data=="V",2]))+1
  # empty matrix filled with NA
  User=matrix(0,nrow=User.row,ncol=User.col)
  User[,1]=Data[which(Data[,1]=='C'),2]
  # indices for selection
  Index1=(which(Data[,1]=='C')+1)
  Index2=c((which(Data[,1]=='C')-1)[-1],nrow(Data))
  # colnames
  colnames(User)=c('User',as.character(sort(unique(Data[Data=="V",2]))))
  # change exsiting values to 1
  for(i in 1:User.row)
    User[i,as.character(Data[Index1[i]:Index2[i],2])]=T
  # you can comment either of the lines below
  write(User,file=paste(filename,'.Rdata',sep=''))
  write.csv(User,file=paste(filename,'2.csv',sep=''),row.names=F)
  return(User)
}

MS_train=MS_data_preprocess('MS_train')
#MS_test=MS_data_preprocess('MS_test')

#---------------------------------

# Simrank
SimRank=function(Data=MS_train,C1=0.8,C2=0.8,K=5,write.file="User")
{
  start=Sys.time()
  # Data Processing
  User.col=nrow(Data)
  User_SimRank=diag(User.col)
  colnames(User_SimRank)=Data[,1]
  Film.col=ncol(Data)-1
  Film_SimRank=diag(Film.col)
  colnames(Film_SimRank)=colnames(Data)[-1]
  
  # Preparation for Iteration
  In=list()
  for(i in 2:270)
    In[[(i-1)]]=MS_train[as.logical(MS_train[,i]),1]
  Out=list()
  for(i in 1:4151)
    Out[[i]]=as.integer(colnames(MS_train)[as.logical(MS_train[i,])][-1])
  
  # Initializition for User's SimRank
  ## Compute only Upper Triangle Matrix 
  for(i in 1:(User.col-1))
  {
    for(j in (i+1):User.col)
    {
      if(identical(Data[i,-1],Data[j,-1]))
        User_SimRank[i,j]=1
    }
  }
  ## Make the Symmetric Matrix according to Upper
  User_SimRank=Matrix::forceSymmetric(User_SimRank,uplo='U')
  User_SimRank=as.matrix(User_SimRank)
  
  # Iteration for K times
  while(K>0)
  {
    # Film's SimRank
    for(i in 1:(Film.col-1))
    {
      for(j in (i+1):Film.col)
      {
        m=C2/(length(In[[i]])*length(In[[j]]))
        Film_SimRank[i,j]=m*sum(User_SimRank[as.character(In[[i]]),as.character(In[[j]])])
      }
    }
    Film_SimRank=Matrix::forceSymmetric(Film_SimRank,uplo='U')
    Film_SimRank=as.matrix(Film_SimRank)
    
    # User's Simrank
    for(i in 1:(User.col-1))
    {
      for(j in (i+1):User.col)
      {
        m=C1/(length(Out[[i]])*length(Out[[j]]))
        User_SimRank[i,j]=m*sum(Film_SimRank[as.character(Out[[i]]),as.character(Out[[j]])])
      }
    }
    User_SimRank=Matrix::forceSymmetric(User_SimRank,uplo='U')
    User_SimRank=as.matrix(User_SimRank)
    # reduce K by 1
    K=K-1
  }
  # Write Files
  if(write.file=="User")
  {
    write(User_SimRank,file='User_SimRank.Rdata')
    write.csv(User_SimRank,file='User_SimRank.csv')
  }
  else if(write.file=="Film")
  {
    write(Film_SimRank,file='Film_SimRank.Rdata')
    write.csv(Film_SimRank,file='Film_SimRank.csv')
  }
  stop=Sys.time()
  Out=list(User_SimRank,Film_SimRank,stop-start)
  return(Out)
}

SimRank_Data=SimRank()
User_SimRank=SimRank_Data[[1]]
SimRank_Data[[3]]



