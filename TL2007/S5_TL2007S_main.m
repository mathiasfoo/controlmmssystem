clc
clear all

global theta Rf Ki Kp gE gS

load drosophilareference.mat 

% % Base value 
prmCLK = [0.0041161,0.0021893,1.0757,0.35421];
prpCLK = [0.090158,0.935];
prpcCC = [0.035946,0.28457,10.4912];
prpnCC = [0.025093,0.50315,0.0027571,6.1968,2.7399];
prmPER = [722.8935,6.3438,1.9142,10.8865];
prmTIM = [175.6051,2.3162,2.2238,0.19659];
prpcPER = [0.55071,1.3406,0.037236,677.7887,3.4731e-06];
prpcTIM = [0.31181,0.40709,4.6964,19.8451];
prpcPT = [163.9076,1.0201,2.1545];
prpcphPT = [0.88679,0.92717,2.7127];
prpcphPER = [15.8719,3.7096];
prpcphTIM = [4.3078,28.0256];
prpnPER = [6.8225e-06,0.7564,0.023393,12.5846,2.6191,1.2989];
prpnTIM = [11.6564,1.104,2.221,56.9629,1.2925];
prpnPCC = [4.4828,1.8521,1652.0301,23.4804];
prpnPTCC = [1435.8726,20.7765];

% % g = 0.01
% prmCLK = [0.0045165,0.0022526,0.70425,0.40138];
% prpCLK = [0.095832,1.0601];
% prpcCC = [0.03712,0.29502,12.1112];
% prpnCC = [0.026021,0.59778,0.002186,7.3368,3.4021];
% prmPER = [15.4742,7.6033,0.0096848,13.1605];
% prmTIM = [187.3752,2.536,2.614,0.226];
% prpcPER = [0.55967,3.3424,0.039196,699.6066,3.373e-06];
% prpcTIM = [0.30505,0.47003,5.3267,22.6513];
% prpcPT = [180.1724,1.183,2.1633];
% prpcphPT = [0.98613,0.97215,3.0338];
% prpcphPER = [19.5602,4.4703];
% prpcphTIM = [4.827,30.834];
% prpnPER = [6.7649e-06,1.0213,0.024746,13.5546,2.699,1.322];
% prpnTIM = [12.6224,1.278,2.4005,56.2414,1.4058];
% prpnPCC = [4.7834,2.1709,1300.4385,23.0994];
% prpnPTCC = [1386.9362,25.628];

% % g = 0.001
% prmCLK = [0.0033881,0.0059508,0.46019,0.21032];
% prpCLK = [0.17702,0.48931];
% prpcCC = [0.031182,0.55979,4.5684];
% prpnCC = [0.014665,0.52631,0.0021396,4.9047,3.0692];
% prmPER = [11.3982,6.6167,0.0010882,17.2598];
% prmTIM = [285.9384,3.0469,2.0682,0.20605];
% prpcPER = [0.16759,0.01102,0.038992,888.4722,8.5954e-07];
% prpcTIM = [0.48268,0.47267,3.4942,106.5822];
% prpcPT = [279.5806,0.95781,2.0834];
% prpcphPT = [1.3957,1.1542,3.1336];
% prpcphPER = [17.3747,3.9016];
% prpcphTIM = [3.5842,29.3716];
% prpnPER = [0.01478,1.1611,0.023085,12.9393,2.1188,1.465];
% prpnTIM = [9.6673,1.0498,1.9923,85.1636,1.827];
% prpnPCC = [6.1101,1.058,1657.8606,20.0117];
% prpnPTCC = [1278.5767,26.1919];

nonlineartheta = [prmCLK prpCLK prpcCC prpnCC prmPER prmTIM prpcPER prpcTIM...
    prpcPT prpcphPT prpcphPER prpcphTIM prpnPER prpnTIM prpnPCC prpnPTCC];

% Controller parameter
Ki = 0.1;
Kp = 5.5;
gE = 50; 
gS = 200;

theta = nonlineartheta;
GeneProteinLevelFull = [];

% return

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
    [T,C] = ode45('drosophila2007_ssmodel_control_ODE',tspan,C(end,:));
    GeneProteinLevelFull = [GeneProteinLevelFull; C(end,:)];
end

GeneProteinLevelFull = [Cinit; GeneProteinLevelFull(2:end,:)];

%% Plotting

tp = 0:length(mCLK)-1;
figure(1112)
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