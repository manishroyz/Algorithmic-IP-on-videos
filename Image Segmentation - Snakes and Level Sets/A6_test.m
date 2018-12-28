function A6_test
%

%load M1
%vidObj = VideoReader('video1.avi');
%im_seg = CS6640_ac(M1,vidObj);
%[M,N,F] = size(im_seg);
%figure(1);
%clf
%for f = 1:F
%    imshow(im_seg(:,:,f);
%end

%input('Go?');

load MM
vidObj = VideoReader('MM.avi');
im_seg = CS6640_ac(M,vidObj);
[M,N,F] = size(im_seg);
figure(1);
clf
for f = 1:F
    imshow(mat2gray(im_seg(:,:,f)));
end
input('Go?');

A = zeros(21,21);
A(7:13,7:13) = 100;
[phi,tr] = CS6640_level_set(A,50,0.1,10,10);
figure(1);
clf
combo(A,phi<0);
input('Go?');

[phi,tr] = CS6640_level_set(A,200,0.1,4,4);
combo(A,phi<0);
input('Go?');
