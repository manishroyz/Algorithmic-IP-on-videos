function W = CS6640_gen_wedges8(n)
% CS6640_gen_wedges8 - Produce 8 binary matrices of wedges
% On input:
%       n: size of matrices to create (2n-1 x 2n-1)
% On output:
%       W (2n-1 x 2n-1 x 8 boolean array): Set of boolean matrices where
%       each represents one of 8 wedges. Wedges are represented by 1's
%       while the rest of the matrix is zero.
% Call:
%       W = CS6640_gen_wedges8(n);
% Author:
%       Manish Roy
%       UU 
%       Fall 2018
%

W = boolean(zeros(2*n-1, 2*n-1, 8)); % Preallocate space

% Create the first wedge
for i = 1:n
    row = [ones(1, i) zeros(1, 2*n-1-i)];
    W(i, :, 8) = row;
end

% Generate subsequent wedges by transpose and flips
W(:, :, 1) = W(:, :, 8)';
W(:, :, 2) = flip(W(:, :, 1), 2);
W(:, :, 3) = flip(W(:, :, 8), 2);
W(:, :, 4) = flip(W(:, :, 3), 1);
W(:, :, 5) = flip(W(:, :, 2), 1);
W(:, :, 6) = flip(W(:, :, 1), 1);
W(:, :, 7) = flip(W(:, :, 8), 1);
