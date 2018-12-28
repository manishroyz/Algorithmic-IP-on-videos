function altered_mask = CS6640_alterMask(M,SE,string_)
% CS6640_alterMask - performs operations on movie object frames
% On input:
%    M (Matlab movie struct): segmentation movie (binary)
%    SE (Stucturing element): created using matlab function "strel"
%       (type 'help strel' in command window to learn this)
%    string ('dilate' or 'erode' are only valid inputs)
% On output:
%    altered_mask (Matlab movie struct): mask after alterations (erode,
%    dilate, etc.)
% Call:
%    altered_mask = CS6640_alterMask(M)
% Author:
%    Manish Roy
%    UU
%    Fall 2018
%
stSize = length(M);
altered_mask = struct('cdata', stSize, 'colormap', stSize);

if(strcmp(string_,'dilate'))
for f = 1:stSize
    m_temp = double(M(f).cdata(:,:,1))./255;
    mask = imdilate(m_temp,SE);
    altered_mask(f).cdata = 255 * uint8(cat(3, mask, mask, mask));
end
end

if(strcmp(string_,'erode'))
for f = 1:stSize
    m_temp = double(M(f).cdata(:,:,1))./255;
    mask = imerode(m_temp,SE);
    altered_mask(f).cdata = 255 * uint8(cat(3, mask, mask, mask));
end
end

if(strcmp(string_,'boundary'))
for f = 1:stSize
    m_temp = bwmorph(double(M(f).cdata(:,:,1))./255,'remove');
    mask = m_temp;
    altered_mask(f).cdata = 255 * uint8(cat(3, mask, mask, mask));
end
end

end