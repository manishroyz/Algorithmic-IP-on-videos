function R = CS6640_gen_rings(n)
% CS6640_gen_rings - Produce binary matrices of rings
% On input:
%       n: number of rings to generate
% On output:
%       R (2n-1 x 2n-1 x n boolean array): Set of matrices where each
%       represents a ring of all possible sizes in the full matrix.
%       Rings are represented by 1's while the rest of the matrix is zero.
% Call:
%       R = CS6640_gen_rings(n);
% Author:
%       Manish Roy
%       UU 
%       Fall 2018
%

R = boolean(zeros(2*n-1, 2*n-1, n));
R(n, n, 1) = 1; % The first 'ring' is jsut the center of the matrix
for i = 2:n
    R(n-i+1:n+i-1, n-i+1:n+i-1, i) = ones(2*i-1);
    R(n-i+2:n+i-2, n-i+2:n+i-2, i) = zeros(2*(i-1)-1);
end
