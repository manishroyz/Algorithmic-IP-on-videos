function A5_test
%

display('small GC test');

A = [1 100; 1 100];
[C,V] = CS6640_GC(A)

input('Go?');

display('Large GC test');

load GC5

figure(1)
clf
imshow(C==1);
figure(2)
clf
plot(V(:,1));
input('Go?');

display('B WS test');
B = 100*ones(11,11);
B(4:7,4:7) = 50;
B = imfilter(B,ones(3,3)/9);
B(1,:) = 100;
B(end,:) = 100;
B(:,1) = 100;
B(:,end) = 100;
WS = CS6640_WS(B);

figure(3)
clf
imshow(WS);

input('Go?');

display('Large WS test');
figure(4)
clf
WS = CS6640_WS(imd51s);
imshow(WS);
