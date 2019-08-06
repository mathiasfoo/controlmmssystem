clc
clear all

global EL theta Rf Rl Ki Kp gSb gSm


load kernel2015mprr9ref.mat

%% Defining Light Condition
Tsp = 10;
T_12 = [ones(1,120) zeros(1,120)]; T_12 = repmat(T_12,1,4); T_12 = T_12(1:Tsp:end);

Tlight = T_12;

%% Model Parameter

% % Base value from Foo et al (2016)
% prP = [-0.43301,-0.4949,0.4358];
% prmLHY = [1.9601,0.7412,0.3821,0.52644,1.3764,11.6884,-2.7804];
% prpLHY = [0.83604,-0.64719];
% prmPRR9 = [0.73369,0.75976,1.3352,-0.59706];
% prpPRR9 = [0.50077,-0.22337];
% prmPRR7 = [0.0099478,0.034076,0.87726,-0.23934];
% prpPRR7 = [0.23744,-0.18571];
% prmPRR5 = [0.026728,0.13201,0.031588,-40.9795];
% prpPRR5 = [4.0753,-2.5872];
% prmTOC1 = [0.01501,0.036926,0.011307,-12.2192];
% prpTOC1 = [0.40049,-0.31171];
% prpEC = [0.80816,-0.37854];
% prmRVE8 = [2.2417,1.4074,11.6684,-1.5159];
% prpRVE8 = [0.32848,-0.14877];
% prmELF3 = [0.014607,0.23392,-0.27265];
% prpELF3 = [14.0123,-17.3569];
% prmELF4 = [0.014384,0.032117,0.051737,-11.007];
% prpELF4 = [0.67365,-0.39718];
% prmLUX = [0.028907,0.01727,0.034063,-26.4166];
% prpLUX = [2.461,-1.4794];
% prmGI = [0.0002445,0.072434,0.11811,0.456,-0.58448];
% prpGI = [0.40246,-0.78572,-0.020811];
% prpCOP1 = [-0.80938,-0.8102,0.91424];
% prpZTL = [2.3354,1.275,1.5983,-0.44539,0.027925];

% % mPRR9 ~100 
% prP = [-0.43402,-0.49605,0.43524];
% prmLHY = [1.9647,0.74065,0.38152,0.52766,1.3748,11.6658,-2.7771];
% prpLHY = [0.83798,-0.64637];
% prmPRR9 = [0.86681,28.4337,10.0232,-0.52661];
% prpPRR9 = [0.50038,-0.22389];
% prmPRR7 = [0.0099379,0.034155,0.8793,-0.2399];
% prpPRR7 = [0.23718,-0.18614];
% prmPRR5 = [0.026679,0.13232,0.031546,-41.0746];
% prpPRR5 = [4.0683,-2.5932];
% prmTOC1 = [0.015028,0.036866,0.011333,-12.2165];
% prpTOC1 = [0.40098,-0.31122];
% prpEC = [0.81004,-0.37942];
% prmRVE8 = [2.2469,1.4107,11.6955,-1.5194];
% prpRVE8 = [0.32924,-0.14912];
% prmELF3 = [0.014602,0.23371,-0.27328];
% prpELF3 = [14.0035,-17.3972];
% prmELF4 = [0.014376,0.032192,0.049203,-11.0326];
% prpELF4 = [0.6734,-0.3981];
% prmLUX = [0.028887,0.01731,0.034142,-26.4779];
% prpLUX = [2.4598,-1.4828];
% prmGI = [0.00024507,0.072602,0.11838,0.45706,-0.58584];
% prpGI = [0.40339,-0.78754,-0.020859];
% prpCOP1 = [-0.81126,-0.81208,0.91636];
% prpZTL = [2.3408,1.278,1.602,-0.44642,0.02799];

% % mPRR9 ~10 (MSE = 0.0141) (new value)
% prP = [-0.4339,-0.49592,0.43518];
% prmLHY = [1.9628,0.74044,0.38182,0.52627,1.3758,11.6736,-2.7775];
% prpLHY = [0.8372,-0.64657];
% prmPRR9 = [1.0294,0.92444,3.1688,-0.43447];
% prpPRR9 = [0.50043,-0.22383];
% prmPRR7 = [0.0099445,0.034146,0.87892,-0.23983];
% prpPRR7 = [0.23721,-0.18609];
% prmPRR5 = [0.026701,0.13218,0.031552,-41.057];
% prpPRR5 = [4.0705,-2.5925];
% prmTOC1 = [0.015016,0.036891,0.01133,-12.2168];
% prpTOC1 = [0.40064,-0.31144];
% prpEC = [0.80939,-0.37926];
% prmRVE8 = [2.2463,1.4103,11.6924,-1.519];
% prpRVE8 = [0.32916,-0.14908];
% prmELF3 = [0.014604,0.23381,-0.27321];
% prpELF3 = [14.0072,-17.3506];
% prmELF4 = [0.014382,0.032183,0.051738,-11.0051];
% prpELF4 = [0.65749,-0.398];
% prmLUX = [0.028898,0.017306,0.03411,-26.4004];
% prpLUX = [2.4609,-1.4797];
% prmGI = [0.000245,0.072583,0.11835,0.45694,-0.58568];
% prpGI = [0.40329,-0.78734,-0.020854];
% prpCOP1 = [-0.81105,-0.81187,0.91612];
% prpZTL = [2.3402,1.2776,1.6016,-0.44631,0.027982];

% % mPRR9 ~0.1 
% prP = [-0.43445,-0.49654,0.43495];
% prmLHY = [1.9666,0.73923,0.3813,0.52615,1.3744,11.659,-2.7726];
% prpLHY = [0.83881,-0.64587];
% prmPRR9 = [1.0644,0.080464,0.31728,-0.50569];
% prpPRR9 = [0.50044,-0.22411];
% prmPRR7 = [0.0099346,0.034189,0.88017,-0.24013];
% prpPRR7 = [0.23707,-0.18633];
% prmPRR5 = [0.026665,0.13245,0.03149,-40.992];
% prpPRR5 = [4.0662,-2.5958];
% prmTOC1 = [0.015011,0.036859,0.011344,-12.2206];
% prpTOC1 = [0.4005,-0.31092];
% prpEC = [0.81084,-0.3798];
% prmRVE8 = [2.1341,1.4121,11.7071,-1.5209];
% prpRVE8 = [0.32957,-0.14926];
% prmELF3 = [0.014655,0.23352,-0.27269];
% prpELF3 = [14.0588,-17.336];
% prmELF4 = [0.014432,0.032111,0.051749,-10.9962];
% prpELF4 = [0.67588,-0.39714];
% prmLUX = [0.029003,0.017327,0.034062,-26.3877];
% prpLUX = [2.4692,-1.4781];
% prmGI = [0.00024462,0.072674,0.1185,0.45751,-0.58642];
% prpGI = [0.40268,-0.78833,-0.02088];
% prpCOP1 = [-0.80993,-0.81289,0.9148];
% prpZTL = [2.3363,1.2792,1.6036,-0.44687,0.028018];

% % mPRR9 ~0.01 
% prP = [-0.43368,-0.49566,0.41412];
% prmLHY = [1.9631,0.74038,0.38269,0.52725,1.3785,11.7065,-2.7771];
% prpLHY = [0.83733,-0.64639];
% prmPRR9 = [1.1728,0.019641,0.10015,-0.45202];
% prpPRR9 = [0.50154,-0.22372];
% prmPRR7 = [0.0099632,0.034129,0.87862,-0.23971];
% prpPRR7 = [0.23781,-0.186];
% prmPRR5 = [0.026769,0.13221,0.031543,-41.0428];
% prpPRR5 = [4.0816,-2.5912];
% prmTOC1 = [0.01499,0.036983,0.011324,-12.2381];
% prpTOC1 = [0.40023,-0.31124];
% prpEC = [0.80941,-0.37913];
% prmRVE8 = [2.2452,1.4096,11.6864,-1.5182];
% prpRVE8 = [0.32899,-0.149];
% prmELF3 = [0.01463,0.23428,-0.27307];
% prpELF3 = [14.034,-17.3837];
% prmELF4 = [0.014406,0.032167,0.051817,-11.024];
% prpELF4 = [0.67469,-0.39779];
% prmLUX = [0.028952,0.017297,0.034116,-26.4574];
% prpLUX = [2.4648,-1.4817];
% prmGI = [0.00024488,0.072546,0.11829,0.4567,-0.58538];
% prpGI = [0.40308,-0.78693,-0.020843];
% prpCOP1 = [-0.81063,-0.81145,0.91565];
% prpZTL = [2.339,1.277,1.6008,-0.44608,0.027968];

% % mPRR9 ~0.001
prP = [-0.43301,-0.4949,0.4358];
prmLHY = [1.9601,0.7412,0.3821,0.52644,1.3764,11.6884,-2.7804];
prpLHY = [0.83604,-0.64719];
prmPRR9 = [1.1875,0.0067347,0.031623,-0.42847];
prpPRR9 = [0.50077,-0.22337];
prmPRR7 = [0.0099478,0.034076,0.87726,-0.23934];
prpPRR7 = [0.23744,-0.18571];
prmPRR5 = [0.026728,0.13201,0.031588,-40.9795];
prpPRR5 = [4.0753,-2.5872];
prmTOC1 = [0.01501,0.036926,0.011307,-12.2192];
prpTOC1 = [0.40049,-0.31171];
prpEC = [0.80816,-0.37854];
prmRVE8 = [2.2417,1.4074,11.6684,-1.5159];
prpRVE8 = [0.32848,-0.14877];
prmELF3 = [0.014607,0.23392,-0.27265];
prpELF3 = [14.0123,-17.3569];
prmELF4 = [0.014384,0.033723,0.051737,-11.007];
prpELF4 = [0.70733,-0.39718];
prmLUX = [0.028907,0.01727,0.034063,-26.4166];
prpLUX = [2.461,-1.4794];
prmGI = [0.0002445,0.072434,0.11811,0.456,-0.58448];
prpGI = [0.40246,-0.78572,-0.020811];
prpCOP1 = [-0.80938,-0.8102,0.91424];
prpZTL = [2.3354,1.275,1.5983,-0.44539,0.027925];

Ki = 0.3;
Kp = 4.5;
gSb = 50;
gSm = 200;

nonlineartheta = [prP prmLHY prpLHY prmPRR9 prpPRR9 prmPRR7 prpPRR7 prmPRR5 prpPRR5...
    prmTOC1 prpTOC1 prpEC prmRVE8 prpRVE8 prmELF3 prpELF3 prmELF4 prpELF4...
    prmLUX prpLUX prmGI prpGI prpCOP1 prpZTL];

theta = nonlineartheta;
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

GeneProteinLevelFull = [];

for t = 1:length(Tlight)
    tspan = [t t+1];
    EL = Tlight(t);        
    Rf = mprr9ref(t);
    if t == 1
        Rl = 0;
    else
        Rl = plhyref(t);
    end
    [T,C] = ode45('S3_MF2016KMM_ODE',tspan,C(end,:));
    GeneProteinLevelFull = [GeneProteinLevelFull; C(end,:)];
end

GeneProteinLevelFull = [Cinit; GeneProteinLevelFull(2:end,:)];

%% Plotting

tp = 0:length(Tlight(b12s0:e12s0))-1;

figure(1111)
subplot (8,3,1)
plot(tp,GeneProteinLevelFull(:,1),'LineWidth',1)
hold on
grid on
title('Protein P')

subplot (8,3,2)
plot(tp,GeneProteinLevelFull(:,2),'LineWidth',1)
hold on
grid on
title('mLHY')

subplot (8,3,3)
plot(tp,GeneProteinLevelFull(:,3),'LineWidth',1)
hold on
grid on
title('pLHY')

subplot (8,3,4)
plot(tp,GeneProteinLevelFull(:,4),'LineWidth',1)
hold on
plot(tp,mprr9ref(b12s0:e12s0),'LineWidth',1)
grid on
title('mPRR9')

subplot (8,3,5)
plot(tp,GeneProteinLevelFull(:,5),'LineWidth',1)
hold on
grid on
title('pPRR9')

subplot (8,3,6)
plot(tp,GeneProteinLevelFull(:,6),'LineWidth',1)
hold on
grid on
title('mPRR7')

subplot (8,3,7)
plot(tp,GeneProteinLevelFull(:,7),'LineWidth',1)
hold on
grid on
title('pPRR7')

subplot (8,3,8)
plot(tp,GeneProteinLevelFull(:,8),'LineWidth',1)
hold on
grid on
title('mPRR5')

subplot (8,3,9)
plot(tp,GeneProteinLevelFull(:,9),'LineWidth',1)
hold on
grid on
title('pPRR5')

subplot (8,3,10)
plot(tp,GeneProteinLevelFull(:,10),'LineWidth',1)
hold on
grid on
title('mTOC1')

subplot (8,3,11)
plot(tp,GeneProteinLevelFull(:,11),'LineWidth',1)
hold on
grid on
title('pTOC1')

subplot (8,3,12)
plot(tp,GeneProteinLevelFull(:,12),'LineWidth',1)
hold on
grid on
title('pEC')

subplot (8,3,13)
plot(tp,GeneProteinLevelFull(:,13),'LineWidth',1)
hold on
grid on
title('mRVE8')

subplot (8,3,14)
plot(tp,GeneProteinLevelFull(:,14),'LineWidth',1)
hold on
grid on
title('pRVE8')

subplot (8,3,15)
plot(tp,GeneProteinLevelFull(:,15),'LineWidth',1)
hold on
grid on
title('mELF3')

subplot (8,3,16)
plot(tp,GeneProteinLevelFull(:,16),'LineWidth',1)
hold on
grid on
title('pELF3')

subplot (8,3,17)
plot(tp,GeneProteinLevelFull(:,17),'LineWidth',1)
hold on
grid on
title('mELF4')

subplot (8,3,18)
plot(tp,GeneProteinLevelFull(:,18),'LineWidth',1)
hold on
grid on
title('pELF4')

subplot (8,3,19)
plot(tp,GeneProteinLevelFull(:,19),'LineWidth',1)
hold on
grid on
title('mLUX')

subplot (8,3,20)
plot(tp,GeneProteinLevelFull(:,20),'LineWidth',1)
hold on
grid on
title('pLUX')

subplot (8,3,21)
plot(tp,GeneProteinLevelFull(:,21),'LineWidth',1)
hold on
grid on
title('mGI')

subplot (8,3,22)
plot(tp,GeneProteinLevelFull(:,22),'LineWidth',1)
hold on
grid on
title('pGI')

subplot (8,3,23)
plot(tp,GeneProteinLevelFull(:,23),'LineWidth',1)
hold on
grid on
title('pCOP1')

subplot (8,3,24)
plot(tp,GeneProteinLevelFull(:,24),'LineWidth',1)
hold on
grid on
title('pZTL')

