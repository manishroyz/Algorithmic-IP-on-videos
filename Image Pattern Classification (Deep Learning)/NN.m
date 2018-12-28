carTrainAll = [carTrain LcarTrain];
busTrainAll = [busTrain LbusTrain];
truckTrainAll = [truckTrain LtruckTrain];
carTestAll = [carTest LcarTest];
busTestAll = [busTest LbusTest];
truckTestAll = [truckTest LtruckTest];

% LENGTH
carTrain1 = carTrain(:,1);
busTrain1 = busTrain(:,1);
truckTrain1 = truckTrain(:,1);
carTest1 = carTest(:,1);
busTest1 = busTest(:,1);
truckTest1 = truckTest(:,1);

% LENGHT, WIDTH 
carTrain1_2 = [carTrain(:,1), carTrain(:,2)];
busTrain1_2 = [busTrain(:,1),busTrain(:,2)];
truckTrain1_2 = [truckTrain(:,1),truckTrain(:,2)];
carTest1_2 = [carTest(:,1),carTest(:,2)];
busTest1_2 = [busTest(:,1),busTest(:,2)];
truckTest1_2 = [truckTest(:,1),truckTest(:,2)];

% AREA L*B
carTrain12 = carTrain(:,1).*carTrain(:,2);
busTrain12 = busTrain(:,1).*busTrain(:,2);
truckTrain12 = truckTrain(:,1).*truckTrain(:,2);
carTest12 = carTest(:,1).*carTest(:,2);
busTest12 = busTest(:,1).*busTest(:,2);
truckTest12 = truckTest(:,1).*truckTest(:,2);

% AREA , PIXELS
carTrain123 = [carTrain(:,1).*carTrain(:,2) , carTrain(:,3)]  ;
busTrain123 = [busTrain(:,1).*busTrain(:,2), busTrain(:,3)] ;
truckTrain123 = [truckTrain(:,1).*truckTrain(:,2), truckTrain(:,3)];
carTest123 = [carTest(:,1).*carTest(:,2) , carTest(:,3)]  ;
busTest123 = [busTest(:,1).*busTest(:,2), busTest(:,3)] ;
truckTest123 = [truckTest(:,1).*truckTest(:,2), truckTest(:,3)];






% Simple AND Gate
%X = [0 0 1 1; 0 1 0 1];
%Y = [0 0 0 1];
%X = [carTrain' busTrain' truckTrain'];
%Y = [ones(1,length(carTrain)) 2*ones(1,length(busTrain)) 2*ones(1,length(truckTrain))  ];


X = [LcarTrain' LbusTrain' LtruckTrain'];
Y = [ones(1,length(LcarTrain)) 2*ones(1,length(LbusTrain)) 2*ones(1,length(LtruckTrain))];
net = feedforwardnet ([5]);
net.trainParam.epochs = 30000;
net.divideParam.trainRatio = 1; % training set [%]
net.divideParam.valRatio = 0; % validation set [%]
net.divideParam.testRatio = 0; % test set [%]
net.trainParam.min_grad = 1.00e-06;
[net,tr,YP,E] = train(net,X,Y);

training_error = sum(round(YP) ~= Y)/length(X);





test = [X_bus_3(:,1:n)' X_truck_3(:,1:n)' X_car_3(:,1:n)'];
expected = [ones(1,length(X_bus_3)) 2*ones(1,length(X_truck_3)) 3*ones(1,length(X_car_3))];
pred = net (test);

test_error = sum(round(pred) ~= expected)/(length(X_bus_3) + length(X_truck_3) + length(X_car_3))