function object_data = CS6640_object_data(M,vidObj)
%
% On input:
%       M (Matlab movie): movie of segmented moving objects
%       vidObj (video object obtained by VideoReader): input video
% On output:
%       object_data (struct vector): object data
%         (k).num_objects (int): number of objects in frame k
%         (k).objects (struct vector): has features for each object (p)
%           objects(p).row_mean (float): row mean
%           objects(p).col_mean (float): column mean
%           objects(p).ul_row (int): upper left row for bounding box
%           objects(p).ul_col (int): upper left col for bounding box
%           objects(p).lr_row (int): lower right row for bounding box
%           objects(p).lr_col (int): lower right col for bounding box
%           objects(p).num_pixels (int): number of pixels
%           objects(p).red_median (int): median red value for object
%           objects(p).green_median (int): median green value for object
%           objects(p).blue_median (int): median blue value for object
% Call:
%       obj_data = CS6640_object_data(M,vidObj);
% Author:
%       Manish Roy
%       UU 
%       Fall 2018
%

% Allocate struct vector
numFrames = vidObj.Duration*vidObj.FrameRate;
stSize = cell(1, numFrames);
object_data = struct('num_objects', stSize, 'objects', stSize);

% Process each image
i = 0;
vidObj.CurrentTime = 0; % Make sure video object is at the beginning
while hasFrame(vidObj)
    i = i + 1;
    rgbFrame = readFrame(vidObj);
    redFrame = rgbFrame(:, :, 1);
    greenFrame = rgbFrame(:, :, 2);
    blueFrame = rgbFrame(:, :, 3);
    segFrame = boolean(mat2gray(rgb2gray(M(i).cdata)));
    
    stats = regionprops(segFrame, 'Area', 'Centroid', 'PixelList');
    p = size(stats, 1);
    object_data(i).num_objects = p;
    stsize = cell(1, p);
    objs = struct('row_mean', stsize, 'col_mean', stsize, ...
                  'ul_row', stsize, 'ul_col', stsize, ...
                  'lr_row', stsize, 'lr_col', stsize, ...
                  'num_pixels', stsize, 'red_median', stsize, ...
                  'green_median', stsize, 'blue_median', stsize);
    
    for o = 1:p
        s = stats(o);
        objs(o).col_mean = s.Centroid(1);
        objs(o).row_mean = s.Centroid(2);
        objs(o).ul_col = min(s.PixelList(:,1));
        objs(o).ul_row = min(s.PixelList(:,2));
        objs(o).lr_col = max(s.PixelList(:,1));
        objs(o).lr_row = max(s.PixelList(:,2));
        objs(o).num_pixels = s.Area;
        
        index = boolean(zeros(vidObj.Height, vidObj.Width));
        for j = 1:s.Area
            index(s.PixelList(j, 2), s.PixelList(j, 1)) = 1;
        end
        objs(o).red_median = median(redFrame(index));
        objs(o).green_median = median(greenFrame(index));
        objs(o).blue_median = median(blueFrame(index));
    end
    
    object_data(i).objects = objs;
    
end

% Reset video reader to the beginning
vidObj.CurrentTime = 0;
