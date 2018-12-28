
function [M,tracks] = CS6640_track(video)
% CS6640_track - track motion in a video
% On input:
%     video (video structure): input video
% On output:
%       M (movie structure): movie of detected differences
%           in video
%       tracks (kx2 array): row,col center of mass of largest
%           moving object in sequential video frames
% Call:
%     [M,tr] = CS6640_track(video);
% Author:
%     Manish Roy
%     UU
%     Fall 2018
%

k=1;

% Intensity threshold for establishing movement
threshold = 40;
while hasFrame(video)
    vidFrame = double(rgb2gray(readFrame(video)));

    % Initialize frames first time through
    if k==1
        im = vidFrame;
        im_subtract = im;
        ROW = size(vidFrame,1);
        COL = size(vidFrame,2);
        im_tracks = zeros(ROW, COL);
    else
        % Find movement by checking sequential frames
        im_subtract = vidFrame - im_last;
    end
    
    % Save current image for next procesing loop
    im_last = vidFrame;
    
    % capture movement and use a threshold to filter small variances
    im_movement = im_subtract > threshold;
    
    % Get index of highest value
    [~, idx] = max(im_subtract(:));
    [row_idx, col_idx] = ind2sub(size(im_subtract),idx);
    tracks(k,:) = [row_idx, col_idx];
    
    % Initialize mask image for tracking moving object
    im_mask = zeros(ROW, COL);
    
    %size of mask to put on top of moving object
    mask_size = 8;
    
    %Generate row mask, protect against 0 and bounds
    if (row_idx - mask_size < 1)
        row_mask_start = 1;
    else
        row_mask_start = row_idx - mask_size;
    end
    if (row_idx + mask_size > ROW)
        row_mask_end = ROW;
    else
        row_mask_end = row_idx + mask_size;
    end
    
    %Generate col mask, protect against 0 and bounds
    if ((col_idx - mask_size) < 1)
        col_mask_start = 1;
    else
        col_mask_start = col_idx - mask_size;
    end
    if (col_idx + mask_size > COL)
        col_mask_end = COL;
    else
        col_mask_end = col_idx + mask_size;
    end
    
    % Set the mask
    im_mask(row_mask_start:1:row_mask_end, ...
        col_mask_start:1:col_mask_end) = 1;
    
%     % create track image
%     im_tracks = or(im_tracks, im_mask);
%     
%     % Show instantaneouw mask over moving object
%     figure(2);
%     combo(mat2gray(vidFrame), im_mask==1);
            
    % Capture video
    figure(1);
    imshow(im_movement);
    M(k) = getframe(gca);

    k = k+1;
end

% % Overlay track on image for report
% figure(3);
% combo(mat2gray(vidFrame), im_tracks==1);

end

