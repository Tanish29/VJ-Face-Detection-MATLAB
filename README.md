# VJ-Face-Detection-MATLAB
Face Detection in MATLAB by Tanish29

I have implemented Face Detection of 24x24 pixel images in MATLAB 
There are 38 classifiers as shown in HEAD branch and the important files are:
  FDTestImage.m - goes through all test images and for each one of them predicts whether its a face or not
  ENSFDTraining.m - this file contains code that uses data from FinalResults.mat to calculate the most important attributes
  FDTraining.m - this file contains code that trains the 38 classifiers which all have a few hundred predictor indices; all predictor indices add up to 6000
