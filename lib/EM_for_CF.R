############### EM Algorithm for Cluster Model  ###############

########## Fit to Movie Dataset ##########
EM_for_CF<- function(data, C, iterations=12){
  
  num_of_users<- length(unique(data$User))
  num_of_movies<- length(unique(data$Movie))
  list_of_users<- unique(data$User)
  list_of_movies<- unique(data$Movie)
  
  # Initialize parameters
  mu<- runif(C, 1, 10)
  mu<- mu/sum(mu) 
  gamma_array<- array(runif(num_of_movies*6*C, 1, 10), dim=c(num_of_movies, 6, C))
  for(d in 1:C){gamma_array[, , d]<- gamma_array[, , d]/rowSums(gamma_array[, , d])}
  
  pi_mat<- matrix(1, ncol=C, nrow=num_of_users)
  pi_mat_old<- matrix(0, ncol=C, nrow=num_of_users)
  print("Initialization is done!")
  
  for(iter in 1:iterations){
    print(paste("The norm is", norm(pi_mat-pi_mat_old, 'O'))) 
    pi_mat_old<- pi_mat
    
    # E-step
    ## Update pi_mat
    for (i in 1:num_of_users){
      user <- list_of_users[i]
      log_fi_prod<- log(rep(1, C))
      for(c in 1:C){
        sub_train<- data[data$User==user,][c("Movie", "Score")]
        movies_index<- match(sub_train$Movie, list_of_movies)
        score<- sub_train$Score
        all_index<- cbind(movies_index, score)
        for(j in 1:dim(sub_train)[1]){
          log_fi_prod[c]<- log_fi_prod[c] + log(gamma_array[all_index[j, 1], all_index[j, 2], c])
        }
      }
      
      max_log_fi<- max(log_fi_prod+log(mu))
      
      for(c in 1:C){
        pi_mat[i, c]<- exp(log(mu[c]) + log_fi_prod[c] - (max_log_fi + log((sum(exp(log(mu) + log_fi_prod - max_log_fi))))))       }
    }
    
    print(paste(iter, "E-step done!"))
    
    # M-step
    ## Update mu
    mu<- apply(pi_mat, 2, mean)
    
    ## Update gamma_array
    for(c in 1:C){
      for(score in 1:6){
        for(movie in list_of_movies){
          movie_index<- match(movie, list_of_movies)
          sub_train<- data[data$Movie==movie, ][c("Movie", "User", "Score")]
          users_index<- match(sub_train$User, list_of_users)
          if(sum(pi_mat[users_index, c])==0){
            gamma_array[movie_index, score, c]<- 0
          }
          else{
            gamma_array[movie_index, score, c]<- 
              sum(pi_mat[users_index, c] * (sub_train$Score==score)) / sum(pi_mat[users_index, c])
          }
        }
      }
    }
    print(paste(iter, "M-step done!"))
    print(paste("Iteration", iter, "done!"))
  }  
  return(list(mu=mu, gamma_array=gamma_array, pi_mat=pi_mat))
}  