sign_w1<- function(sw,data){
  data1<- !is.na(data)
  data2<- data1 %*% t(data1)
  data3<- data2/2
  data3<- ifelse(data3>=1,1,data3)
  data_sw<- sw * data3
  return(data_sw)
}