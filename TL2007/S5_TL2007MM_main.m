clc
clear all


global theta Rf Ki Kp gE gS


load drosophilaLLdata.mat
load drosophilareference.mat 

% % Base value (KM = 0.001)
prmCLK = [0.000894,0.0299,0.274,1.38,1.32,0.02];
prpCLK = [0.26,0.0397,0.0064,0.0301,0.0002,1.79];
prpcCC = [0.0397,0.0064,0.0477,0.0033,0.0233,0.0068,9.24];
prpnCC = [0.0477,0.0033,6.36,3.24,0.0026,0.0009,0.02];
prmPER = [1,0.274,0.0612,0.274,0.251,0.0071,0.02]; 
prmTIM = [1,0.274,0.0571,0.274,0.251,0.0119,0.02];
prpcPER = [1,225,0.861,1,0.0029,0.0157,90.4];
prpcTIM = [0.212,225,1,0.0401,0.0004,0.725];
prpcPT = [225,0.22,0.0595,0.0026,0.912,1,0.0001,0.0217,0.02];
prpcphPT = [0.22,0.0595,0.0026,0.912,3.84,1,0.0001,0.154,0.02];
prpcphPER = [3.84,1.14,1,0.0014,1.6,0.02];
prpcphTIM = [3.84,25.2,1,0.0014,0.256,0.02];
prpnPER = [0.861,1.14,3.24,6.36,0.0492,0.0027,0.02];
prpnTIM = [25.2,1,270,2.51,0.119,0.012,0.02];
prpnPCC = [6.36,3.24,270,2.51,1,0.0145,0.0064,0.02];
prpnPTCC = [270,2.51,1,0.0232,0.0732,0.02];

% % KM ~ 0.0001
% prmCLK = [0.00089831,0.029728,0.27457,1.3714,1.3251,0.019977];
% prpCLK = [0.26104,0.039552,0.0063973,0.029963,0.00019973,1.7854];
% prpcCC = [0.039555,0.0063786,0.047806,0.0032847,0.023332,0.0067943,9.2696];
% prpnCC = [0.047513,0.0033161,6.3661,3.2317,0.002608,0.00089885,0.019998];
% prmPER = [1.3551,2.6582e-05,0.010022,0.015237,1.249,0.01931,0.0095144];
% prmTIM = [1.0036,0.27392,0.057146,0.27359,0.25224,0.011902,0.019999];
% prpcPER = [0.99686,224.7703,0.85997,1.0017,0.0028982,0.015684,90.5433];
% prpcTIM = [0.21297,223.8029,0.99907,0.040206,0.00039951,0.72437];
% prpcPT = [226.1371,0.21914,0.059519,0.0026003,0.91096,0.99878,9.9951e-05,0.021685,0.01998];
% prpcphPT = [0.22107,0.059593,0.0025967,0.91207,3.823,0.99943,9.9921e-05,0.15399,0.019982];
% prpcphPER = [3.8498,1.135,0.99908,0.0013992,1.5992,0.019979];
% prpcphTIM = [3.8469,25.1373,0.99876,0.0013989,0.25604,0.019975];
% prpnPER = [0.85974,1.1396,3.2096,6.421,0.050184,0.0026969,0.020027];
% prpnTIM = [25.2417,0.99982,269.9402,2.5134,0.11908,0.012008,0.019981];
% prpnPCC = [6.3524,3.245,274.109,2.4794,0.99061,0.014581,0.0063814,0.019985];
% prpnPTCC = [266.1038,2.5405,1.0066,0.02327,0.073078,0.020027];

% % KM ~ 0.00001
% prmCLK = [0.00092925,0.032449,0.25602,1.291,1.3066,0.021339];
% prpCLK = [0.27313,0.037362,0.0061254,0.027043,0.00021606,1.9568];
% prpcCC = [0.036369,0.0059185,0.041443,0.0035964,0.024415,0.0070312,9.2306];
% prpnCC = [0.049672,0.0032696,6.3075,3.2166,0.0022221,0.00092566,0.018474];
% prmPER = [0.44075,0.072516,0.0032803,0.68245,0.34551,4.9749e-06,0.00017124];
% prmTIM = [1.0574,0.30244,0.065209,0.27726,0.25375,0.012319,0.012492];
% prpcPER = [0.9055,218.3978,0.92446,1.0347,0.0032897,0.016465,91.114];
% prpcTIM = [0.15816,254.2896,0.63317,0.03952,0.00037509,0.29165];
% prpcPT = [218.0551,0.20808,0.060143,0.0029221,1.0456,0.42923,8.8391e-05,0.02231,0.017407];
% prpcphPT = [0.20696,0.069995,0.0028307,0.99855,3.5041,1.0894,0.00011056,0.15772,0.0187];
% prpcphPER = [4.0299,1.1445,1.1474,0.0014958,1.7796,0.020516];
% prpcphTIM = [3.8054,26.2856,1.0434,0.0013428,0.26541,0.0471];
% prpnPER = [0.20718,1.3714,2.4767,6.6315,0.051289,0.0029508,0.020117];
% prpnTIM = [26.8024,1.1422,285.5356,2.4593,0.10891,0.01258,0.018833];
% prpnPCC = [6.4835,3.2696,288.6267,2.4386,0.93347,0.014891,0.0064821,0.017987];
% prpnPTCC = [272.5003,2.448,0.93297,0.024524,0.077164,0.023396];

nonlineartheta = [prmCLK prpCLK prpcCC prpnCC prmPER prmTIM prpcPER prpcTIM...
    prpcPT prpcphPT prpcphPER prpcphTIM prpnPER prpnTIM prpnPCC prpnPTCC];

% Controller parameter
Ki = 0.1;
Kp = 5.5;
gE = 50; 
gS = 200;

theta = nonlineartheta;
GeneProteinLevelFull = [];


%% Initial condition
C = [0.9967,0.1028,0.0017,0.0194,0.4191,1.1540,0.0041,0.0785,...
    0.0218,0.0129,0.0669,0.0019,0.6090,0.0054,0.0193,0.0079,...
    0,0,0,0];

Cinit = [0.9967,0.1028,0.0017,0.0194,0.4191,1.1540,0.0041,0.0785,...
    0.0218,0.0129,0.0669,0.0019,0.6090,0.0054,0.0193,0.0079,...
    0,0,0,0];

for t = 1:length(mCLK)
    tspan = [t t+1];
    Rf = mPERref(t);
    [T,C] = ode45('S5_TL2007MM_ODE',tspan,C(end,:));
    GeneProteinLevelFull = [GeneProteinLevelFull; C(end,:)];
end

GeneProteinLevelFull = [Cinit; GeneProteinLevelFull(1:end-1,:)];


%% Plotting

tp = 0:length(mCLK)-1;
figure(1111)
subplot (4,4,1)
plot(tp,GeneProteinLevelFull(:,1),'LineWidth',1)
hold on
grid on
title('mCLK')

subplot (4,4,2)
plot(tp,GeneProteinLevelFull(:,2),'LineWidth',1)
hold on
grid on
title('pCLK')

subplot (4,4,3)
plot(tp,GeneProteinLevelFull(:,3),'LineWidth',1)
hold on
grid on
title('pcCLK/CYC')

subplot (4,4,4)
plot(tp,GeneProteinLevelFull(:,4),'LineWidth',1)
hold on
grid on
title('pnCLK/CYC')

subplot (4,4,5)
plot(tp,GeneProteinLevelFull(:,5),'LineWidth',1)
hold on
grid on
title('mPER')

subplot (4,4,6)
plot(tp,GeneProteinLevelFull(:,6),'LineWidth',1)
hold on
grid on
title('mTIM')

subplot (4,4,7)
plot(tp,GeneProteinLevelFull(:,7),'LineWidth',1)
hold on
grid on
title('pcPER')

subplot (4,4,8)
plot(tp,GeneProteinLevelFull(:,8),'LineWidth',1)
hold on
grid on
title('pcTIM')

subplot (4,4,9)
plot(tp,GeneProteinLevelFull(:,9),'LineWidth',1)
hold on
grid on
title('pPER/TIM')

subplot (4,4,10)
plot(tp,GeneProteinLevelFull(:,10),'LineWidth',1)
hold on
grid on
title('pPER/TIM-ph')

subplot (4,4,11)
plot(tp,GeneProteinLevelFull(:,11),'LineWidth',1)
hold on
grid on
title('pcPER-ph')

subplot (4,4,12)
plot(tp,GeneProteinLevelFull(:,12),'LineWidth',1)
hold on
grid on
title('pcTIM-ph')

subplot (4,4,13)
plot(tp,GeneProteinLevelFull(:,13),'LineWidth',1)
hold on
grid on
title('pnPER')

subplot (4,4,14)
plot(tp,GeneProteinLevelFull(:,14),'LineWidth',1)
hold on
grid on
title('pnTIM')

subplot (4,4,15)
plot(tp,GeneProteinLevelFull(:,15),'LineWidth',1)
hold on
grid on
title('pPER/CLK/CYC')

subplot (4,4,16)
plot(tp,GeneProteinLevelFull(:,16),'LineWidth',1)
hold on
grid on
title('pPER/TIM/CLK/CYC')