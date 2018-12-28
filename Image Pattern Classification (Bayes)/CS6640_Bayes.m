function best_class = CS6640_Bayes(x,class_probs,class_models)
% CS6640_Bayes - Bayes classifier
% On input:
%     x (mx1 vector): feature vector
%     class_pros (1xn vector): probabilities of n classes (sums to 1)
%     class_models (1xn vector struct): class models: means and
%     variances
%       (k).mean (mx1 vector): k_th class mean vector
%       (k).var (mxm array): k_th class covariance matrix
% On output:
%     best_class (int): index of best class for x
% Call:
%     c = CS6640_Bayes(cp,cm);
% Author:
%     Manish Roy
%     UU
%     Fall 2018 
%

% P(x_bar|cj)
prob_x=[];
best_class=[];

for j=1:length(class_models)
    n=length(x);
    m=class_models(j).mean;
    c=class_models(j).var;
%     det_c = det(c);
    den = (2*pi).^(n/2).*det(c)^(1/2);
    num = exp(-(1/2)*(x-m)'*inv(c)*(x-m));
    prob_x(j)=num/den * class_probs(j);
end

cmax = max(prob_x(:));
best_class = find(prob_x == cmax);