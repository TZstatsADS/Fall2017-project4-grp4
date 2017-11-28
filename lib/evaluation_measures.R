#########################################################
### Compute evaluation measures for clustering result ###
#########################################################

### Authors: Qian Shi
### Project 4
### ADS Fall 2017


MAE_evaluate<- function(est_Score, real_Score){
  MAE<- sum(abs(est_Score - real_Score)) / length(est_Score)
  return(MAE)
}

ROC_evaluate<- function(est_Score, real_Score){
  library('pROC')
  ROC<- multiclass.roc(real_Score, est_Score)
  return(ROC)
}





