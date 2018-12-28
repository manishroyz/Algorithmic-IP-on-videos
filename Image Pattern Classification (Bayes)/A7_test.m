function A7_test
%

load XXX
figure(1)
clf
tmodels(1) = CS6640_build_Bayes(X1);
tmodels(2) = CS6640_build_Bayes(X2);
tmodels(3) = CS6640_build_Bayes(X3);
abs(models(1).mean-tmodels(1).mean)
abs(models(1).var-tmodels(1).var)
abs(models(2).mean-tmodels(2).mean)
abs(models(2).var-tmodels(2).var)
abs(models(3).mean-tmodels(3).mean)
abs(models(3).var-tmodels(3).var)

input('Go?');

min_val = -2;
dx = 0.1;
max_val = 2;
x_vals = [min_val:dx:max_val];
len_x = length(x_vals);
count = 0;
for ind1 = 1:len_x
    x = x_vals(ind1);
    for ind2 = 1:len_x
        count = count + 1;
        y = x_vals(ind2);
        x_data(count,:) = [x,y];
    end
end

xt = [];
for t = 1:count
    x = x_data(t,:);
    bc = CS6640_Bayes(x',probs,tmodels);
    xt = [xt;bc,x];
end

figure(1)
clf
plot(min_val-1,min_val-1,'w.');
plot(max_val+1,max_val+1,'w.');

hold on
for p = 1:count
    if xt(p,1)==1
        plot(xt(p,2),xt(p,3),'r*');
    elseif xt(p,1)==2
        plot(xt(p,2),xt(p,3),'g*');
    else
        plot(xt(p,2),xt(p,3),'b*');
    end
end
drawnow
input('Go?');
