function AO_net
%

neta = feedforwardnet(5);
neta.divideParam.valRatio = 0;
neta.divideParam.testRatio = 0;
neta.divideParam.trainRatio = 1;
neta.trainParam.epochs = 1000;
P = [0 0 1 1; 0 1 0 1];
ta = [0,0,0,1];
[neta,tra,Ya,Ea] = train(neta,P,ta);
display('AND');
neta(P)

neto = feedforwardnet(5);
neto.divideParam.valRatio = 0;
net.divideParam.testRatio = 0;
neto.divideParam.trainRatio = 1;
neto.trainParam.epochs = 10000;
P = [0 0 1 1; 0 1 0 1];
to = [0,1,1,1];
[neto,tro,Yo,Eo] = train(neto,P,to);
display('OR');
neto(P)

%netx = feedforwardnet(5);
%netx.divideParam.valRatio = 0;
%netx.divideParam.testRatio = 0;
%netx.divideParam.trainRatio = 1;
%netx.trainParam.epochs = 10000;
%P = [0 0 1 1; 0 1 0 1];
%tx = [-10,10,10,-10];
%[netx,trx,Yx,Ex] = train(neto,P,tx);
%display('XOR');
%neto(P)
