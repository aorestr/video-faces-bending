clc
clear all
close all

%% First declarations
% Add folders to the workspace
addpath('.\follow_frames', '.\mix_images');
% Read the video
filename = 'videoplayback.avi';
video = VideoReader(filename);
new_frame = read_new_frame(video);
% Images, mask and Trump pic
mask = im2double(imread('imgs\videoplayback_mask.png'));
trump = im2double(imread('imgs\trump.jpg'));
% In case we want to save the video
% in a file
save_video = true;
if save_video
    new_vid_name = 'new_video';
    new_vid = VideoWriter(new_vid_name, 'MPEG-4'); new_vid.FrameRate=20;
    open(new_vid);
end
% Select the block we will follow
ROI = round(getROI(new_frame));
% And the pixel range within we will search
range = [30 20];

%% Read every frame
while hasFrame(video)
    
    % Mix pictures
    new_mix = (apply_mix(trump,mask,new_frame));
    
    % Read new frame
    old_frame = new_frame;
    new_frame = read_new_frame(video);
    
    % Calculate the movement vector for the 
    movement_vector = minSAD(new_frame, old_frame, ROI, range);
    
    % Update the position of the face
    trump = imtranslate(trump, movement_vector, 'linear');
    mask = imtranslate(mask, movement_vector, 'linear');
    
    % Shift ROI following the vector
    ROI(1) = ROI(1) + movement_vector(1);
    ROI(2) = ROI(2) + movement_vector(2);
    
    % Let's show the results!
    imshow(new_mix);
    if save_video
        try
            writeVideo(new_vid,new_mix);
        catch
            new_mix(new_mix < 0) = 0; new_mix(new_mix > 1) = 1;
            writeVideo(new_vid,new_mix);
        end
    end
end
% Close the recording
if save_video
    close(new_vid);
end
