function T = CS6640_FFT_radial(im)
% CS6640_FFT_radial - compute FFT radial texture parameters
% On input:
%       im (MxN array): input image
% On output:
%       T (M*Nx10 array): texture parameters
%       each texture parameter is a column vector in T
% Call:
%       T = CS6640_FFT_radial(im);
% Author:
%       Manish Roy
%       UU 
%       Fall 2018
%

[M, N] = size(im); % Get number of rows and columns
s = 10; % Number of rings
T = zeros(M*N, s); % Preallocate output texture matrix
t = zeros(1, s);
rings = CS6640_gen_rings(s); % Obtain index matrices for rings

for r = s:M-(s-1)
    for c = s:N-(s-1)
        f = double(im(r-(s-1):r+(s-1), c-(s-1):c+(s-1))); % Isolate sector
        F = fft2(f); % Compute the 2D-DFT of the sector
        F = abs(fftshift(F)); % Power spectrum found with complex modulus
        for i = 1:s
            t(i) = sum(F(rings(:,:,i))); % Sum up the PS values in rings
        end
        % Pack the result into the output texture matrix. Note that the
        % texture matrix is stacked by columns (i.e. the first rows are for
        % column one, then for column two etc.)
        T(r+(c-1)*M, :) = t;
    end
end
