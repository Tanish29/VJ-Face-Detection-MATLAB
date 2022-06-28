%{
Function intim calculates the integral image 

input: image - an array of size 24x24 representing an image

output: integral image of same size as image
%}
function [intim] = IntegralImage(image)

% % normalize image
% image = image./255;
% assign two variables the size of the input array 
[nrows,ncols] = size(image);
% assign a variable of the size as the two variable above (24x24 in this case)
intim = zeros(nrows,ncols);
% the first element in the integral image will always be the first element
% in the input image
intim(1,1) = image(1,1);

% a nested for loop going through every column for each row 
for i = 1:nrows
    for j = 1:ncols
        area = 0;
        % if element is in the first row then
        if ((j - 1) > 0 && (i-1) <= 0)
            % calculate the the sum of the elements going backwards for the
            % first row in that column
            for k = j:-1:1
                area = area + image(i,k);
            end
            % assign the calculated area to the output array (intim)
            intim(i,j) = area;
        % if element is in the first column then
        elseif ((j - 1) <= 0 && (i-1) > 0)
            % calculate the sum of the elements going up for the first
            % column for that row
            for k = i:-1:1
                area = area + image(k,j);
            end
            intim(i,j) = area;
        % if the element is not in the first row or column then
        else
            % if the elements happens to be the first element then assign
            % it a value same as in the input array
            if (i == 1)&&(j == 1)
                intim(i,j) = image(i,j);
            else
                % else the area is the area one column behind + area one
                % row behind - area one column and row behind + current
                % value in the input array
                intim(i,j) = intim(i,j-1)+intim(i-1,j)-intim(i-1,j-1)+image(i,j);
            end
        end
    end
end
end