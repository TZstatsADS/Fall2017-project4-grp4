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
+ Project summary: 
+ 1.Memory-based Algorithm
+ Similarity Weight
+          a. Pearson Correlation: 1,2
+          b. Entropy: 1,2
+          c. Mean-Square-difference: 1,2
+          d. SimRank :1
+ Significance Weighting: 1,2
+ Selecting Neighbours
+         a. Weight Threshold: 1,2
+        b. Best-n-estimator: 1,2
+         c. Combined: 1,2
+ Rating Normalization: Deviation for Mean: 1 ,2
+ 2.Cluster Model:2

	
**Contribution statement**: ([default](doc/a_note_on_contributions.md))
+ Xinyao Guo(xg2257): Data preprocessing for movie data;  Similarity Weight: Pearson Correlation, Entropy, Mean-square-difference;  main.Rmd
+ Lin Han(lh2810)--DESIDGNED PRESENTOR: Significance Weighting; Selecting Neighbors: Weight Threshold, Best-n-estimator, Combined; Evaluation: Ranked Scoring, MAE for model1; main.Rmd; PPT
+ Qihang Li(ql2276): Data preprocessing for web data;SimRank;  Rating Normalization: Deviation for Mean; Evaluation: Ranked Scoring;   main.Rmd
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
