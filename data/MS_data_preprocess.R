
#---------------------------------
# preprocess function for the MS_data. The output will be matrix.
MS_data_preprocess=function(filename='./Data/MS_train')
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
  #write(User,file=paste(filename,'.Rdata',sep=''))
  write.csv(User,file=paste(filename,'2.csv',sep=''),row.names=F)
  return(User)
}




MS_data_preprocess2=function(filename='./Data/MS_test',filename2='./Data/MS_train')
{
  data_source=paste(filename,'.csv',sep='')
  data_source2=paste(filename2,'.csv',sep='')
  # read in data
  Data=read.csv(data_source)[,2:3]
  Data2=read.csv(data_source2)[,2:3]
  # get rows and cols for matrix
  User.row=sum(Data=='C')
  User.col=length(unique(Data2[Data2=="V",2]))+1
  # empty matrix filled with NA
  User=matrix(0,nrow=User.row,ncol=User.col)
  User[,1]=Data[which(Data[,1]=='C'),2]
  # indices for selection
  Index1=(which(Data[,1]=='C')+1)
  Index2=c((which(Data[,1]=='C')-1)[-1],nrow(Data))
  # colnames
  colnames(User)=c('User',as.character(sort(unique(Data2[Data2=="V",2]))))
  # change exsiting values to 1
  for(i in 1:User.row)
    User[i,as.character(Data[Index1[i]:Index2[i],2])]=T
  # you can comment either of the lines below
  #write(User,file=paste(filename,'.Rdata',sep=''))
  write.csv(User,file=paste(filename,'2.csv',sep=''),row.names=F)
  return(User)
}



MS_data_preprocess()
MS_data_preprocess2()
