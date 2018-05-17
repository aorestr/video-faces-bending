function new_frame = apply_mix(img,mask,frame)

% Number of levels of the Laplacian pyramid
pyr_levels = floor(log2(min(size(frame(:,:,1)))));
% Laplacian pyramid for images
ApyrL = laplacian_pyramid(frame,pyr_levels);
BpyrL = laplacian_pyramid(img,pyr_levels);
% Gaussian pyramid for the mask
MpyrG = gaussian_pyramid(mask,pyr_levels);
% Result for every step
respyr = cell(1,5);
% Return the new image
for i = 1:length(ApyrL)
    respyr{i} = ApyrL{i} .* (1-MpyrG{i}) + BpyrL{i} .* MpyrG{i};
end
new_frame = reconstruct(respyr);

end