
% cleaning things up
clc

%if ~exist('FClassifier3','var')
%    load('ENSClassifier.mat');
%end

fields = dir('C:\Users\bhatt\OneDrive\Documents\Tanish\Education\Free Time Projects\Face Detection MATLAB\Dataset\test\Test_All');
addpath('C:\Users\bhatt\OneDrive\Documents\Tanish\Education\Free Time Projects\Face Detection MATLAB\Dataset\test\Test_All');
[totalimages, ~] = size(fields);
tf = 0;
tn = 0;
for i = 1:300
    Features = single(zeros(1,162336));
    imagename = fields(i+2).name;
    testreadim = imread(imagename);
    testnewim = single(imresize(testreadim,[24,24]));
    testintim = single(IntegralImage(testnewim));
    %[Features,tfbounds] = ReqVar(Features,testintim,1,CR1);
    Features = HaarFeatures(Features,testintim,1);
    numcrs = 2;
    imshow(testreadim)
    for j = 1:numcrs
        FClassifier = LoadClass(j);
        if(predict(FClassifier,Features(1,AllCR{j})) ~= "face")
            if mod(i,2) == 1
                tn = tn+1;
                disp("not a face")
                break;
            end
        end
        if j == numcrs
            if mod(i,2) == 0
                tf = tf+1;
                disp("face")
            end
        end 
    end
end
% print the accuracy
fprintf("accuracy = %d", (tf+tn)/i)
            
            
            
                                                                                                           
                                                                                                                                                            