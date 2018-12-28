function M = CS6640_MM(vidObj)
% CS6640_MM - segments moving objects in video
% On input:
%       vidObj (video object obtained by VideoReader): input video
% On output:
%       M (Matlab movie): movie of segmented moving objects
% Call:
%       vidObj = VideoReader(’../../../video.avi’);
%       M = CS6640_MM(vidObj);
% Author:
%       Manish Roy
%       UU 
%       Fall 2018
%

% Prepare Matlab movie
numFrames = vidObj.Duration*vidObj.FrameRate;
stSize = cell(1, numFrames);
M = struct('cdata', stSize, 'colormap', stSize);

% Compute the background of the video
bg = histeq(rgb2gray(CS6640_background(vidObj)));
bg = imgaussfilt(bg,1);

% Compute the binary frames representing moving objects
% prevFrame = zeros(vidObj.Height, vidObj.Width);
i = 0;
while hasFrame(vidObj)
    i = i + 1;
    f = readFrame(vidObj);
    frame = rgb2gray(f);
    frame = histeq(frame);
    frame = imgaussfilt(histeq(frame),1);
    
    % Remove the background to find moving elements
%     diff = mat2gray(abs(double(frame) - double(bg)));
    diff = abs(double(frame) - double(bg));
%     diff = mat2gray(abs(double(frame) - double(prevFrame)));
%     prevFrame = frame;

    % Segment moving objects
    bwdiff = imbinarize(diff, 60);
    bwdiff = imclose(bwdiff, strel('square',8));
    bwdiff = imopen(bwdiff, strel('square',1));
    
    % Put in MATLAB movie
%     M(i).cdata = uint8(255 * cat(3, diff, diff, diff));
%     M(i).cdata = combo(f, bwdiff);
    M(i).cdata = uint8(255 * cat(3, bwdiff, bwdiff, bwdiff));

end

% Reset video reader to the beginning
vidObj.CurrentTime = 0;

