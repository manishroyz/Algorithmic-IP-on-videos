function im_seg = CS6640_ac(M,vidObj)
% CS6640_ac - use active contours to improve segmentation
% On input:
%    M (Matlab movie struct): segmentation movie (binary)
%    vidObj (video struct): created by readVideo
% On output:
%    im_seg (MxNxF binary array): improved segmentation provided as
%      sequence of F images
% Call:
%    vidObj = VideoReader(?../../../A4/video3.avi?);
%    ims = CS6640_ac(M,vidObj);
% Author:
%    Manish Roy
%    UU
%    Fall 2018
%
vidObj.CurrentTime = 0;
f_temp = readFrame(vidObj);
[M_,N_] = size(f_temp(:,:,1));
vidObj.CurrentTime = 0;
numFrames = vidObj.Duration*vidObj.FrameRate;
im_seg = zeros(M_,N_,numFrames);
f = 1;
while hasFrame(vidObj)
    A = readFrame(vidObj);
    mask = double(M(f).cdata(:,:,1))./255;
    imsegtemp = activecontour(rgb2gray(A),mask,'edge');
    im_seg(:,:,f) = imsegtemp;
    f = f+1;
end
end