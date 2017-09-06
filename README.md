# Introduction

This package is part of the Kadenze Academy program [Creative Applications of Deep Learning w/ TensorFlow](https://www.kadenze.com/programs/creative-applications-of-deep-learning-with-tensorflow).

[COURSE 1: Creative Applications of Deep Learning with TensorFlow I](https://www.kadenze.com/courses/creative-applications-of-deep-learning-with-tensorflow-iv/info) (Free to Audit)  
Session 1: Introduction to TensorFlow  
Session 2: Training A Network W/ TensorFlow  
Session 3: Unsupervised And Supervised Learning  
Session 4: Visualizing And Hallucinating Representations  
Session 5: Generative Models  

[COURSE 2: Creative Applications of Deep Learning with TensorFlow II](https://www.kadenze.com/courses/creative-applications-of-deep-learning-with-tensorflow-ii/info) (Program exclusive)  
Session 1: Cloud Computing, GPUs, Deploying  
Session 2: Mixture Density Networks  
Session 3: Modeling Attention with RNNs, DRAW  
Session 4: Image-to-Image Translation with GANs  

[COURSE 3: Creative Applications of Deep Learning with TensorFlow III](https://www.kadenze.com/courses/creative-applications-of-deep-learning-with-tensorflow-iii-iii/info) (Program exclusive)  
Session 1: Modeling Music and Art: Google Brain’s Magenta Lab  
Session 2: Modeling Language: Natural Language Processing  
Session 3: Autoregressive Image Modeling w/ PixelCNN  
Session 4: Modeling Audio w/ Wavenet and NSynth  

This is a flask application which serves a pre-trained TensorFlow model.

# Instructions

First build the docker image:

`docker build -t flask-app .`

Then run the docker image, mapping the UWSGI server on port 80 to any local port you choose, e.g. 5000:

`docker run -p 5000:80 -it flask-app`

You should then be able to use `curl` to test the server:

`curl localhost:5000`
