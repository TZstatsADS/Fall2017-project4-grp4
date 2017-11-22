combined<- function(sw,n,t){
  loc<- apply(sw, 1, function(m) order(abs(m), decreasing = TRUE) )
  loc1<- loc[1:n, ]
  result<- list()
  for(i in 1:5055){
    result[[i]]<- ifelse((sw[i, loc1[ ,i]])&(abs(sw[i, loc1[ ,i]])>=t), sw[i, loc1[ ,i]], NA)
    result[[i]]<- na.omit(result[[i]])
  }
  return(result)
}