function [localMins1D,min_inds] = CS6640_findMins1D(array)
% CS6640_findMins1D - finds local mins of a 1D array of data
% On input:
%    array (Nx1 double): input array
% On output:
%    localMins1D (kx1 double): local mins in array
%    min_inds    (kx1 int): indices of mins in array
% Call:
%    [localMins1D,min_inds] = CS6640_findMins1D(array)
% Author:
%    Manish Roy
%    Fall 2018
%    u0946530
%
localMins1D = [];min_inds = [];
for i = 2:length(array) - 1
    if(array(i) <= array(i-1) && array(i) <= array(i+1))
        localMins1D = [localMins1D,array(i)];
        min_inds = [min_inds,i];
    end
end

end