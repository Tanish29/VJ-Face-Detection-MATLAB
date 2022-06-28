%{
Function LoadClass loads a classifier depending on the input

input: cr - number indicating which classifier to load

output: result - a variable containing a structure which is the loaded
classifier
%}
function [result] = LoadClass(cr)

% for example if cr is 1 then load the first classifier
if cr == 1
    load('fitCR1.mat');
elseif cr == 2
    load('fitCR2.mat');
elseif cr == 3
    load('fitCR3.mat');
% or if cr is 4 then load the fourth classifier
elseif cr == 4
    load('fitCR4.mat');
elseif cr == 5
    load('fitCR5.mat');
elseif cr == 6
    load('fitCR6.mat');
elseif cr == 7
    load('fitCR7.mat');
elseif cr == 8
    load('fitCR8.mat');
elseif cr == 9
    load('fitCR9.mat');
elseif cr == 10
    load('fitCR10.mat');
elseif cr == 11
    load('fitCR11.mat');
elseif cr == 12
    load('fitCR12.mat');
elseif cr == 13
    load('fitCR13.mat');
elseif cr == 14
    load('fitCR14.mat');
elseif cr == 15
    load('fitCR15.mat');
elseif cr == 16
    load('fitCR16.mat');
elseif cr == 17
    load('fitCR17.mat');
elseif cr == 18
    load('fitCR18.mat');
elseif cr == 19
    load('fitCR19.mat');
elseif cr == 20
    load('fitCR20.mat');
elseif cr == 21
    load('fitCR21.mat');
elseif cr == 22
    load('fitCR22.mat');
elseif cr == 23
    load('fitCR23.mat');
elseif cr == 24
    load('fitCR24.mat');
elseif cr == 25
    load('fitCR25.mat');
elseif cr == 26
    load('fitCR26.mat');
elseif cr == 27
    load('fitCR27.mat');
elseif cr == 28
    load('fitCR28.mat');
elseif cr == 29
    load('fitCR29.mat');
elseif cr == 30
    load('fitCR30.mat');
elseif cr == 31
    load('fitCR31.mat');
elseif cr == 32
    load('fitCR32.mat');
elseif cr == 33
    load('fitCR33.mat');
elseif cr == 34
    load('fitCR34.mat');
elseif cr == 35
    load('fitCR35.mat');
elseif cr == 36
    load('fitCR36.mat');
elseif cr == 37
    load('fitCR37.mat');
elseif cr == 38
    load('fitCR38.mat');
end
% assign the output variable to the strucuture
result = FClassifier;
end


