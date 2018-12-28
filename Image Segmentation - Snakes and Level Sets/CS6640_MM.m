function M = CS6640_MM(vidObj)
% CS6640_MM - segments moving objects in video
% On input:
%    vidObj (video object obtained by VideoReader): input video
% On output:
%    M (Matlab movie): movie of segmented moving objects
% Call:
%    vidObj = VideoReader(?../../../video.avi?);
%    M = CS6640_MM(vidObj);
% Author:
%    Manish Roy
%    Fall 2018
%    u0946530
%
f = 1; % preliminary allocation of f
time_begin = vidObj.CurrentTime; % remember start time of video
BG = CS6640_background(vidObj); % compute background of video
vidObj.CurrentTime = 0; % reset video start
[M_,N_] = size(BG);

SE = strel('square',5);
numFrames = vidObj.Duration*vidObj.FrameRate;
threshold = 0.05;
filtSize = 10;
stSize = cell(1, numFrames);
iter = 0;
M = struct('cdata', stSize, 'colormap', stSize);
while hasFrame(vidObj)
    currentFrame = readFrame(vidObj);
    currentFrame = rgb2gray(currentFrame);
    currentFrame = double(currentFrame);
    diff = abs(BG - currentFrame);
    gamma = 0.15;
    diff = (diff./max(max(diff))).^gamma;

    H = figure;hold on;set(H,'visible','off')
    hist_Fit = histfit(diff(:),30,'kernel');hold off;
    yData = hist_Fit(1).YData;
    xData = hist_Fit(1).XData;
    close(H);
    xData(yData > 500) = [];
    yData(yData > 500) = [];
    if ismember(0,yData)
        xData(yData == 0) = [];
        yData(yData == 0) = [];
    end
    [localMins1D,min_inds] = CS6640_findMins1D(yData);
    if isempty(min_inds)
        threshold = 0.8;
    else
        threshold = xData(min_inds(1));
    end
    
    diff(diff < threshold) = 0;diff(diff >= threshold) = 1;
    obj_struct = bwconncomp(diff);
    mask = zeros(M_,N_);
    for i = 1:length(obj_struct.PixelIdxList)
        if(length(obj_struct.PixelIdxList{i}) >= 40)
            mask(obj_struct.PixelIdxList{i}) = 1;
        end
    end
    mask = imdilate(mask,strel('disk',5));
    mask = imerode(mask,strel('disk',5));
    
    
%     NHOOD = [1 1 1];
%     SE = strel('diamond',2);
%     diff = imerode(diff,SE);
%     diff = imdilate(diff,SE);
%     diff = imdilate(diff,strel('disk',2));

    
    M(f).cdata = 255 * uint8(cat(3, mask, mask, mask));
    f = f+1;
end

end