test2 = read.csv("test2.csv")
test2 = data.frame(test2[,c(-1)],row.names = test2[,1])

K = 10

prediction<-function(test2, train2, K, weight){
  ###Params
    #test2:testing set
    #train2: traing set
    #K: number of nearest neighbours
    #weight: similarity matrix w/ significant weight
  ###Return: None
 
  pred2 = matrix(NA, nrow=nrow(test2),ncol=ncol(test2))
  
  #for each user i, we want to apply trained model to predict the 
  #rating on the items (that we are given the rating).
  for (i in 1:length(test2[,1])){
    
    #user i's overall mean
    mu_i = sum(train2[i,],na.rm = T)/sum(!is.na(train2[i,]))
    
    for (j in 1:length(test2[1,])){
      #only care about the items that we have actual rating
      if (!is.na(test2[i,j])){
        #find the set of users that have rated item j in training set
        user_reated_j = which(!is.na(train2[,j]))
        
        #sim score between i and all users who rated j
        user_reated_j_sim_i = weight[i,user_reated_j]
        user_reated_j_sim_i = as.data.frame(user_reated_j_sim_i)
        
        #top k sorted sim scores 
        sim_scores = user_reated_j_sim_i[order(user_reated_j_sim_i,decreasing = TRUE),][1:K]
        
        #top k similar user ids
        ids = rownames(user_reated_j_sim_i)[order(user_reated_j_sim_i,decreasing = TRUE)][1:K]
        
        #top k users' ratings
        topk_ratings = train2[rownames(train2) %in% ids,j]
        
        #top k users' overall mean ratings
        mu_ks = apply(train2[rownames(train2) %in% ids,],1,mean, na.rm = T)
        
        #waighted prediction
        #in case there is no other user rated item j
        if(length(mu_ks) == 0){
          pred_ij = mu_i
        }
        else{
          pred_ij = mu_i + t(topk_ratings - mu_ks) %*% as.matrix(sim_scores[1:min(K,length(mu_ks))]) / sum(sim_scores[1:min(K,length(mu_ks))])
        }
        #print(paste("---predicted rating for user",i,"on movie",j,"is:",pred_ij))
        #print(paste("---acutal rating for user",i,"on movie",j,"is:",test2[i,j]))
        
        #store prediction
        pred2[i,j] = pred_ij
      }
    }
  }
  rowname(pred2) = rowname(test2)
  colname(pred2) = colname(test2)
  write.csv(pred2,"prediction.csv")
}
