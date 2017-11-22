cwt<- function(sw, t){
  result<- matrix(NA, ncol=ncol(sw), nrow = nrow(sw))
  result<- ifelse(abs(sw)>=t,sw,NA)
  return(result)
}