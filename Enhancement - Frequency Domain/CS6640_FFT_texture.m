function T = CS6640_FFT_texture(im)
% CS6640_FFT_texture - compute FFT texture parameters
% On input:
%       im (MxN array): input image
% On output:
%       T (M*Nx25 array): texture parameters
%       each texture parameter is a column vector in T
% Call:
%       T = CS6640_FFT_texture(im);
% Author:
%       Manish Roy
%       UU 
%       Fall 2018
%

%---NOTE: Windows are anly used if they fit completely inside the image.
%---Therefore, the texture feature vector for the edge pixels is assumed to
%---be zero.

[M, N] = size(im); % Get number of rows and columns
T = zeros(M*N, 25); % Preallocate output texture matrix

for r = 3:M-2
    for c = 3:N-2
        f = double(im(r-2:r+2, c-2:c+2)); % Isolate a 5x5 sector
        F = fft2(f); % Compute the 2D-DFT of the sector
        F = abs(F); % Power spectrum is found using the complex modulus
        % Pack the result into the output texture matrix. Note that the
        % texture matrix is stacked by columns (i.e. the first rows are for
        % column one, then for column two etc.)
        T(r+(c-1)*M, :) = F(:)';
    end
end