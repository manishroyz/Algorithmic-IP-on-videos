function model = CS6640_build_Bayes(X)
% CS6640_build_Bayes - build Bayes model for dataset X
% On input:
%     X (nxm array): n samples of m-tuple feature vectors
% On output:
%     model (struct): model: mean and variance
%       .mean (mx1 vector): mean of X
%       .var (mxm array): covariance matrix of X%
% Call:
%     m1 = CS6640_build_Bayes([0,0; 0.1,0; -0.1,0]);
% Author:
%     Manish Roy
%     UU
%     Fall 2018
%

model.mean = mean(X)';
model.var = cov(X);