% The purpose of this source code is train (adaboost) the gathered data so
% a strong classifier from best features which can then be used for cascading.

% cleaning up
clc;

% loading data
if ~exist('Feature','var')
    Feature = load('FinalResults.mat');
    Feature = Feature.outputarray;
end

fields = dir('C:\Users\bhatt\OneDrive\Documents\Tanish\Education\Free Time Projects\Face Detection MATLAB\Dataset\train\Train_All');

% getting all the image names and saving it in an array
Imagenames = strings(length(fields)-2,1);
for i = 3:length(fields)
    compatiblelen = convertCharsToStrings(fields(i).name);
    Imagenames(i-2,1) = compatiblelen;
end

% figuring out if its a face or not (ie 1 or 0 respectively)
ForNF = strings(length(Imagenames),1);
for j = 1:length(Imagenames)
    if contains(Imagenames(j,1),'face')
        ForNF(j,1) = "face";
    else
        ForNF(j,1) = "No face";
    end
end
 
% % Feature selection and building a strong classifier from the given data
% % using AdaBoost algorithm with the smallest learn rate for highest
% % accuracy
% 
%  using KNN algorithm for feature selection,output is the list of indices
%  in order of most importance to least to the response variable.
%  tic;
%  [idx,weights] = relieff(Feature,ForNF,83);
%  toc;
%  save predictorsindices.mat idx;
%  save predictorsweights.mat weights;

% loading the predictor indices
if ~exist('ensimpindices','var')
    idx = load('enspredictimportantindices.mat');
    idx = idx.ensimpindices;
end

% getting the first 6000 features which are ordered from most important
RequiredVars = idx(1,1:6000);
% setting 38 classifiers with the most important features in the first few
% classifiers
CR1 = RequiredVars(1,1:10);
CR2 = RequiredVars(1,11:31);
CR3 = RequiredVars(1,32:66);
CR4 = RequiredVars(1,67:103);
CR5 = RequiredVars(1,104:146);
CR6 = RequiredVars(1,147:195);
CR7 = RequiredVars(1,196:252);
CR8 = RequiredVars(1,253:317);
CR9 = RequiredVars(1,318:390);
CR10 = RequiredVars(1,391:471);
CR11 = RequiredVars(1,472:560);
CR12 = RequiredVars(1,561:657);
CR13 = RequiredVars(1,658:762);
CR14 = RequiredVars(1,763:875);
CR15 = RequiredVars(1,876:996);
CR16 = RequiredVars(1,997:1125);
CR17 = RequiredVars(1,1126:1262);
CR18 = RequiredVars(1,1263:1407);
CR19 = RequiredVars(1,1408:1560);
CR20 = RequiredVars(1,1561:1721);
CR21 = RequiredVars(1,1722:1890);
CR22 = RequiredVars(1,1891:2067);
CR23 = RequiredVars(1,2068:2252);
CR24 = RequiredVars(1,2253:2445);
CR25 = RequiredVars(1,2446:2646);
CR26 = RequiredVars(1,2647:2855);
CR27 = RequiredVars(1,2856:3072);
CR28 = RequiredVars(1,3073:3297);
CR29 = RequiredVars(1,3298:3530);
CR30 = RequiredVars(1,3531:3771);
CR31 = RequiredVars(1,3772:4020);
CR32 = RequiredVars(1,4021:4277);
CR33 = RequiredVars(1,4278:4542);
CR34 = RequiredVars(1,4543:4815);
CR35 = RequiredVars(1,4816:5096);
CR36 = RequiredVars(1,5097:5385);
CR37 = RequiredVars(1,5386:5686);
CR38 = RequiredVars(1,5687:6000);

% combining all the arrays in a cell array for easier accessing
AllCR = {CR1,CR2,CR3,CR4,CR5,CR6,CR7,CR8,CR9,CR10,CR11,CR12,CR13,CR14,CR15,....
    CR16,CR17,CR18,CR19,CR20,CR21,CR22,CR23,CR24,CR25,CR26,CR27,CR28,CR29,CR30,CR31,CR32,CR33,CR34,CR35,CR36,CR37,CR38};
% array containing the filenames to save each classifier after training
savename = ["CR1","CR2","CR3","CR4","CR5","CR6","CR7","CR8","CR9","CR10","CR11",....
    "CR12","CR13","CR14","CR15","CR16","CR17","CR18","CR19","CR20","CR21","CR22",....
    "CR23","CR24","CR25","CR26","CR27","CR28","CR29","CR30","CR31","CR32","CR33","CR34",....
    "CR35","CR36","CR37","CR38"];

% Training the classifier one by one using a loop
m = 3865;
for k = 1:38
     tic;
     %FClassifier = fitcensemble(Feature(6350:-1:m,AllCR{k}),ForNF(6350:-1:m,1),'Method','AdaBoostM1','NumLearningCycles',100,'Learners','Tree','LearnRate',1);
     FClassifier = fitensemble(Feature(6335:-1:m,AllCR{k}),ForNF(6335:-1:m,1),'AdaBoostM1',100,'Tree','Learnrate',1, 'cost', [0, 1 ; 1, 0]);
     time(k) = toc;  
     filename = strcat("fit",savename(k));
     save(filename,'FClassifier');
     m = m-5;
     disp(num2str(k))
end


%___________________________Other Methods__________________________________
% t = templateTree('MaxNumSplits',1);
% FClassifier = fitensemble(Feature,ForNF,'AdaBoostM1',1,t,'LearnRate',0.1);
% Saving the classifier
% save TrainedClassifier.mat FClassifier -v7.3;

% below code for viewing and data recording (attempting to use classification learner
% app)
% % creating two tables, first one is a table comprising of n haar features
% % for each image and has their corresponding imagename variable
% % max value in the array is 65450
% Ftable = array2table(Feature);
% Ftable.Imagenames = Imagenames;
% 
% % the second table is a table of the imagenames and whether the image is a
% % face (1) or not face (0)
% table1 = table(Imagenames,ForNF);
% 
% % combining/joining the two tables, using imagenames as key variable
% TrainingData = join(Ftable,table1);





