cwt<- function(sw, t){
  result<- apply(sw, 1, function(x) ifelse(abs(x)>=t, x, NA))
  return(result)
}
