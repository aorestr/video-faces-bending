function pyrG = gaussian_pyramid(im, levels)
% GAUSSIAN_PYRAMID creates a gaussian pyramid
%   PYRG = GAUSSIAN_PYRAMID(IM, LEVELS) creates a Gaussian pyramid through
%   IM

% Create structure. Has LEVELS+1 cells for the base level and the rest
% of the levels that are requested
pyrG = cell(1,levels+1);
% Base level is the original img
pyrG{1} = im;
% The rest are the pyramid
for i=2:levels+1
    pyrG{i} = impyramid(pyrG{i-1},'reduce');
end


