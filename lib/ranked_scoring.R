ranked_s<- function(pred,test,d=0,alpha=10){
  test<- apply(test, 2, function(x) ifelse(is.na(x),d,x))
  
  loc<- apply(pred[ ,-1], 1,function(x) names(sort(x, decreasing = T)))
  loc<-t(loc)
  loc<- data.frame(loc, row.names = pred[ ,1])
  
  loc1<- apply(test[ ,-1], 1,function(x) names(sort(x, decreasing = T)))
  loc1<-t(loc1)
  loc1<- data.frame(loc1, row.names = test[ ,1])
  
  m<-apply(test,2, function(x) ifelse(x-d>0, x-d,0))
  r<- m*2^(alpha-1)*2^(1-loc)
  # r<- apply(m, 1,XX)
  # R<- 100* sum(r)* sum(sort(r,decreasing = T)[1:n])
  return(R)
}
