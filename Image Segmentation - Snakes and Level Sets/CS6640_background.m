function background_im = CS6640_background(video_OBJ)

f = 1;
while hasFrame(video_OBJ)
    frame = double(rgb2gray(readFrame(video_OBJ)));
    vidMatrix(:,:,f) = frame;
    f = f+1;
end
frame = vidMatrix(:,:,1);
[M,N] = size(frame);


for x = 1:M
    for y = 1:N
        pixel(x,y) = median(sort(vidMatrix(x,y,:)));
    end
end
background_im = pixel;
end