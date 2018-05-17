function im = reconstruct(pyrL)
% RECONSTRUCT reconstruct the image thanks to its Laplacian pyramid
%   IM = RECONSTRUCT(PYRL) 

levels = size(pyrL,2);
% Initial estimation of the image at last level of the pyramid
im = pyrL{levels};
% For the rest of levels
for i=levels-1:-1:1
    % Expand
    aux = impyramid(im,'expand');
    % Adjust the sizeajustamos el tama�o
    aux = padarray(aux, size(pyrL{i})-size(aux), 'replicate', 'post');
    % Sum details
    im = aux + pyrL{i};
end


