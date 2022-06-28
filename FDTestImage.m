
% cleaning things up
clc

%if ~exist('FClassifier3','var')
%    load('ENSClassifier.mat');
%end

fields = dir('C:\Users\bhatt\OneDrive\Documents\Tanish\Education\Free Time Projects\Face Detection MATLAB\Dataset\test\face');
addpath('C:\Users\bhatt\OneDrive\Documents\Tanish\Education\Free Time Projects\Face Detection MATLAB\Dataset\test\face');
[totalimages, ~] = size(fields);
f = 0;
for i = 1:472
    Features = single(zeros(1,162336));
    imagename = fields(i+2).name;
    testreadim = imread(imagename);
    testnewim = single(imresize(testreadim,[24,24]));
    testintim = single(IntegralImage(testnewim));
    %[Features,tfbounds] = ReqVar(Features,testintim,1,CR1);
    Features = HaarFeatures(Features,testintim,1);
    numcrs = 1;
    imshow(testreadim)
    for j = 1:numcrs
        FClassifier = LoadClass(j);
        if(predict(FClassifier,Features(1,AllCR{j})) ~= "face")
            disp("not a face")
            break;
        end
        if j == numcrs
            f = f+1;
            disp("face")
        end 
    end
end
    
            
            
            
                                                                                                           
                                                                                                                                                            