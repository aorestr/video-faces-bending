function position = getROI(img)
% GETROI extract a rectangular region of interest (ROI) in an image
%
% POSITION = GETROI(IMG) shows IMG in a figure and let select a rectangular region.
% Returns the region as [x y width heigth].
% In order to select, click twice
% In order to cancel the action, press Esc. The ROI will be then the whole picture

% Show the picture
f = figure; 
imshow(img);

X = get(gca,'XLim');
Y = get(gca,'YLim');

limites = round([X(1), Y(1), X(2)-X(1), Y(2)-Y(1)]);
% Initial ROI is a rectangle of the size the half of the picture, located
% at its center
roi = round([limites(1)+limites(3)/4 limites(2)+limites(4)/4 limites(3)/2 limites(4)/2]);
% Show current coordinates
title(mat2str(roi,3))

% Select rectangle
h = imrect(gca, roi);
addNewPositionCallback(h,@(p) title(mat2str(p,3)));
fcn = makeConstrainToRectFcn('imrect',X,Y);
setPositionConstraintFcn(h,fcn); 

% Wait for the selection to make
position = wait(h);
% If it's empty...
if isempty(position) 
    % The whole picture will be the ROI
    position = limites;
end

% Close figure
if isvalid(f)
    close(f);
end

end