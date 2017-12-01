
# Ranked Score for dataset 1 (the Microsoft data)
Ranked_Score1=function(prediction,d=0.5,alpha=5)
{
  # Test data
  Test=read.csv('./Data/MS_test2.csv',header=T,check.names=F)
  rownames(Test)=as.character(Test[,1])
  Test=as.matrix(Test[,-1])
  Test[is.na(Test)]=0
  User=as.integer(Test[-1,1])
  Film=as.integer(colnames(Test)[-1])
  Users=length(User)
  Films=length(Film)
  
  # Prediction data
  Prediction=read.csv(paste('./Data/Prediction/',prediction,'.csv',sep=''),
                      header=T,check.names=F)
  rownames(Prediction)=as.character(Prediction[,1])
  Prediction=as.matrix(Prediction[,-1])
  
  # Prediction Sorting
  Prediction_Sorting=t(apply(Prediction,1,function(x)names(sort(x,decreasing=T))))
  Prediction_Sorting=matrix(as.character(Prediction_Sorting),ncol=Films)
  #Test_by_Sorting=Test[,matrix(as.character(Prediction_Sorting),ncol=Films)]
  Test_by_Sorting=matrix(nrow=Users,ncol=Films)
  for(i in 1:Users)
    Test_by_Sorting[i,]=Test[i,Prediction_Sorting[i,]]
  Test_by_Sorting=ifelse(Test_by_Sorting>d,Test_by_Sorting-d,0)
  
  # Test data Sorting
  Test_Sorting=t(apply(Test,1,function(x)names(sort(x,decreasing=T))))
  Test_Sorting=matrix(as.character(Test_Sorting),ncol=Films)
  Test_max_Sorting=matrix(nrow=Users,ncol=Films)
  for(i in 1:Users)
    Test_max_Sorting[i,]=Test[i,Test_Sorting[i,]]
  Test_max_Sorting=ifelse(Test_max_Sorting>d,Test_max_Sorting-d,0)
  
  # Exponential decay
  denumerator=rep(0,Films)
  for(i in 1:Films)
    denumerator[i]=0.5^((i-1)/(alpha-1))
  
  # Computing R
  R_a=as.vector(Test_by_Sorting%*%denumerator)
  R_max=as.vector(Test_max_Sorting%*%denumerator)
  R=100*sum(R_a)/sum(R_max)
  return(R)
}


dim(Prediction_Sorting)
