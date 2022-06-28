%{ 
Function compute calculates the value of the haar feature using the
integral image and the feature dimensions

inputs: feature - number indicating the type of feature 1,2,3,4,5 as two
        horizontal feature,two vertical feature, three horizontal feature,
        three vertical feature, four feature respectively
        widthx - current width of the feature
        heighty - current height of the feature
        x,y - x and y locations respectively
        sizex - original width of the feature
        sizey - original height of the feature
        intim - the integral image of the input image

outputs: value - sum of white regions - sum of black regions 
%}
function [value] = Compute(feature,widthx,heighty,x,y,sizex,sizey,intim)

% assigning variable value as single to save memory
value = single(0);
% conditionals statements to check what the shape/feature is and according
% to that the value is calculated
if (feature == 1)
    % if the feature is 1 (ie the two horizontal feature, black region on the right)
    % then depending on their current size and original size calculate the
    % values accordingly
    if (widthx == sizex && heighty == sizey && x == 0 && y == 0) 
        Lregion = intim(heighty,widthx/2);
        Dregion = intim(heighty,widthx)-Lregion;
    elseif (widthx == sizex && heighty == sizey && x == 0 && y > 0)
        Lregion = intim(y+heighty,widthx/2)-intim(y,widthx/2);
        Dregion = intim(y+heighty,widthx)-intim(y+heighty,widthx/2)-intim(y,widthx)+intim(y,widthx/2);
    elseif (widthx == sizex && heighty == sizey && x > 0 && y == 0)
        Lregion = intim(heighty,x+(widthx/2))-intim(heighty,x);
        Dregion = intim(heighty,x+widthx)-intim(heighty,x+(widthx/2));
    else
        if (x == 0 && y == 0)
            Lregion = intim(heighty,widthx/2);
            Dregion = intim(heighty,widthx)-intim(heighty,widthx/2);
        elseif (x == 0 && y > 0)
            Lregion = intim(y+heighty,widthx/2)-intim(y,widthx/2);
            Dregion = intim(y+heighty,widthx)-intim(y+heighty,widthx/2)-intim(y,widthx)+intim(y,widthx/2);
        elseif (x > 0 && y == 0)
            Lregion = intim(heighty,x+(widthx/2))-intim(heighty,x);
            Dregion = intim(heighty,x+widthx)-intim(heighty,x+(widthx/2));
        else
            % for example if the current size is not equal to the original
            % size and the current x and y locations are not zero then the
            % light region and dark region is calculated like this below
            Lregion = intim(y+heighty,x+(widthx/2))-intim(y+heighty,x)-intim(y,x+(widthx/2))+intim(y,x);
            Dregion = intim(y+heighty,x+widthx)-intim(y+heighty,x+(widthx/2))-intim(y,x+widthx)+intim(y,x+(widthx/2));
        end
    end
    % before the end of each feature if statement the value is calculated
    % and returned
    value = (Lregion)-(Dregion);
    
% for all the different features the same method is applied but as some
% features have more than one black/white regions and different
% orientation of these regions the way to calculate them is a bit different
elseif (feature == 2)
    if (widthx == sizex && heighty == sizey && x == 0 && y == 0)
        Lregion = intim(heighty,widthx)-intim(heighty/2,widthx);
        Dregion = intim(heighty/2,widthx);
    elseif (widthx == sizex && heighty == sizey && x == 0 && y > 0)
        Lregion = intim(y+heighty,widthx)-intim(y+(heighty/2),widthx);
        Dregion = intim(y+(heighty/2),widthx)-intim(y,widthx);
    elseif (widthx == sizex && heighty == sizey && x > 0 && y == 0)
        Lregion = intim(heighty,x+widthx)-intim(heighty,x)-intim(heighty/2,x+widthx)+intim(heighty/2,x);
        Dregion = intim(heighty/2,x+widthx)-intim(heighty/2,x);
    else
        if (x == 0 && y == 0)
            Lregion = intim(heighty,widthx)-intim(heighty/2,widthx);
            Dregion = intim(heighty/2,widthx);
        elseif (x == 0 && y > 0)
            Lregion = intim(y+heighty,widthx)-intim(y+(heighty/2),widthx);
            Dregion = intim(y+(heighty/2),widthx)-intim(y,widthx);
        elseif (x > 0 && y == 0)
            Lregion = intim(heighty,x+widthx)-intim(heighty,x)-intim(heighty/2,x+widthx)+intim(heighty/2,x);
            Dregion = intim(heighty/2,x+widthx)-intim(heighty/2,x);
        else
            Lregion = intim(y+heighty,x+widthx)-intim(y+heighty,x)-intim(y+(heighty/2),x+widthx)+intim(y+(heighty/2),x);
            Dregion = intim(y+(heighty/2),x+widthx)-intim(y+(heighty/2),x)-intim(y,x+widthx)+intim(y,x);
        end
    end
    value = Lregion-Dregion;


elseif (feature == 3)
    if (widthx == sizex && heighty == sizey && x == 0 && y == 0)
        Lregion1 = intim(heighty,widthx/3);
        Lregion2 = intim(heighty,widthx)-intim(heighty,widthx-(widthx/3));
        Dregion = intim(heighty,widthx-(widthx/3))-intim(heighty,widthx/3);
    elseif (widthx == sizex && heighty == sizey && x == 0 && y > 0)
        Lregion1 = intim(y+heighty,widthx/3)-intim(y,widthx/3);
        Lregion2 = intim(y+heighty,widthx)-intim(y+heighty,widthx-(widthx/3))-intim(y,widthx)+intim(y,widthx-(widthx/3));
        Dregion = intim(y+heighty,widthx-(widthx/3))-intim(y+heighty,widthx/3)-intim(y,widthx-(widthx/3))+intim(y,widthx/3);
    elseif (widthx == sizex && heighty == sizey && x > 0 && y == 0)
        Lregion1 = intim(heighty,x+(widthx/3))-intim(heighty,x);
        Lregion2 = intim(heighty,x+widthx)-intim(heighty,x+(widthx-(widthx/3)));
        Dregion = intim(heighty,x+(widthx-(widthx/3)))-intim(heighty,x+(widthx/3));
    else
        if (x == 0 && y == 0)
            Lregion1 = intim(heighty,widthx/3);
            Lregion2 = intim(heighty,widthx)-intim(heighty,widthx-(widthx/3));
            Dregion = intim(heighty,widthx-(widthx/3))-intim(heighty,widthx/3);
        elseif (x == 0 && y > 0)
            Lregion1 = intim(y+heighty,widthx/3)-intim(y,widthx/3);
            Lregion2 = intim(y+heighty,widthx)-intim(y+heighty,widthx-(widthx/3))-intim(y,widthx)+intim(y,widthx-(widthx/3));
            Dregion = intim(y+heighty,widthx-(widthx/3))-intim(y+heighty,widthx/3)-intim(y,widthx-(widthx/3))+intim(y,widthx/3);
        elseif (x > 0 && y == 0)
            Lregion1 = intim(heighty,x+(widthx/3))-intim(heighty,x);
            Lregion2 = intim(heighty,x+(widthx-(widthx/3)))-intim(heighty,x+(widthx/3));
            Dregion = intim(heighty,x+widthx)-intim(heighty,x+(widthx-(widthx/3)));
        else
            Lregion1 = intim(y+heighty,x+(widthx/3))-intim(y+heighty,x)-intim(y,x+(widthx/3))+intim(y,x);
            Lregion2 = intim(y+heighty,x+widthx)-intim(y+heighty,x+(widthx-(widthx/3)))-intim(y,x+widthx)+intim(y,x+(widthx-(widthx/3)));
            Dregion = intim(y+heighty,x+(widthx-(widthx/3)))-intim(y+heighty,x+(widthx/3))-intim(y,x+(widthx-(widthx/3)))+intim(y,x+(widthx/3));
        end
    end
    value = (Lregion1+Lregion2)-Dregion;
    

elseif (feature == 4)
    if (widthx == sizex && heighty == sizey && x == 0 && y == 0)
        Lregion1 = intim(heighty/3,widthx);
        Lregion2 = intim(heighty,widthx)-intim(heighty-(heighty/3),widthx);
        Dregion = intim(heighty-(heighty/3),widthx)-intim(heighty/3,widthx);
    elseif (widthx == sizex && heighty == sizey && x == 0 && y > 0)
        Lregion1 = intim(y+(heighty/3),widthx)-intim(y,widthx);
        Lregion2 = intim(y+heighty,widthx)-intim(y+(heighty-(heighty/3)),widthx);
        Dregion = intim(y+(heighty-(heighty/3)),widthx)-intim(y+(heighty/3),widthx);
    elseif (widthx == sizex && heighty == sizey && x > 0 && y == 0)
        Lregion1 = intim(heighty/3,x+widthx)-intim(heighty/3,x);
        Lregion2 = intim(heighty,x+widthx)-intim(heighty,x)-intim(heighty-(heighty/3),x+widthx)+intim(heighty-(heighty/3),x);
        Dregion = intim(heighty-(heighty/3),x+widthx)-intim(heighty-(heighty/3),x)-intim(heighty/3,x+widthx)+intim(heighty/3,x);
    else
        if (x == 0 && y == 0)
            Lregion1 = intim(heighty/3,widthx);
            Lregion2 = intim(heighty,widthx)-intim(heighty-(heighty/3),widthx);
            Dregion = intim(heighty-(heighty/3),widthx)-intim(heighty/3,widthx);
        elseif (x == 0 && y > 0)
            Lregion1 = intim(y+(heighty/3),widthx)-intim(y,widthx);
            Lregion2 = intim(y+heighty,widthx)-intim(y+(heighty-(heighty/3)),widthx);
            Dregion = intim(y+(heighty-(heighty/3)),widthx)-intim(y+(heighty/3),widthx);
        elseif (x > 0 && y == 0)
            Lregion1 = intim(heighty/3,x+widthx)-intim(heighty/3,x);
            Lregion2 = intim(heighty,x+widthx)-intim(heighty,x)-intim(heighty-(heighty/3),x+widthx)+intim(heighty-(heighty/3),x);
            Dregion = intim(heighty-(heighty/3),x+widthx)-intim(heighty-(heighty/3),x)-intim(heighty/3,x+widthx)+intim(heighty/3,x);
        else
            Lregion1 = intim(y+(heighty/3),x+widthx)-intim(y+(heighty/3),x)-intim(y,x+(widthx))+intim(y,x);
            Lregion2 = intim(y+heighty,x+widthx)-intim(y+heighty,x)-intim(y+(heighty-(heighty/3)),x+widthx)+intim(y+(heighty-(heighty/3)),x);
            Dregion = intim(y+(heighty-(heighty/3)),x+widthx)-intim(y+(heighty-(heighty/3)),x)-intim(y+(heighty/3),x+widthx)+intim(y+(heighty/3),x);
        end
    end
    value = (Lregion1+Lregion2)-Dregion;

    
elseif (feature == 5)
    if (widthx == sizex && heighty == sizey && x == 0 && y == 0)
        Lregion1 = intim(heighty/2,widthx/2);
        Lregion2 = intim(heighty,widthx)-intim(heighty,widthx/2)-intim(heighty/2,widthx)+intim(heighty/2,widthx/2);
        Dregion1 = intim(heighty/2,widthx)-intim(heighty/2,widthx/2);
        Dregion2 = intim(heighty,widthx/2)-intim(heighty/2,widthx/2);
    elseif (widthx == sizex && heighty == sizey && x == 0 && y > 0)
        Lregion1 = intim(y+(heighty/2),widthx/2)-intim(y,widthx/2);
        Lregion2 = intim(y+heighty,widthx)-intim(y+heighty,widthx/2)-intim(y+(heighty/2),widthx)+intim(y+(heighty/2),widthx/2);
        Dregion1 = intim(y+(heighty/2),widthx)-intim(y+(heighty/2),widthx/2)-intim(y,widthx)+intim(y,widthx/2);
        Dregion2 = intim(y+heighty,widthx/2)-intim(y+(heighty/2),widthx/2);
    elseif (widthx == sizex && heighty == sizey && x > 0 && y == 0)
        Lregion1 = intim(heighty/2,x+(widthx/2))-intim(heighty/2,x);
        Lregion2 = intim(heighty,x+widthx)-intim(heighty,x+(widthx/2))-intim(heighty/2,x+widthx)+intim(heighty/2,x+(widthx/2));
        Dregion1 = intim(heighty/2,x+widthx)-intim(heighty/2,x+(widthx/2));
        Dregion2 = intim(heighty,x+(widthx/2))-intim(heighty,x)-intim(heighty/2,x+(widthx/2))+intim(heighty/2,x);
    else
        if (x == 0 && y == 0)
            Lregion1 = intim(heighty/2,widthx/2);
            Lregion2 = intim(heighty,widthx)-intim(heighty,widthx/2)-intim(heighty/2,widthx)+intim(heighty/2,widthx/2);
            Dregion1 = intim(heighty/2,widthx)-intim(heighty/2,widthx/2);
            Dregion2 = intim(heighty,widthx/2)-intim(heighty/2,widthx/2);
        elseif (x == 0 && y > 0)
            Lregion1 = intim(y+(heighty/2),widthx/2)-intim(y,widthx/2);
            Lregion2 = intim(y+heighty,widthx)-intim(y+heighty,widthx/2)-intim(y+(heighty/2),widthx)+intim(y+(heighty/2),widthx/2);
            Dregion1 = intim(y+(heighty/2),widthx)-intim(y+(heighty/2),widthx/2)-intim(y,widthx)+intim(y,widthx/2);
            Dregion2 = intim(y+heighty,widthx/2)-intim(y+(heighty/2),widthx/2);
        elseif (x > 0 && y == 0)
            Lregion1 = intim(heighty/2,x+(widthx/2))-intim(heighty/2,x);
            Lregion2 = intim(heighty,x+widthx)-intim(heighty,x+(widthx/2))-intim(heighty/2,x+widthx)+intim(heighty/2,x+(widthx/2));
            Dregion1 = intim(heighty/2,x+widthx)-intim(heighty/2,x+(widthx/2));
            Dregion2 = intim(heighty,x+(widthx/2))-intim(heighty,x)-intim(heighty/2,x+(widthx/2))+intim(heighty/2,x);
        else
            Lregion1 = intim(y+(heighty/2),x+(widthx/2))-intim(y+(heighty/2),x)-intim(y,x+(widthx/2))+intim(y,x);
            Lregion2 = intim(y+heighty,x+widthx)-intim(y+heighty,x+(widthx/2))-intim(y+(heighty/2),x+widthx)+intim(y+(heighty/2),x+(widthx/2));
            Dregion1 = intim(y+(heighty/2),x+widthx)-intim(y+(heighty/2),x+(widthx/2))-intim(y,x+widthx)+intim(y,x+(widthx/2));
            Dregion2 = intim(y+heighty,x+(widthx/2))-intim(y+heighty,x)-intim(y+(heighty/2),x+(widthx/2))+intim(y+(heighty/2),x);
        end
    end
    value = (Lregion1+Lregion2)-(Dregion1+Dregion2);
end
            
            
            
            
            
        
        
        