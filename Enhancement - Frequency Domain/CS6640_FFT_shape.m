function X = CS6640_FFT_shape(Z,w)
% CS6640_FFT_shape - compute Fourier shape descriptors for a curve
% On input:
%       Z (Nx2 array): input curve (should be closed)
%       w (int): distance along curve to determine angles
% On output:
%       X ((N/2-1)x1 vector): the Fourier coefficients for the curve
% Call:
%       X = CS6640_FFT_shape(curve,2);
% Author:
%       Manish Roy
%       UU 
%       Fall 2018
%

[N, ~] = size(Z);
Z = [Z(1:end-1,:); Z]; % Concatenate set of points to allow wrap arround
                       % for w when the end of the contour has been reached

% Form phi, the net angular change relative to the first point direction
phi = zeros(1, N);
for i = 1:N
    phi(i) = atan2(Z(i+w,2)-Z(i,2), Z(i+w,1)-Z(i,1));
    if i > 1
        diff = phi(i) - mod(phi(i-1), 2*pi);
        % Since atan2 only gives results from -pi to pi, we must make
        % modifications to the diff variable to account for the true
        % direction of angle change.
        if diff > pi
            diff = diff - 2*pi;
        elseif diff < -pi
            diff = diff + 2*pi;
        end
        phi(i) = phi(i-1) + diff;
    end
end
% Shift values so the first phi is 0
phi = phi - phi(1);

% Compute psi from 0 to 2pi
t = linspace(0, 2*pi, N);
psi = phi + t;

% Compute the shape descriptor
X = fft(psi);
X = abs(X);
X = X(2:ceil(end/2));
