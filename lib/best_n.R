best_n<- function(sw,n){
  loc<- apply(sw, 1, function(m) order(abs(m), decreasing = TRUE) )
  loc1<- loc[1:n, ]
  result<- list()
  for(i in 1:5055){
    result[[i]]<- ifelse(sw[i, loc1[ ,i]],sw[i, loc1[ ,i]],NA )
  }
  return(psw4)
}