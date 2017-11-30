# Project 4: Collaborative Filtering

### [Project Description](doc/project4_desc.md)

+ Group 4
+ Team members:
	+ Carantino, Vassily (vc2434)
	+ Guo, Xinyao (xg2257)
	+ Han, Lin(lh2810)
	+ Li, Qihang(ql2276)
	+ Shi, Qian(qs2164)
	
The designated presenter is Han, Lin

**Project Introduction**:

We want to compare different options to perform collaborative filtering on two distinct database.
We need to compare the following things:

+ Memory-based Algorithm(based on neighbors)
	+ Different combinations of components

+ Model-based Algorithm 
	+ Choose the best meta-parameters
	
**Project summary**:

+ 1.Memory-based Algorithm
+ Similarity Weight
	+ a. Pearson Correlation: 1,2
	+ b. Entropy: 1,2
	+ c. Mean-Square-difference: 1,2
	+ d. SimRank :1
+ Significance Weighting: 1,2
+ Selecting Neighbours
	+ a. Weight Threshold: 1,2
	+ b. Best-n-estimator: 1,2
	+ c. Combined: 1,2
+ Rating Normalization: Deviation for Mean: 1 ,2
+ 2.Cluster Model:2

**Discussion**:

+ (Memory-based) For the Microsoft Dataset, in terms of Similarity Weighting, MSE and Entropy outperforms Pearson Correlation in general. In terms of Selecting Neighbors, Weight Threshold seems to be the best in most combinations. Specifically, Entropy+Significance Weighting+Weight Threshold(0.7) performs the best. MSE+Combined and MSE+Weight Threshold(0.7) also perform well.

+ (Memory-based) For the Movie Dataset, Significance Weighting seems to be a need to reduce MAE in every combination. In terms of Selecting Neighbors, Weight Threshold outperforms Best-N and Combined Method. For best-N, n=15 outperform n=10. Specifically, MSE+Significance Weighting+Weigth Threshold(0.85) performs the best. Pearson+Significance Weighting+Weight Threshold(0.5) and Pearson+Significance Weighting+Combined also perform well.

+ (Model-based) The best collaborative filtering algorithm on the Movie dataset is our Cluster Model with 7 latent classes.

Please note that it might not be the case on the Web Data Set, for which our better tested algorithm is the memory-based Entropy+Significance Weighting+Weight Threshold(0.7). Further analysis is needed for the cluster model on the Web data.



**Contribution statement**: ([default](doc/a_note_on_contributions.md))

+ Xinyao Guo(xg2257): Data preprocessing for movie data;  Similarity Weight: Pearson Correlation, Entropy, Mean squared difference; Prediction with Best-n; MAE on Movie dataset; main.Rmd
+ Lin Han(lh2810)--DESIDGNED PRESENTOR: Significance Weighting; Selecting Neighbors: Weight Threshold, Best-n-estimator, Combined; Evaluation: Ranked Scoring, MAE for model1; main.Rmd; PPT
+ Qihang Li(ql2276): Data preprocessing for web data; SimRank; Rating Normalization: Deviation for Mean; Evaluation: Ranked Scoring;   main.Rmd
+ Qian Shi(qs2164): Cluster Model;Evaluation(For cluster model):MAE, ROC; main.Rmd
+ Vassily Carantino(vc2434): Cluster Model;  main.Rmd; PPT



Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
