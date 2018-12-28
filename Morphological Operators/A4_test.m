function A4_test
%

vidObj = VideoReader('video3.avi');
M = CS6640_MM(vidObj);
figure(1);
input('Go?');
clf
movie(M);

vidObj = VideoReader('video3.avi');
objs = CS6640_object_data(M,vidObj);

num_frames = length(objs);
tr = [];
for f = 1:num_frames
    if objs(f).num_objects>0
        tr = [tr; objs(f).objects(1).col_mean,641-objs(f).objects(1).row_mean];
    end
end

figure(2)
clf
plot(tr(:,1),tr(:,2),'ro');
axis equal
input('Go?');
tch = 0;
