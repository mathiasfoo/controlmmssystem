clc
clear all

global theta Rf Ki Kp gE gS


load neurosporareference.mat

% % Base value 
% prmFRQ = [1.8,1.25,0.23];
% prpcFRQ = [1.8,0.32];
% prpnFRQ = [0.05,1,0.27,50];
% prmWC1 = [1.5,3,0.1];
% prpcWC1 = [1,1,10,40.05];
% prpnWC1 = [40,0.02,50,1];
% prpFRQWC1 = [50,6];
% prmCSP1 = [0.36,3,1.4];
% prpCSP1 = [50,1.4];


% % KM ~ 100
% prmFRQ = [89.5012,100.4988,0.2903];
% prpcFRQ = [1.8172,0.31039];
% prpnFRQ = [0.049942,0.99979,0.26881,49.9996];
% prmWC1 = [1.5039,3.0009,0.099918];
% prpcWC1 = [1.0011,1.0061,10.0097,40.0606];
% prpnWC1 = [39.9749,0.020045,49.9345,1.0038];
% prpFRQWC1 = [50.8697,6.0675];
% prmCSP1 = [0.35875,3.0502,1.4165];
% prpCSP1 = [50.3581,1.4142];


% % KM ~ 10
% prmFRQ = [6.8311,9.1172,0.21627];
% prpcFRQ = [1.9466,0.34944];
% prpnFRQ = [0.04955,0.99746,0.23563,49.3853];
% prmWC1 = [1.4595,2.9187,0.09894];
% prpcWC1 = [0.98549,0.77051,9.8408,40.8291];
% prpnWC1 = [39.7226,0.032762,50.9216,1.3069];
% prpFRQWC1 = [53.6693,6.4581];
% prmCSP1 = [0.31946,2.8978,1.2893];
% prpCSP1 = [54.8443,1.5446];

% % KM ~ 0.1
% prmFRQ = [0.82833,0.11095,0.20381];
% prpcFRQ = [1.7449,0.30839];
% prpnFRQ = [0.050986,1.0435,0.25658,55.4677];
% prmWC1 = [1.5275,3.0784,0.1005];
% prpcWC1 = [0.95745,1.0225,9.071,42.4152];
% prpnWC1 = [38.5802,0.02153,50.3382,0.9921];
% prpFRQWC1 = [52.3202,5.9325];
% prmCSP1 = [0.40748,2.9904,1.3491];
% prpCSP1 = [48.7644,1.4041];

% % KM ~ 0.01
% prmFRQ = [0.68226,0.013421,0.22522];
% prpcFRQ = [1.7344,0.32367];
% prpnFRQ = [0.034401,1.1098,0.074442,46.0916];
% prmWC1 = [1.7277,2.9845,0.11605];
% prpcWC1 = [0.49128,1.8921,14.7785,14.2846];
% prpnWC1 = [43.4056,0.012739,63.165,1.1615];
% prpFRQWC1 = [63.8327,6.5576];
% prmCSP1 = [0.32203,2.627,1.0782];
% prpCSP1 = [52.5315,1.4548];

% KM ~ 0.001
prmFRQ = [0.50254,0.0042446,0.19608];
prpcFRQ = [1.6289,0.29938];
prpnFRQ = [0.034608,2.0922,0.13833,39.8003];
prmWC1 = [1.0856,3.309,0.066467];
prpcWC1 = [0.91174,2.2294,4.9074,57.2264];
prpnWC1 = [66.0793,0.027601,63.4902,1.1307];
prpFRQWC1 = [56.5039,8.0608];
prmCSP1 = [0.30197,1.5745,1.4435];
prpCSP1 = [35.9522,0.99597];

nonlineartheta = [prmFRQ prpcFRQ prpnFRQ prmWC1 prpcWC1 prpnWC1 prpFRQWC1 prmCSP1 prpCSP1];

% Controller parameter
Ki = 0.1;
Kp = 5.5;
gE = 50; 
gS = 200;

theta = nonlineartheta;
GeneProteinLevelFull = [];


%% Initial condition

C = [1.2078,9.6564,0.1460,3.6302,0.0066,0.0541,0.0700,0.0098,0.6222,0,0,0,0];
Cinit = [1.2078,9.6564,0.1460,3.6302,0.0066,0.0541,0.0700,0.0098,0.6222,0,0,0,0];

for t = 1:length(mFRQ)
    tspan = [t t+1];
    Rf = mFRQref(t);
    [T,C] = ode45('S4_AD2015MM_ODE',tspan,C(end,:));
    GeneProteinLevelFull = [GeneProteinLevelFull; C(end,:)];
end

GeneProteinLevelFull = [Cinit; GeneProteinLevelFull(1:end-1,:)];

%% Plotting

tp = 0:length(mFRQ)-1;
figure(11)

subplot (3,3,1)
plot(tp,mFRQ,'k-',tp,GeneProteinLevelFull(:,1)','r--')
hold on
title('mFRQ')

subplot (3,3,2)
plot(tp,pcFRQ,'k-',tp,GeneProteinLevelFull(:,2)','r--')
hold on
title('pcFRQ')

subplot (3,3,3)
plot(tp,pnFRQ,'k-',tp,GeneProteinLevelFull(:,3)','r--')
hold on
title('pnFRQ') 

subplot (3,3,4)
plot(tp,mWC1,'k-',tp,GeneProteinLevelFull(:,4)','r--')
hold on
title('mWC1')

subplot (3,3,5)
plot(tp,pcWC1,'k-',tp,GeneProteinLevelFull(:,5)','r--')
hold on
title('pcWC1')

subplot (3,3,6)
plot(tp,pnWC1,'k-',tp,GeneProteinLevelFull(:,6)','r--')
hold on
title('pnWC1')

subplot (3,3,7)
plot(tp,pFRQWC1,'k-',tp,GeneProteinLevelFull(:,7)','r--')
hold on
title('pFRQWC1')

subplot (3,3,8)
plot(tp,mCSP1,'k-',tp,GeneProteinLevelFull(:,8)','r--')
hold on
title('mCSP1')

subplot (3,3,9)
plot(tp,pCSP1,'k-',tp,GeneProteinLevelFull(:,9)','r--')
hold on
title('pCSP1')

