function WS = CS6640_WS(im)
% CS6640_WS - watershed (returns largest spread region)
% On input:
%     im (MxN array): input image
% On output:
%     WS (MxN array): labeled watershed regions
% Call:
%     WS = CS6640_WS(im);
% Author:
%     Manish Roy
%     UU
%     Fall 2018

im = double(im);
[R,C] = size(im);
maxThresh = max(max(im));
neighbors = zeros(R,C);

for r = 1:R
    for c = 1:C
        w = maxThresh*ones(3,3);
        if(r==1)
            rL = (r:r+1);
            wrl = (2:3);
        elseif r==R
            rL = (r-1:r);
            wrl = (1:2);
        else
            rL = (r-1:r+1);
            wrl = (1:3);
        end
        if(c==1)
            cL = (c:c+1);
            wcl = (2:3);
        elseif c==C
            cL = (c-1:c);
            wcl = (1:2);
        else
            cL = (c-1:c+1);
            wcl = (1:3);
        end

        w(wrl,wcl) = im(rL,cL);
        
        [~,ind_w] = min(w(:));
        if(w(5)==min(w(:)))
            neighbors(r,c) = 5;
        else
            neighbors(r,c) = ind_w;
        end
    end
end

% neighbors
% neighbors
% figure
% imagesc(neighbors)
% title('neigbors')
% % colormap hot
% colorbar
%  pause

% figure
 WS_labels = bwlabel(neighbors==5);
% imagesc(WS_labels)

[UL_r,UL_c] = find(WS_labels == 0);
% UL_r = flipud(UL_r);
% UL_c = flipud(UL_c);


while(~isempty(UL_r))
    for k = 1:length(UL_r)
        r = UL_r(k);
        c = UL_c(k);

        w = nan*ones(3,3);

        if(r==1)
            rL = (r:r+1);
            wrl = (2:3);
        elseif r==R
            rL = (r-1:r);
            wrl = (1:2);
        else
            rL = (r-1:r+1);
            wrl = (1:3);
        end
        if(c==1)
            cL = (c:c+1);
            wcl = (2:3);
        elseif c==C
            cL = (c-1:c);
            wcl = (1:2);
        else
            cL = (c-1:c+1);
            wcl = (1:3);
        end

        w(wrl,wcl) = im(rL,cL);

        WS_win = zeros(3,3);
        WS_win(wrl,wcl) = WS_labels(rL,cL);
        [~,ind_w] = min(w(:));

        if WS_win(ind_w)~=0
            WS_labels(r,c) = WS_win(ind_w);
        end

    end
%     WS
%     imagesc(WS)
%     pause 
    [UL_r,UL_c] = find(WS_labels==0);
end

%     imagesc(WS_labels)
%     pause
    max_spred = 0; 
for i=1:max(max(WS_labels))
    [L_r,L_c] = find(WS_labels==i);
    potspred = abs(min(min(im(L_r,L_c)))-max(max(im(L_r,L_c))));
    if potspred>max_spred
        max_spred = potspred;
        max_shed = i;
    end
end
    WS = zeros(size(im));
    WS(WS_labels==max_shed) = 1;
%     imagesc(WS)
end

