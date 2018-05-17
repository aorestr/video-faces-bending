function new_frame =  read_new_frame(video)
% READ_NEW_FRAME Read a frame from a video and extract it both in B&W and
% in color
%   [NEW_FRAME] = READ_NEW_FRAME(VIDEO) reads the video and
%   extract next not-read frame
new_frame = im2double(readFrame(video));

end