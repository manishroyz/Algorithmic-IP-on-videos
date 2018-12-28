D = 'C:\Users\Manish\Box\Fall 18\IP\A8\Images';
S = dir(fullfile(D,'*.jpg')); 
for k = 1:numel(S)
    F = fullfile(D,S(k).name);
    I = imread(F);
    imshow(I)
    S(k).data = I;     
end