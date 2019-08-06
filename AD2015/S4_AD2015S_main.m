clc
clear all
% close all

%% Loading all the experimental WT data under different light condition.
% The order of light condition is 12L12D, Short Day, Long Day, LL and DD.
% Each lighting condition is of FOUR days length. 


global theta Rf Ki Kp gSb gSm

load neurosporareferenceSS.mat

% % Base value 
prmFRQ = [0.80569,3.9937,0.27491];
prpcFRQ = [1.5144,0.25105];
prpnFRQ = [0.050751,1.0255,0.28667,48.8696];
prmWC1 = [0.43796,-0.12732,0.11805];
prpcWC1 = [0.066412,1.0938,0.20418,64.3947];
prpnWC1 = [42.0093,0.014821,51.0546,0.90579];
prpFRQWC1 = [52.0211,6.3082];
prmCSP1 = [0.063,0.92623,-0.17928,1.0502];
prpCSP1 = [52.412,1.4815];

% % g = 100, 
% prmFRQ = [0.81529,101.8784,0.28076];
% prpcFRQ = [1.5166,0.25856];
% prpnFRQ = [0.053302,1.0306,0.29366,48.8785];
% prmWC1 = [0.44755,-0.12185,0.11944];
% prpcWC1 = [0.067905,1.0964,0.21259,64.3972];
% prpnWC1 = [42.0174,0.017256,51.0639,0.90929];
% prpFRQWC1 = [52.0231,6.3107];
% prmCSP1 = [0.06916,0.93675,-0.17576,1.0585];
% prpCSP1 = [52.4179,1.487];

% % g = 10, 
% prmFRQ = [0.91658,5.2377,0.25647];
% prpcFRQ = [1.7446,0.28285];
% prpnFRQ = [0.052227,0.26917,0.29257,59.312];
% prmWC1 = [0.56972,-0.06856,0.14971];
% prpcWC1 = [0.076196,1.1062,0.11775,64.161];
% prpnWC1 = [35.0806,0.024978,52.8461,0.38378];
% prpFRQWC1 = [58.9647,5.4304];
% prmCSP1 = [0.084008,0.9299,-0.25133,1.3088];
% prpCSP1 = [43.4105,1.2165];

% % g = 0.1, 
% prmFRQ = [0.5337,0.11011,0.38589];
% prpcFRQ = [1.2562,0.28631];
% prpnFRQ = [0.050624,1.065,0.32936,49.3174];
% prmWC1 = [0.47249,-0.12101,0.11674];
% prpcWC1 = [0.073507,1.0774,0.18322,75.8756];
% prpnWC1 = [40.9009,0.013154,41.6074,0.75512];
% prpFRQWC1 = [54.9983,7.4252];
% prmCSP1 = [0.044706,0.49464,-0.15981,1.0728];
% prpCSP1 = [78.6839,1.8871];

% % g = 0.01, 
% prmFRQ = [0.43159,0.0092506,0.41281];
% prpcFRQ = [1.6204,0.29133];
% prpnFRQ = [0.075835,0.90274,0.35335,47.8529];
% prmWC1 = [0.42008,-0.12494,0.1187];
% prpcWC1 = [0.051973,1.3521,0.1978,65.8377];
% prpnWC1 = [36.7911,0.00835,29.6604,1.3434];
% prpFRQWC1 = [40.7559,8.0345];
% prmCSP1 = [0.04858,0.81265,-0.19812,0.97714];
% prpCSP1 = [50.8352,1.4061];

% g = 0.001, 
% prmFRQ = [0.2411,0.00054823,0.22839];
% prpcFRQ = [2.5675,0.4731];
% prpnFRQ = [0.12086,0.018437,0.20136,95.1479];
% prmWC1 = [0.79983,-0.19126,0.21941];
% prpcWC1 = [0.050735,1.405,0.2467,82.078];
% prpnWC1 = [34.1902,0.020401,11.3454,-2.497];
% prpFRQWC1 = [61.8299,9.3261];
% prmCSP1 = [0.06929,1.0102,-0.22537,0.98428];
% prpCSP1 = [35.4882,1.0572];


nonlineartheta = [prmFRQ prpcFRQ prpnFRQ prmWC1 prpcWC1 prpnWC1 prpFRQWC1 prmCSP1 prpCSP1] + 0.01*rand(1,28);

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
    Rf = mFRQrefSS(t);
    [T,C] = ode45('neurospora2015_ssmodel_control_ODE',tspan,C(end,:));
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

