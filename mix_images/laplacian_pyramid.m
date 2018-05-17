function pyrL = laplacian_pyramid(im, levels)
% LAPLACIAN_PYRAMID creates a Laplacian pyramid
%   PYRL = LAPLACIAN_PYRAMID(IM, LEVELS) creates a Laplacian pyramid through
%   IM

% Creates Gaussian pyramid
pyrG = gaussian_pyramid(im, levels);
% Structure for the Laplacian pyramid
pyrL = cell(1,levels+1);
% Pyramid's highest level is the same as the Gaussian pyramid's
pyrL{levels+1} = pyrG{levels+1};
% For the rest of the levels
for i=levels:-1:1
    % Expand
    aux = impyramid(pyrG{i+1},'expand');
    % Adjust size
    aux = padarray(aux, size(pyrG{i})-size(aux), 'replicate', 'post');
    % Substract for details
    pyrL{i} = pyrG{i}-aux;
end

