function A3_test(H,O,Hr)
%

load img

img = imresize(img,[200,200]);
[M,N] = size(img);

T = CS6640_FFT_texture(img);
[cidx,ctrs] = kmeans(T,4);
clf
combo(mat2gray(img),reshape(cidx==1,M,N));
input('Go?');
combo(mat2gray(img),reshape(cidx==2,M,N));
input('Go?');
combo(mat2gray(img),reshape(cidx==3,M,N));
input('Go?');
combo(mat2gray(img),reshape(cidx==4,M,N));
input('Go?');

T = CS6640_FFT_radial(img);
[cidx,ctrs] = kmeans(T,4);
combo(mat2gray(img),reshape(cidx==1,M,N));
input('Go?');
combo(mat2gray(img),reshape(cidx==2,M,N));
input('Go?');
combo(mat2gray(img),reshape(cidx==3,M,N));
input('Go?');
combo(mat2gray(img),reshape(cidx==4,M,N));
input('Go?');

T = CS6640_FFT_angular(img);
[cidx,ctrs] = kmeans(T,4);
combo(mat2gray(img),reshape(cidx==1,M,N));
input('Go?');
combo(mat2gray(img),reshape(cidx==2,M,N));
input('Go?');
combo(mat2gray(img),reshape(cidx==3,M,N));
input('Go?');
combo(mat2gray(img),reshape(cidx==4,M,N));
input('Go?');

XH = CS6640_FFT_shape(H,1);
XHr = CS6640_FFT_shape(Hr,1);
XO = CS6640_FFT_shape(O,1);
clf
plot(XH);
hold on
plot(XHr,'g');
plot(XO,'r');
