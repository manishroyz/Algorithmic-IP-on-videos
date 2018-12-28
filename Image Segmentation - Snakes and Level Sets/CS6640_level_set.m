function [phi,tr] = CS6640_level_set(im,max_iter,del_t,r0,c0)
% CS6640_level_set - level set of image
% On input:
%    im (MxN array): gray level or binary image
%    max_iter (int): maximum number of iterations
%    del_t (float): time step
%    r0 (int): row center of circular level set function
%    c0 (int): column center of circular level set function
% On output:
%    phi (MxN array): final phi array
%    tr (qx1 vector): sum(sum(abs(phi_(n+1) - phi_n)))
% Call:
%    [phi,tr] = CS6640_level_set(im,300,0.1,25,25);
% Author:
%    Manish Roy
%    UU
%    Fall 2018
%
[M,N] = size(im);
[C,R] = meshgrid(linspace(0,N,N),linspace(0,M,M));
r = 2;
phi_n = sqrt((C - c0).^2 + (R - r0).^2) - r;
[dx,dy] = gradient(im);
magGrad = sqrt(dx.^2 + dy.^2);
maxGrad = max(max(magGrad));
F = exp(-1.*magGrad);
gradThreshold = 0.2*maxGrad;
F(magGrad <= gradThreshold) = 1;
F(magGrad > gradThreshold) = 0;
% plotOverlay(im,phi_n < 0,'r') % uncomment to see initial phi placement



for iter = 1:max_iter
    Dx_plus = [phi_n(:,2:end),phi_n(:,end)] - phi_n;
    Dx_minu = phi_n - [phi_n(:,1),phi_n(:,1:end-1)];
    Dy_plus = [phi_n(1,:);phi_n(1:end-1,:)] - phi_n;
    Dy_minu = phi_n - [phi_n(2:end,:);phi_n(end,:)];
    
    grad_phi_plus = sqrt(max(Dx_minu,0).^2 + min(Dx_plus,0).^2 +...
        max(Dy_minu,0).^2 + min(Dy_plus,0).^2);
    
    grad_phi_minu = sqrt(max(Dx_plus,0).^2 + min(Dx_minu,0).^2 +...
        max(Dy_plus,0).^2 + min(Dy_minu,0).^2);
    
    phi_np1 = phi_n - del_t.*(max(F,0).*grad_phi_plus +...
        min(F,0).*grad_phi_minu);
    
    tr(iter) = sum(sum(abs(phi_np1 - phi_n)));
    
    phi_n = phi_np1;

    
    
    
end

phi = phi_n;

end