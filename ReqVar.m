%{
Function ReqVar does a similar computation as function HaarFeatures except
that it calculates the required features of its classifier only 

inputs: output - array containing haar feature values, size changes
        intim - integral image of the input image
        cr - an array containg the haar features to calculate
%}
function [output,tfbounds]= ReqVar(output,intim,currentim,cr)

maxsize = length(intim);
numfeatures = 5;
orientF = [2,1;1,2;3,1;1,3;2,2];
numcount = 0;
% assign a variable the sort haar feature numbers in ascending order using
% the input cr array
scr = sort(cr);
% assign a variable zero which will be used for indexing 
index = 0;

% at anytime the number of feature reaches the max feature in cr array
% break all for loops
for i = 1:numfeatures
    if (numcount>=max(cr))
        break;
    end
    sizex = orientF(i,1);
    sizey = orientF(i,2);
    
    for widthx = sizex:sizex:maxsize
        if (numcount>=max(cr))
            break;
        end
        for heighty = sizey:sizey:maxsize
            if (numcount>=max(cr))
                break;
            end
            for x = 0:maxsize-widthx
                if (numcount>=max(cr))
                    break;
                end
                for y = 0:maxsize-heighty
                    numcount = numcount + 1;
                    % if the sum of the current feature in the 
                    % sorted array is one then 
                    if (sum(numcount == cr) == 1)
                        % increase index value by one
                        index = index+1;
                        % calculate the value of that haar feature and use
                        % variable index for column indexing
                        output(currentim,index) = Compute(i,widthx,heighty,x,y,sizex,sizey,intim);
                        tfbounds{index} = [x,y,widthx,heighty];
                    end
                    if (numcount>=max(cr))
                        break;
                    end
                end
            end
        end
    end
end

% a simple for loop that rearranges the values in the output array to match
% the arrangment of the haar features in the input cr array
for k = 1:length(cr)
    pos = strfind(cr,scr(k));
    value = output(pos);
    newoutput(pos) = output(k);
    newoutput(k) = value;
end

end
                        

