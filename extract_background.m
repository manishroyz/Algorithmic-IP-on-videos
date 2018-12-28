function im = extract_background(video)
% CS6640_background - extract background image from video sequence
% On input:
%     video (video data structure): video sequence of k MxNx3 images
% On output:
%     im (MxN array): image
% Call:
%     im = CS4640_background(v);
% Author:
%     Manish Roy
%     UU
%     Fall 2018
%

num_frames = 0;
video.CurrentTime = 0;
while hasFrame(video)
    num_frames = num_frames + 1;
    vidFrame = readFrame(video);
    [M,N,P] = size(vidFrame);
end

avg = zeros(M,N,P);
video.CurrentTime = 0;
while hasFrame(video)
    num_frames = num_frames + 1;
    vidFrame = readFrame(video);
    avg(:,:,1) = avg(:,:,1) + double(vidFrame(:,:,1))/num_frames;    
    avg(:,:,2) = avg(:,:,2) + double(vidFrame(:,:,2))/num_frames;    
    avg(:,:,3) = avg(:,:,3) + double(vidFrame(:,:,3))/num_frames;    
end
imr = mat2gray(avg(:,:,1));
img = mat2gray(avg(:,:,2));
imb = mat2gray(avg(:,:,3));
im(:,:,1) = imr;
im(:,:,2) = img;
im(:,:,3) = imb;
im = rgb2gray(im);
tch = 0;
