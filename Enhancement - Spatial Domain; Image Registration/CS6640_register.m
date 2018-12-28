
function [imr,q,A] = CS6640_register(im,s,cpts)
% CS6640_register - produce registered image and
%    transform
% On input:
%     im (MxN array): input image
%     s (int): transform switch: if 1, then quadratic,
%        else affine
%     cpts (2kx2 array): k corresponding points (evens are one set;
%        odds the other)
% On output:
%     imr (MxN array): registered image
%     q (1x12 vector): quadratic coefficients
%     A (3x3 array): affinetransform
% Call:
%     [imr,q,A] = CS6640_register(im,1);
% Author:
%     Manish Roy
%     UU
%     Fall 2018
%

% Get the number of points passed in
K = size(cpts,1) / 2;

A = zeros(3,3);
imr = zeros(size(im,1), size(im,2));

% Quadratic transformation Ax=b where x is q
if s==1
    % Pre-allocations
    Aq = zeros(2*K, 12);
    b = zeros(2*K, 1);
    
    for idx = 1:K
        % Build vector of correspondences b using 
        % even indexes in cpts
        b(2*(idx-1) + 1) = cpts(2*(idx-1) + 2,1);
        b(2*(idx-1) + 2) = cpts(2*(idx-1) + 2,2);
        
        % Get values of correspondences from reference image
        % using odd indexes of cpts
        xi = cpts(2*(idx-1) + 1,1);
        yi = cpts(2*(idx-1) + 1,2);
        
        % Matrix of unprimed correspondences
        Aq(2*(idx-1) + 1,:) = [1, xi, yi, xi*yi, xi*xi, yi*yi, zeros(1,6)];
        Aq(2*(idx-1) + 2,:) = [zeros(1,6), 1, xi, yi, xi*yi, xi*xi, yi*yi];
    end
 
    % Solve for transformation vector with least squares
    q = lsqlin(Aq,b);
    
    M=size(im,1);
    N=size(im,2);
    % Transform the pixels
    for m=1:M
        for n=1:N
            % Transform the image using the supplied
            % quadratic transformation vector q
            [tx,ty] = CS6640_transform2D(m,n,q');
            tx_r = round(tx);
            ty_r = round(ty);
            %check bounds and cut off to maintain MxN
            if ty_r>0 && ty_r<=N
                if tx_r>0 && tx_r<=M
                    imr(tx_r,ty_r) = im(m, n);
                end
            end
        end
    end
        
% Affine transformation
else
    % Pre-allocations
    Aa = zeros(2*K, 6);
    b = zeros(2*K, 1);
    
    for idx = 1:K
        % Build vector of correspondences b using 
        % even indexes in cpts
        b(2*(idx-1) + 1) = cpts(2*(idx-1) + 2,1);
        b(2*(idx-1) + 2) = cpts(2*(idx-1) + 2,2);
        
        % Get values of correspondences from reference image
        % using odd indexes of cpts
        xi = cpts(2*(idx-1) + 1,1);
        yi = cpts(2*(idx-1) + 1,2);
        
        % Matrix of unprimed correspondences
        Aa(2*(idx-1) + 1,:) = [xi, yi, 1, zeros(1,3)];
        Aa(2*(idx-1) + 2,:) = [zeros(1,3), xi, yi, 1];
    end
 
    % Solve for transformation vector with least squares
    q = lsqlin(Aa,b);
    
    % Generate Affine transform using least squares
    A(1,:) = q(1:3);
    A(2,:) = q(4:6);
    
    M=size(im,1);
    N=size(im,2);
    % Transform the pixels
    for m=1:M
        for n=1:N
            % Input coords
            b = [m n 1]';
            % Calculate transformed coords
            ptst = A*b;
            % Find best answer
            tx_r = round(ptst(1));
            ty_r = round(ptst(2));
            %check bounds and cut off to maintain MxN
            if ty_r>0 && ty_r<=N
                if tx_r>0 && tx_r<=M
                    imr(tx_r,ty_r) = im(m, n);
                end
            end
        end
    end

end
