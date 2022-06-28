% The purpose of this source code is to detect faces in images/RealTime
% hence output if there is a face or not using Viola Jones
% Algorithm
% Key assumptions are: input photos will be frontal faces not exceeding 45
% degree angle and will only contain one face (currently)

% cleaning up
clear; 
clc;

% find all the files in the folder and goes through a for loop
fields = dir('C:\Users\bhatt\OneDrive\Documents\Tanish\Education\Free Time Projects\Face Detection MATLAB\Dataset\train\All');
% adding the folder to path 
addpath('C:\Users\bhatt\OneDrive\Documents\Tanish\Education\Free Time Projects\Face Detection MATLAB\Dataset\train\All');
% calculating the size of the fields structure to know how many total
% images there are
[totalimages, ~] = size(fields);

% for loop going through every image from 1 to totalimages-2 as the first
% two element are empty/not image names
for count = 1:totalimages-2
    tic;
    % for every image ensure the output array is a single of size 1x162336
    outputarray(count,1:162336) = single(0);
    % get the image name
    imagename = fields(count+2).name;
    % read the image 
    readim = imread(imagename);
    % resize the image to a 24x24 single from 19x19 
    newim = single(imresize(readim,[24,24]));
    % calculate the single integral image 
    intim = single(IntegralImage(newim));
    % calculate all the haar features using the HaarFeature function
    outputarray = HaarFeatures(outputarray,intim,count);
    time(count) = toc;
end

% save the array
save FinalResults.mat outputarray -v7.3;



