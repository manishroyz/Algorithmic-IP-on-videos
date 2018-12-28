function T = CS6640_Laws(im)
% CS6640_Laws - compute texture parameters
% On input:
%     im (MxN array): input image
% On output:
%     T (M*Nx10 array): texture parameters
%       each texture parameter is a column vector in T
% Call:
%     T = CS6640_Laws(im);
% Author:
%     Manish Roy
%     UU
% Fall 2018
%

%% 1x7 Filters
L7 = [1 6 15 20 16 6 1];
E7 = [-1 -4 -5 0 5 4 1];
s7 = [-1 -2 1 4 1 -2 -1];
W7 = [-1 0 3 0 -3 0 1];
R7 = [1 -2 -1 4 -1 -2 1];
O7 = [-1 6 -15 20 -15 6 -1];

%% Generate texture filters
f1_L7L7 = L7' * L7;
f2_L7E7 = L7' * E7;
f3_L7S7 = L7' * s7;
f4_L7W7 = L7' * W7;
f5_L7R7 = L7' * R7;
f6_L7O7 = L7' * O7;
f7_E7E7 = E7' * E7;
f8_W7R7 = W7' * R7;
f9_W7O7 = W7' * O7;
f10_mean = fspecial('average',7);

fmean7 = fspecial('average',7);
s1 = conv2(abs(conv2(im, f1_L7L7, 'same')),fmean7, 'same');
s2 = conv2(abs(conv2(im, f2_L7E7, 'same')),fmean7, 'same');
s3 = conv2(abs(conv2(im, f3_L7S7, 'same')),fmean7, 'same');
s4 = conv2(abs(conv2(im, f4_L7W7, 'same')),fmean7, 'same');
s5 = conv2(abs(conv2(im, f5_L7R7, 'same')),fmean7, 'same');
s6 = conv2(abs(conv2(im, f6_L7O7, 'same')),fmean7, 'same');
s7 = conv2(abs(conv2(im, f7_E7E7, 'same')),fmean7, 'same');
s8 = conv2(abs(conv2(im, f8_W7R7, 'same')),fmean7, 'same');
s9 = conv2(abs(conv2(im, f9_W7O7, 'same')),fmean7, 'same');
s10 = conv2(abs(conv2(im, f10_mean, 'same')),fmean7, 'same');

T=[s1(:) s2(:) s3(:) s4(:) s5(:) ...
   s6(:) s7(:) s8(:) s9(:) s10(:)];

