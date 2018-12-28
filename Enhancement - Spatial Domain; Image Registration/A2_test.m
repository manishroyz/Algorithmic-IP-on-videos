function res = A2_test
%

load img
T = CS6640_Laws(img);
[cidx,ctrs] = kmeans(T,4);
combo(mat2gray(img),reshape(cidx==1,480,640));
input('Laws 1:');
combo(mat2gray(img),reshape(cidx==2,480,640));
input('Laws 2:');
combo(mat2gray(img),reshape(cidx==3,480,640));
input('Laws 3:');
combo(mat2gray(img),reshape(cidx==4,480,640));
input('Laws 4:');

im = zeros(51,51);
im(13:37,13:37) = 100;
H = CS6640_Harris(im);
surf(H);
input('Harris');

%im20 = imrotate(im,20); 
%cpts = [37,13; 41,18; 37,25; 37,31; 37,37; 33,41; 13,37;...
%    11,33; 13,25; 15,21; 13,13; 19,10];

pts = [20,10; 35,15; 40,25; 30,40; 15,30; 10,20];
T = [cos(20*pi/180) -sin(20*pi/180) 0;...
    sin(20*pi/180) cos(20*pi/180), 0; 0,0,1];
pts2 = (T*[pts,ones(6,1)]')';
pts2 = pts2(:,1:2);
cpts = [pts(1,:);pts2(1,:);pts(2,:);pts2(2,:);pts(3,:);pts2(3,:);...
    pts(4,:);pts2(4,:);pts(5,:);pts2(5,:);pts(6,:);pts2(6,:)];
cpid = [pts(1,:);pts(1,:);pts(2,:);pts(2,:);pts(3,:);pts(3,:);...
    pts(4,:);pts(4,:);pts(5,:);pts(5,:);pts(6,:);pts(6,:)];
[imr,q,A] = CS6640_register(im,1,cpts);
q
imshow(imr);
input('register quadratic:');

imshow(imr);
[imr,q,A] = CS6640_register(im,0,cpts);
A

imshow(imr);
input('register affine');

vidObj = VideoReader('../../../video.avi');
[M,tr] = CS6640_track(vidObj);
imt = zeros(480,640);
for t = 1:length(tr(:,1))
    r = max(1,floor(tr(t,1)));
    c = max(1,floor(tr(t,2)));
    imt(r,c) = 1;
end
combo(mat2gray(img),bwmorph(imt,'dilate',2));
input('track');

tch = 0;