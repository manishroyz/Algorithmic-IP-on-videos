function H_im = CS6640_Harris(im)
% CS6640_Harris - compute Harris operator at each pixel
% On input:
%     im (MxN array): graylevel image
% On output:
%     H_im (MxN array): Harris value (normalized)
% Call:
%     H = CS6640_Harris(im);
% Author:
%     Manish Roy
%     UU
%     Fall 2018
%

% Find first gradient
[dx,dy] = gradient(double(im));

% Find second gradients
[dxx,dxy] = gradient(dx);
[dyx,dyy] = gradient(dy);

%Pre-allocate size for speed
H_im = zeros(size(im,1), size(im,2));

%Calculate Harris at each pixel
for row = 1:size(im,1)
    for col = 1:size(im,2)
        H = [ dxx(row,col), dxy(row,col); dyx(row,col), dyy(row,col)];
        H_im(row,col) = det(H) - 0.05*trace(H)^2;
    end
end

