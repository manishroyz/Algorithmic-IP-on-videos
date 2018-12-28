%camera = webcam; % requires installing the webcam Add-On support
nnet = alexnet; % requires installing the alexnet Add-on support
picture1 = camera.snapshot;
imshow(picture1);

D = 'C:\Users\Manish\Box\Fall 18\IP\A8\Images';
S = dir(fullfile(D,'*.jpg')); 
for k = 1:numel(S)
    F = fullfile(D,S(k).name);
    picture = imread(F);
    picture = imresize(picture,[227,227]);
    imshow(picture);
    image(picture);
    label = classify(nnet,picture);
    title(char(label));
    drawnow
    saveas(gcf,[ char(label) '.jpg']);
    %pause;    
end


% picture = imresize(picture,[227,227]);
% image(picture);
% label = classify(nnet,picture);
% title(char(label));
% drawnow
% clear camera