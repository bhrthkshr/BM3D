# BM3D
Image processing based on  Neural networks.

BM3D-Net:  A Convolutional Neural Network  For Transform-Domain 
Collaborative Filtering

Obtaining Enriched Image Qualities in image processing is an essential after denoising.

Unfold  BM3D algorithm into a convolutional neural network structure, with “extraction” and “aggregation” layers to model block matching stage in BM3D.

The network is applied to three denoising tasks: 
1-gray-scale image denoising.
2-color image denoising.
3-depth map denoising.

Image denoising  is a preprocessing  step in image analysis.
image denoising   roughly categorized into Traditional method and Learning based methods.    
Traditional methods:
 spatial filtering method  
 wavelet transformation based method
 shrinkage function approach. 
Learning based methods:
Natural image prior based method
Dictionary learning
Space coding
Deep learning


Network extends the computational procedures of BM3D to learnable CNN.
BM3D-Net 5 layers 
Extraction layer
Convolution layer 
Non-linear transform layer
Convolution layer
Aggregation layer


procedure to run the software

open matlab 2016a or higher version
open the project directory
run the  file-to-run.m file to begin 
the .m file automatically loads the required files and directories
Continue further by selecting the options 
training
testing
comparing
and final results.

In case of common errors try changing the local drive to F:/
or replace the local drive letter in the following files
* main_switch_UI.m
* train_d.m
* training_d.m
