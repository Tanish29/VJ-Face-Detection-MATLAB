%{
Function HaarFeatures calculates all the 162336 different haar features in
a 24x24 feature.

inputs: output - an array of size 1x162366 that will contain all the
        feature values
        intim - integral image of the input image
        currentim - the current image in progress

output: output - the input array
used code from: https://stackoverflow.com/questions/1707620/viola-jones-face-detection-claims-180k-features
%}
function [output] = HaarFeatures(output,intim,currentim)

% assign a variable the maximum size of the integral image which should be 24
maxsize = length(intim);
% assign a variable the number of different features; 5
numfeatures = 5;
% assign a variable an array containing the x,y size of each feature, each
% row is a different feature and each column is a x or y size
orientF = [2,1;1,2;3,1;1,3;2,2];
% assign a variable value of zero which will be used for haar feature
% counting
numcount = 0;

% Going through each of the five distinct features
for i = 1:numfeatures
    sizex = orientF(i,1);
    sizey = orientF(i,2);
    
    % Going through each size possible for this feature
    for widthx = sizex:sizex:maxsize
        for heighty = sizey:sizey:maxsize
            % for this size going through each possible position
            for x = 0:maxsize-widthx
                for y = 0:maxsize-heighty
                    % increase the possible number of combinations
                    numcount = numcount + 1;
                    % For each feature and each/every size and each/every position,
                    % calculate the haar feature using function compute
                    % assign the output to the output array 
                    output(currentim,numcount) = Compute(i,widthx,heighty,x,y,sizex,sizey,intim);
                end
            end
        end
    end
end
end
                        