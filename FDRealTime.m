% The purpose of this script is to use some of the classifiers to detect
% faces real time use the device's webcam
clc

% assign a variable to the deafult webcam
cam = webcam;
% start the preview of the cam
preview(cam)
% assign a variable a dialog box asking the user to continue or exit
buttonpressed = questdlg("Exit?","Do you want to quit","Continue","Exit",'options');
% if user presses exit then close the cam
if contains(buttonpressed,'Exit','IgnoreCase',true)
    clear cam
else
    % while the user has not presses exit continue with the script
    while ~contains(buttonpressed,'Exit','IgnoreCase',true)
        % the below code follows the same process as the FDImage script
        photo = snapshot(cam);
        greyscalephoto = im2gray(photo);
        imshow(greyscalephoto)
        [nrows,ncols] = size(greyscalephoto);
        f = 0;
        stel = 230;
        stes = 92;
        numcr = 10;
        % assign a variable false which represents if it has reached the
        % end in which case it would be changed to true
        rend = 0;
        
        if (nrows > 1000 && ncols > 1000)
            stes = 345;
            stel = 460;
            numcr = 14;
        end
        
        tic;
        % show a messagebox showing the user that its loading 
        show = msgbox("Loading","Result");
        for i = 23:stes:nrows
            for j = 23:stes:ncols
                for y = 1:stel:nrows-i
                    for x = 1:stel:ncols-j
                        subwindow = greyscalephoto(y:y+i,x:x+j);
                        subwindow = imresize(subwindow,[24,24]);
                        intim = IntegralImage(single(subwindow));
                        for k = 1:numcr
                            features = single(zeros(1,length(AllCR{k})));
                            features = ReqVar(features,intim,1,AllCR{k});
                            FClassifier = LoadClass(k);
                            if ~(predict(FClassifier,features) == "face")
                                break;
                            end
                            if k == numcr
                                f = f+1;
                            end
                        end
                    end
                end
            end
        end
        % once this line is reached delete the messagebox variable
        delete(show);
        time = toc
        
        % if face detect variable (f in this case) is greater than one
        % show a messagebox informing that a face is detected
        if f > 1
            msgbox("Face Detected!", "Result");
        else
            msgbox("Face not detected","Result");
        end
        
        % ask the user again if they want to continue or exit 
        buttonpressed = questdlg("Exit?","Do you want to quit","Continue","Exit",'options');
        if contains(buttonpressed,'Exit','IgnoreCase',true)
            clear cam
        else
        end
    end
end
        
