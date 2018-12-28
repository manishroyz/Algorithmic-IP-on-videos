function [C,V] = CS6640_GC(im)
% CS6640_GC - Graph Cut segmentation
% On input:
%     im (MxN array): input image
% On output:
%     C (MxN array): binary classification
%     V (M*Nx6 array): eigenvectors of similarity matrix
% Call:
%     [C,V] = CS6640_GC(im);
% Author:
%     Manish Roy
%     UU
%     Fall 2018
% 

[M,N] = size(im);
im_v = im(:);
n = length(im_v);

S = zeros(n,n);

for i = 1:n
    for j = 1:n
        S(i,j) = exp(-abs(im_v(i)-im_v(j)));
%         S(i,j) = 1/(1+abs(im_v(i)-im_v(j)));
    end
end

% imshow(S);

[V,D] = eigs(S);

C = kmeans(V(:,1),2);
C = reshape(C,[M,N]);



end

