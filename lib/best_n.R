best_n<- function(sw,n){
  loc<- apply(sw, 1, function(m) order(abs(m), decreasing = TRUE) )
  loc1<- loc[1:n, ]
  result<- matrix(NA,nrow = nrow(sw),ncol = ncol(sw))
  result<- data.frame(result)
  for(i in 1:nrow(result)){
    result[ i, loc1[ ,i] ]<- sw[i, loc1[ ,i]]
  }
  return(result)
}
