function im = CS6640_background(video)
% CS6640_background - extract background image from video sequence
% On input:
%       video (video data structure): video sequence of k MxNx3 images
% On output:
%       im (MxN array): image
% Call:
%       im = CS4640_background(v);
% Author:
%       Manish Roy
%       UU 
%       Fall 2018
%

% Extract relevant info on the video
frames = video.FrameRate*video.Duration;   % number of frames
rows = video.Height;                       % pixel rows
cols = video.Width;                        % pixel columns

% Extract the frames from the video into the cell array 'vidFrames'
vidFrames = cell(frames);
i = 0;
while hasFrame(video)
    i = i + 1;
    vidFrames{i} = readFrame(video);
end
% Reset video reader to the beginning
video.CurrentTime = 0;

% Preallocate backround image memory
im = zeros(rows, cols, 3, 'uint8');

% Iterate though each pixel and compute temporal average
for r = 1:rows
    for c = 1:cols
        for ch = 1:3
            sum = 0;
            for k = 1:frames
                sum = sum + double(vidFrames{k}(r, c, ch));
            end
            im(r, c, ch) = sum / frames;
        end
    end
end








