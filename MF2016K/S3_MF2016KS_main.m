clc
clear all
% close all

global EL theta Rf Rl Ki Kp gSb gSm

load kernel2015mprr9ref.mat
    

%% Defining Light Condition
Tsp = 10;
T_12 = [ones(1,120) zeros(1,120)]; 
T_12 = repmat(T_12,1,4); T_12 = T_12(1:Tsp:end);

Tlight = T_12;


%% Model Parameter

Ki = 0.3;
Kp = 4.5;
gSb = 50;
gSm = 200;

% % Base value (MSE 0.2614)
prP = [0.5243,-0.58778,-0.54439];
prmLHY = [0.080536,-2.4119,-0.60992];
prpLHY = [0.75389,-0.63134];
prmPRR9 = [0.7741,4.1305,-0.29021,6.0094e-06];
prpPRR9 = [0.81692,-0.47414];
prmPRR7 = [0.0040951,-2.0709,-0.042369,-0.28771];
prpPRR7 = [0.2191,-0.16283];
prmPRR5 = [0.00051033,-0.0001869,-2.842,-0.1979];
prpPRR5 = [0.67945,-0.57819];
prmTOC1 = [0.028875,-1.3052,-0.0015685,-1.9085];
prpTOC1 = [0.4008,-0.26564];
prpEC = [0.72256,-0.42138];
prmRVE8 = [0.078571,-0.8478,-1.0042];
prpRVE8 = [0.21476,-0.13975];
prmELF3 = [0.048475,-0.70101,-0.3684];
prpELF3 = [1.6738,-2.1109];
prmELF4 = [0.0080766,-1.2259,-0.41565,-0.82833];
prpELF4 = [1.0015,-0.68974];
prmLUX = [0.0017642,-1.6876,-0.727,-0.95194];
prpLUX = [0.92845,-0.69406];
prmGI = [0.017706,-0.62064,-0.73512,-0.45605,-0.58678];
prpGI = [0.1513,-0.057858,-0.12203];
prpCOP1 = [0.60388,-0.62038,-0.51547];
prpZTL = [0.37753,-1.691,1.5102];


% % x 100 (cannot fit data)
% prP = [0.52662,-0.59173,-0.53939];
% prmLHY = [0.083252,-2.2233,-0.60203];
% prpLHY = [0.72994,-0.63349];
% prmPRR9 = [0.76345,98.283,-0.27253,5.9513e-06];
% prpPRR9 = [0.77894,-0.46601];
% prmPRR7 = [0.0039485,-2.0654,-0.042557,-0.29232];
% prpPRR7 = [0.21999,-0.16537];
% prmPRR5 = [0.0005022,-0.00018653,-2.7397,-0.20134];
% prpPRR5 = [0.67271,-0.55202];
% prmTOC1 = [0.029113,-1.2999,-0.0015639,-1.8974];
% prpTOC1 = [0.40384,-0.27609];
% prpEC = [0.7015,-0.42021];
% prmRVE8 = [0.077592,-0.83268,-0.9962];
% prpRVE8 = [0.21371,-0.13741];
% prmELF3 = [0.048566,-0.6912,-0.36617];
% prpELF3 = [1.6972,-2.0957];
% prmELF4 = [0.0079703,-1.2121,-0.41573,-0.82169];
% prpELF4 = [0.99728,-0.66488];
% prmLUX = [0.0017517,-1.6908,-0.74416,-0.99227];
% prpLUX = [0.88613,-0.69208];
% prmGI = [0.01851,-0.61304,-0.72451,-0.44693,-0.58363];
% prpGI = [0.14709,-0.058098,-0.12151];
% prpCOP1 = [0.59729,-0.61525,-0.51502];
% prpZTL = [0.3944,-1.6931,1.4809];

% % x 10 (converge close to ~4)
% prP = [0.52278,-0.57943,-0.54449];
% prmLHY = [0.086422,-2.0388,-0.63008];
% prpLHY = [0.82833,-0.65534];
% prmPRR9 = [0.85458,4.7773,-0.25079,3.4541e-06];
% prpPRR9 = [0.77974,-0.48809];
% prmPRR7 = [0.0041117,-2.1489,-0.039365,-0.29042];
% prpPRR7 = [0.23633,-0.18412];
% prmPRR5 = [0.00053036,-0.00021298,-2.8904,-0.2006];
% prpPRR5 = [0.70505,-0.54441];
% prmTOC1 = [0.029909,-1.3225,-0.00092896,-1.8007];
% prpTOC1 = [0.42345,-0.26454];
% prpEC = [0.9891,-0.51333];
% prmRVE8 = [0.075482,-0.90914,-1.0713];
% prpRVE8 = [0.24939,-0.16017];
% prmELF3 = [0.046071,-0.72683,-0.34629];
% prpELF3 = [1.4498,-1.8501];
% prmELF4 = [0.0082502,-1.3115,-0.37208,-0.87144];
% prpELF4 = [0.91806,-0.62204];
% prmLUX = [0.0018169,-1.7708,-0.67266,-0.8721];
% prpLUX = [1.0413,-0.77968];
% prmGI = [0.017141,-0.72657,-0.83272,-0.38565,-0.7257];
% prpGI = [0.16638,-0.061646,-0.12624];
% prpCOP1 = [0.54435,-0.55667,-0.45973];
% prpZTL = [0.24036,-1.4686,1.5163];

% % x 0.1 (cannot fit data)
% prP = [0.52937,-0.58919,-0.50889];
% prmLHY = [0.084673,-2.0458,-0.58848];
% prpLHY = [0.81064,-0.61978];
% prmPRR9 = [0.67968,0.10412,-0.31026,5.9914e-06];
% prpPRR9 = [0.73828,-0.51937];
% prmPRR7 = [0.0042275,-1.7903,-0.042548,-0.29585];
% prpPRR7 = [0.2304,-0.18947];
% prmPRR5 = [0.00050552,-0.00019566,-2.6761,-0.184];
% prpPRR5 = [0.66405,-0.60169];
% prmTOC1 = [0.029614,-0.7266,-0.0015782,-1.8596];
% prpTOC1 = [0.40659,-0.26186];
% prpEC = [0.74935,-0.40174];
% prmRVE8 = [0.07958,-0.77699,-1.098];
% prpRVE8 = [0.2245,-0.14398];
% prmELF3 = [0.04982,-0.68336,-0.40315];
% prpELF3 = [1.7441,-2.1876];
% prmELF4 = [0.0083623,-1.1547,-0.45366,-0.85344];
% prpELF4 = [0.94871,-0.7481];
% prmLUX = [0.0018207,-1.6097,-0.73333,-0.89755];
% prpLUX = [0.96602,-0.71139];
% prmGI = [0.01753,-0.53555,-0.75201,-0.45459,-0.59746];
% prpGI = [0.15017,-0.057317,-0.13611];
% prpCOP1 = [0.61863,-0.61244,-0.56372];
% prpZTL = [0.36974,-1.7403,1.5113];

% % x 0.01 (cannot fit data)
% prP = [0.58039,-0.62289,-0.60067];
% prmLHY = [0.089056,-2.0452,-0.73286];
% prpLHY = [0.95951,-0.68971];
% prmPRR9 = [0.11023,0.0071365,-0.35138,6.4432e-06];
% prpPRR9 = [0.68673,-0.62862];
% prmPRR7 = [0.0036146,-1.9873,-0.013261,-0.37697];
% prpPRR7 = [0.19912,-0.19225];
% prmPRR5 = [0.00056523,-0.00013694,-2.3726,-0.21174];
% prpPRR5 = [0.74821,-0.65764];
% prmTOC1 = [0.03644,-1.4908,-0.0018245,-2.386];
% prpTOC1 = [0.34029,-0.35661];
% prpEC = [0.71261,-0.33266];
% prmRVE8 = [0.094072,-0.74043,-0.95449];
% prpRVE8 = [0.2117,-0.14671];
% prmELF3 = [0.033823,-0.91408,-0.36341];
% prpELF3 = [1.9507,-2.5748];
% prmELF4 = [0.008136,-1.3565,-0.4961,-0.93157];
% prpELF4 = [0.64685,-0.48038];
% prmLUX = [0.0015821,-1.8408,-0.75864,-0.86334];
% prpLUX = [0.95687,-0.70899];
% prmGI = [0.011084,-0.67105,-0.81356,-0.44101,-0.63193];
% prpGI = [0.16102,-0.049111,-0.14948];
% prpCOP1 = [0.56786,-0.58063,-0.49705];
% prpZTL = [0.39229,-1.4982,1.1247];

% % x 0.001 (cannot fit data)
% prP = [0.60475,-0.67685,-0.51991];
% prmLHY = [0.077894,-2.068,-0.75671];
% prpLHY = [0.87763,-0.8246];
% prmPRR9 = [0.085975,0.00075928,-0.38836,5.5707e-06];
% prpPRR9 = [0.66786,-0.5179];
% prmPRR7 = [0.0048197,-2.0601,-0.042526,-0.36103];
% prpPRR7 = [0.23829,-0.20766];
% prmPRR5 = [0.0005276,-0.00020434,-2.8594,-0.22959];
% prpPRR5 = [0.72322,-0.65906];
% prmTOC1 = [0.025234,-1.2029,-0.00084123,-1.8973];
% prpTOC1 = [0.4139,-0.29731];
% prpEC = [0.55108,-0.43621];
% prmRVE8 = [0.10335,-0.6065,-0.83549];
% prpRVE8 = [0.18307,-0.11144];
% prmELF3 = [0.052098,-0.60882,-0.3643];
% prpELF3 = [1.7298,-2.0074];
% prmELF4 = [0.0076627,-1.067,-0.54173,-0.77971];
% prpELF4 = [1.0082,-0.73483];
% prmLUX = [0.0018699,-1.4807,-0.66399,-0.77758];
% prpLUX = [0.90423,-0.74014];
% prmGI = [0.015731,-0.48325,-0.64261,-0.41366,-0.57824];
% prpGI = [0.18148,-0.054347,-0.13969];
% prpCOP1 = [0.64747,-0.73818,-0.55897];
% prpZTL = [0.41652,-1.5179,1.5742];

nonlineartheta = [prP prmLHY prpLHY prmPRR9 prpPRR9 prmPRR7 prpPRR7 prmPRR5 prpPRR5...
    prmTOC1 prpTOC1 prpEC prmRVE8 prpRVE8 prmELF3 prpELF3 prmELF4 prpELF4...
    prmLUX prpLUX prmGI prpGI prpCOP1 prpZTL];


theta = nonlineartheta;
GeneProteinLevelFull = [];

%% Data point indices
b12s0 = 1; e12s0 = 96; 

%% Initial condition

C = [0.3648,1.0000,0.3462,0.7572,0.4711,0.2090,...
    0.1105,0.0961,0.0020,0.0775,0.2202,0.0051,...
    1.0000,0.3333,0.4444,0.0294,0.0160,0.0044,...
    0.0236,0.0118,0.0065,0.2008,0.4556,0.1970,...
    0,0,0,0];

Cinit = [0.3648,1.0000,0.3462,0.7572,0.4711,0.2090,...
    0.1105,0.0961,0.0020,0.0775,0.2202,0.0051,...
    1.0000,0.3333,0.4444,0.0294,0.0160,0.0044,...
    0.0236,0.0118,0.0065,0.2008,0.4556,0.1970,...
    0,0,0,0];

for t = 1:length(Tlight)
    tspan = [t t+1];
    EL = Tlight(t);
    Rf = mprr9ref(t);
    if t == 1
        Rl = 0;
    else
        Rl = plhyref(t);
    end
    [T,C] = ode45('S3_MF2016KS_ODE',tspan,C(end,:));
    GeneProteinLevelFull = [GeneProteinLevelFull; C(end,:)];
end

GeneProteinLevelFull = [Cinit; GeneProteinLevelFull(2:end,:)];

%% Plotting

tp = 0:length(Tlight(b12s0:e12s0))-1;
figure(11)

subplot (8,3,1)
plot(tp,GeneProteinLevelFull(:,1)','LineWidth',1)
hold on
title('Light Protein')

subplot (8,3,2)
plot(tp,GeneProteinLevelFull(:,2)','LineWidth',1)
hold on
title('LHY mRNA')

subplot (8,3,3)
plot(tp,GeneProteinLevelFull(:,3)','LineWidth',1)
hold on
title('LHY Protein') 

subplot (8,3,4)
plot(tp,GeneProteinLevelFull(:,4)','LineWidth',1)
hold on
title('PRR9 mRNA')

subplot (8,3,5)
plot(tp,GeneProteinLevelFull(:,5)','LineWidth',1)
hold on
title('PRR9 Protein')

subplot (8,3,6)
plot(tp,GeneProteinLevelFull(:,6)','LineWidth',1)
hold on
title('PRR7 mRNA')

subplot (8,3,7)
plot(tp,GeneProteinLevelFull(:,7)','LineWidth',1)
hold on
title('PRR7 Protein')

subplot (8,3,8)
plot(tp,GeneProteinLevelFull(:,8)','LineWidth',1)
hold on
title('PRR5 mRNA')

subplot (8,3,9)
plot(tp,GeneProteinLevelFull(:,9)','LineWidth',1)
hold on
title('PRR5 Protein')

subplot (8,3,10)
plot(tp,GeneProteinLevelFull(:,10)','LineWidth',1)
hold on
title('TOC1 mRNA')

subplot (8,3,11)
plot(tp,GeneProteinLevelFull(:,11)','LineWidth',1)
hold on
title('TOC1 Protein')

subplot (8,3,12)
plot(tp,GeneProteinLevelFull(:,12)','LineWidth',1)
hold on
title('EC Complex')

subplot (8,3,13)
plot(tp,GeneProteinLevelFull(:,13)','LineWidth',1)
hold on
title('RVE8 mRNA')

subplot (8,3,14)
plot(tp,GeneProteinLevelFull(:,14)','LineWidth',1)
hold on
title('RVE8 Protein')

subplot (8,3,15)
plot(tp,GeneProteinLevelFull(:,15)','LineWidth',1)
hold on
title('ELF3 mRNA')

subplot (8,3,16)
plot(tp,GeneProteinLevelFull(:,16)','LineWidth',1)
hold on
title('ELF3 Protein')

subplot (8,3,17)
plot(tp,GeneProteinLevelFull(:,17)','LineWidth',1)
hold on
title('ELF4 mRNA')

subplot (8,3,18)
plot(tp,GeneProteinLevelFull(:,18)','LineWidth',1)
hold on
title('ELF4 Protein')

subplot (8,3,19)
plot(tp,GeneProteinLevelFull(:,19)','LineWidth',1)
hold on
title('LUX mRNA')

subplot (8,3,20)
plot(tp,GeneProteinLevelFull(:,20)','LineWidth',1)
hold on
title('LUX Protein')

subplot (8,3,21)
plot(tp,GeneProteinLevelFull(:,21)','LineWidth',1)
hold on
title('GI mRNA')

subplot (8,3,22)
plot(tp,GeneProteinLevelFull(:,22)','LineWidth',1)
hold on
title('GI Protein')

subplot (8,3,23)
plot(tp,GeneProteinLevelFull(:,23)','LineWidth',1)
hold on
title('COP1 Protein')

subplot (8,3,24)
plot(tp,GeneProteinLevelFull(:,24)','LineWidth',1)
hold on
title('ZTL Protein')

