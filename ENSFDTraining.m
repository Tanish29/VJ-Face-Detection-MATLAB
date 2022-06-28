clc

t = 1;
range = 3865:6977;

fprintf("Loading Feature Data\n")
if ~exist('Feature','var')
    Feature = load('FinalResults.mat');
    Feature = Feature.outputarray;
end

fields = dir('C:\Users\bhatt\OneDrive\Documents\Tanish\Education\Free Time Projects\Face Detection MATLAB\Dataset\train\All');

fprintf("Creating Imagename array\n")
Imagenames = strings(length(fields)-2,1);
for i = 3:length(fields)
    compatiblelen = convertCharsToStrings(fields(i).name);
    Imagenames(i-2,1) = compatiblelen;
end

fprintf("Creating face or no face array\n")
ForNF = strings(length(Imagenames),1);
for j = 1:length(Imagenames)
    if contains(Imagenames(j,1),'face')
        ForNF(j,1) = "face";
    else
        ForNF(j,1) = "No face";
    end
end

testdata1 = Feature(range,1:81168);
testdata2 = Feature(range,81169:162336);

tic;
fprintf("Starting first ensemble model\n")
FClassifier1 = fitcensemble(testdata1,ForNF(range,1),'Method','AdaBoostM1','NumLearningCycles',1000,'Learners','Tree','LearnRate',0.5,'NumBins',25);
imp1 = predictorImportance(FClassifier1);
fprintf("Finished first classification, saving now\n")
save imp1.mat imp1
time(t) = toc;

tic;
fprintf("Starting second ensemble model\n")
FClassifier2 = fitcensemble(testdata2,ForNF(range,1),'Method','AdaBoostM1','NumLearningCycles',1000,'Learners','Tree','LearnRate',0.5,'NumBins',25);
imp2 = predictorImportance(FClassifier2);
fprintf("Finished second classification, saving now\n")
save imp2.mat imp2
time(t+1) = toc;

save FClassifier1.mat FClassifier1
save FClassifier2.mat FClassifier2

clear i j
nonzero1 = [];
fprintf("combining important feature indices\n")
for i = 1:2
    if i == 1
        for j = 1:length(imp1)
            if (imp1(j) ~= 0)
                nonzero1(end+1) = j;
            end
        end
    else
        for j = 1:length(imp2)
            if (imp2(j) ~= 0)
                nonzero1(end+1) = j+81168;
            end
        end
    end
end
save predictimportantf.mat nonzero1

tic;
fprintf("Starting Final classification model\n")
FClassifier3 = fitcensemble(Feature(range,nonzero1),ForNF(range,1),'Method','AdaBoostM1','NumLearningCycles',1000,'Learners','Tree','LearnRate',0.5,'NumBins',25);
% impf = predictorImportance(FClassifier3);
fprintf("Finished classification\n")
save ENSClassifier.mat FClassifier3
time(t+2) = toc;

system('shutdown /h')

                
                    
        




