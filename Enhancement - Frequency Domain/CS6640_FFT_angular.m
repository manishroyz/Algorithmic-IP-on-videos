function T = CS6640_FFT_angular(im)
% CS6640_FFT_angular - compute FFT angular texture parameters
% On input:
%       im (MxN array): input image
% On output:
%       T (M*Nx8 array): texture parameters
%       each texture parameter is a column vector in T
% Call:
%       T = CS6640_FFT_angular(im);
% Author:
%       Manish Roy
%       UU 
%       Fall 2018
%

[M, N] = size(im); % Get number of rows and columns
s = 3; % Size of window 2s-1 x 2s-1 (must be odd)
T = zeros(M*N, 8); % Preallocate output texture matrix
t = zeros(1, 8);
wedges = CS6640_gen_wedges8(s); % Obtain index matrices for wedges

for r = s:M-(s-1)
    for c = s:N-(s-1)
        f = double(im(r-(s-1):r+(s-1), c-(s-1):c+(s-1))); % Isolate sector
        F = fft2(f); % Compute the 2D-DFT of the sector
        F = abs(fftshift(F)); % Power spectrum found with complex modulus
        for i = 1:8
            t(i) = sum(F(wedges(:,:,i))); % Sum up the PS values in wedges
        end
        % Pack the result into the output texture matrix. Note that the
        % texture matrix is stacked by columns (i.e. the first rows are for
        % column one, then for column two etc.)
        T(r+(c-1)*M, :) = t;
    end
end