ranked_s<- function(pred,d,n){
  pred<- ifelse(is.na(pred), d, pred)
  index<- apply(pred[ ,-1], 1, function(m) sort(abs(m), decreasing = TRUE))
  index<- data.frame(index, row.names = pred[ ,1])
  alpha<- apply(pred[ ,-1], 1, function(x) sum(x==0.5))
  XX<- function(x){
    for(j in 1:length(x)){
      x*2^(1-j)*2^(alpha[j]-1)
    }
  }
  m<- max(pred-0,d)
  r<- apply(m, 1,XX)
  R<- 100* sum(r)* sum(sort(r,decreasing = T)[1:n])
  return(R)
}