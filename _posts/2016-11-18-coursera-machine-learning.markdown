---
layout: post
title: Coursera Machine Learning
published: true
---

这门课也是本科的时候尝试然后放弃的课，今年五月重新捡了起来还买了证书，夏天复习GRE没看，赶在可以获得证书的最后几天（要半年内学完）终于学完了。

这门课是 [CS229](http://cs229.stanford.edu/) 的 [“watered down”版本](https://www.quora.com/What-are-the-differences-between-the-Andrew-Ngs-Machine-Learning-courses-offered-on-Coursera-and-iTunes-U?srid=bMF)。
剔除了几乎所有需要数学知识的部分，只需要知道如何求导以及矩阵乘法。编程作业里的所有数学公式都给出来了，只需要在MATLAB里实现就可以了。这门课很奇葩的一点是入门比较难...后面越来越简单。

总结一下这门课都讲了啥？

1. 线性回归，cost function, gradient descent, vectorized implementation

2. Feature scaling, mean normalization, normal equation（但是数据量大的时候很慢）, regularization

3. Logistic Regression（用到sigmoid function和取对数的cost function）, Advanced optimization, one-vs-all

4. Neural Networks: Forward Propagation, bias unit, Backpropagation（可以用gradient checking确定backpropagation算出的导数是否正确）, Random initialization: Symmetry breaking

5. Training/validation/test sets

   ![](/images/ml-bias-variance.png)
   ![](/images/ml-learning-curve.png)

6. Spam classification, Precision/Recall, F Score

7. SVM：修改Logistic Regression的model，优化theta即可获得比较好的结果。

    参考：[支持向量机: Maximum Margin Classifier](http://blog.pluskid.org/?p=632)
    
    Kernel: 生成feature的好方法，可以选择数据作为landmarks，选择基于到landmark的距离的similarity methods来生成新的数据。
    
    ![](/images/ml-logistic-regression-svm.png)

8. KMeans

9. Demension Reduction: PCA(SVD分解）(Bad use: prevent overfitting)

10. Anomaly Detection，这里用的是高斯分布，判断数据点是否离均值太远

    ![](/images/ml-anomaly-detection.png)

11. Collabrative Filtering

    ![](/images/ml-collabrative-filtering.png)

11. Stochastic gradient descent(random shuffle first, can slowly decrease alpha), mini-batch gradient descent, MapReduce

12. Pipline, Ceiling analysis

嗯只是给我自己看的....有人写了很详细的笔记，强烈推荐：[http://www.holehouse.org/mlclass/index.html](http://www.holehouse.org/mlclass/index.html)

接下来我现在在看Hilton的Neural Network，很详细地讲神经网络，上周学了CNN，这周讲RNN。等明年有空去搞搞Kaggle，学完不动手就全忘了。或许看下CS229或者231n吧...
