% The purpose of this source code is to use some of the classifiers to
% detect faces in an image
clear bounds;
clc

% ask user for name of the image for scanning
photo = input("Image name (with extension): ","s");
photo = imread(photo);
% convert the image to greyscale
greyscalephoto = im2gray(photo);
% assign two variables the size of the input image
[nrows,ncols] = size(greyscalephoto);
% assign a variable 0 initially to represent how many face like feature detected 
f = 0;
% assign a variable 230 to represent shifting square step size
% % assign a variable 115 to represent scaling square step size 
% stes = 23*4;
% assign a variable 10 to represent the number of classifiers to use
numcr = 3;

% % if the input image resolution is greater than 1000 
% if (nrows > 1080 && ncols > 1080)
%     % then change the step size and num classifiers to use
%     stes = 345;
%     stel = 460;
%     numcr = 14;
% end
stel = 23*7;
stes = 23*7;

tic;
% a two nested loop, first two loops represent the y and x scaling
% respectively

for i = 23:stes:nrows
    for j = 23:stes:ncols
        % the two inner loops represent the y and x location respectively
        for y = 1:stel:nrows-i
            for x = 1:stel:ncols-j
                % get a square from the input image and assign it to a var
                % row starts from the y location to the y location + i
                % col starts from the x location to the x location + j
                subwindow = greyscalephoto(y:y+i,x:x+j);
                % resize the subwindow to a 24x24 to calculate haar
                % features
                subwindow = imresize(subwindow,[24,24]);
                % calculate the integral image of that subwindow
                intim = IntegralImage(single(subwindow));
                % a loop from 1 to the num classifiers to use
                for k = 1:numcr
                    features = single(zeros(1,length(AllCR{k})));
                    % calculate the required haar features using ReqVar
                    % features = ReqVar(features,intim,1,AllCR{k});
                    features = HaarFeatures(features,intim,1);
                    % load the current classifier
                    FClassifier = LoadClass(k);
                    % if the prediction is not a face, then break the loop
                    if ~(predict(FClassifier,features(1,AllCR{k})) == "face")
                        break;
                    end
                    % if the loop reaches the end then increase face detect
                    % variable (f in this case) by 1
                    if k == numcr
                        f = f+1;
                        bounds{f} = [x,y,j,i];
                    end
                end
            end
        end
    end
end
time = toc

% if more than 1 face like feature have been detected display 
if f > 1 
    disp("face")
else
    disp("no face");
end
figure(1)
imshow(greyscalephoto);hold on
for l = 1:length(bounds)
    rectangle('Position',bounds{l},'EdgeColor','r');
end
title('Face Detection');
hold off;


