function [xp,yp] = CS6640_transform2D(x,y,q)
% CS6640_transform2D - produce transformed points
%   from given points and quadratic coeffients
% On input:
%     x (float): x value
%     y (float): y value
%     q (1x12 vector): quadratic coefficients
% On output:
%     xp (float): x value of transformed point
%     yp (float): y value of transformed point
% Call:
%     [xp,yp] = CS6640_transform2D(3,3,q);
% Author:
%     Manish Roy
%     UU
%     Fall 2018
%

% Build linear equations with known correspondences
Ax = [1, x, y, x*y, x*x, y*y, zeros(1,6)];
Ay = [zeros(1,6), 1, x, y, x*y, x*x, y*y];

% Calculate primed/transformed correspondences 
% using quadratic coefficients
xp = Ax*q';
yp = Ay*q';