X = [0 0 1 1; 0 1 0 1];
Y = [0 0 0 1];

%X = [carTrain' busTrain' truckTrain'; LcarTrain' LbusTrain' LtruckTrain'];
%X = [LcarTrain' LbusTrain' LtruckTrain'];
% X = [carTrain(:,1)' busTrain(:,1)' truckTrain(:,1)'];
% Y = [ones(1,length(carTrain)) 2*ones(1,length(busTrain)) 3*ones(1,length(truckTrain))];
net = feedforwardnet ([5]);
net.trainParam.epochs = 100;
net.trainParam.min_grad = 1.00e-6;
net.divideParam.trainRatio = 1; % training set [%]
net.divideParam.valRatio = 0; % validation set [%]
net.divideParam.testRatio = 0; % test set [%]
[net,tr,YP,E] = train(net,X,Y);
confMat = zeros(3,3);
for i = 1:3
    Pred = YP(1:length(carTrain));
    confMat(1,i) = sum(round(Pred) == i);
end
for i = 1:3
    Pred = YP(length(carTrain)+1 : length(carTrain)+length(busTrain));
    confMat(2,i) = sum(round(Pred) == i);
end
for i = 1:3
    Pred = YP(length(carTrain)+length(busTrain)+1:end);
    confMat(3,i) = sum(round(Pred) == i);
end
train_error = sum(round(YP)~=Y)/length(Y);

%Xtest = [carTest' busTest' truckTest'; LcarTest' LbusTest' LtruckTest'];
%Xtest = [LcarTest' LbusTest' LtruckTest'];
Xtest = [carTest(:,1)' busTest(:,1)' truckTest(:,1)'];

Ytest = [ones(1,length(carTest)) 2*ones(1,length(busTest)) 3*ones(1,length(truckTest))];
YPtest = net(Xtest);

confTestMat = zeros(3,3);
for i = 1:3
    Pred = YPtest(1:length(carTest));
    confTestMat(1,i) = sum(round(Pred) == i);
end
for i = 1:3
    Pred = YPtest(length(carTest)+1 : length(carTest)+length(busTest));
    confTestMat(2,i) = sum(round(Pred) == i);
end
for i = 1:3
    Pred = YPtest(length(carTest)+length(busTest)+1:end);
    confTestMat(3,i) = sum(round(Pred) == i);
end
test_error = sum(round(YPtest)~=Ytest)/length(Ytest);