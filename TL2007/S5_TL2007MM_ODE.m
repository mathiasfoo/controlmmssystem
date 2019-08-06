function dC = S5_TL2007MM_ODE(t,C)


global theta Rf Ki Kp gE gS

dC = zeros(16,1);

% mCLK
dC(1) = theta(1)/(theta(2)^2 + (C(4) + theta(3)*C(16))^2) - theta(4)*C(1)/(theta(5) + C(1)) - theta(6)*C(1);

% pCLK
dC(2) = theta(7)*C(1) - theta(8)*C(2)/(theta(9) + C(2)) - theta(10)*C(2)/(theta(11) + C(2)) - theta(12)*C(2);

% pcCLK/CYC
dC(3) = theta(13)*C(2)/(theta(14) + C(2)) - theta(15)*C(3)/(theta(16) + C(3)) - theta(17)*C(3)/(theta(18) + C(3)) - theta(19)*C(3);

% pnCLK/CYC
dC(4) = theta(20)*C(3)/(theta(21) + C(3)) - theta(22)*C(4)*C(13) + theta(23)*C(15) - theta(24)*C(4)/(theta(25) + C(4)) - theta(26)*C(4);

% mPER
dC(5) = theta(27)*(C(20))^2/(theta(29)^2 + (C(20))^2) - theta(31)*C(5)/(theta(32) + C(5)) - theta(33)*C(5);

% mTIM
dC(6) = theta(34)*(C(4) + theta(35)*C(16))^2/(theta(36)^2 + (C(4) + theta(37)*C(16))^2) - theta(38)*C(6)/(theta(39) + C(6)) - theta(40)*C(6);

% pcPER
dC(7) = theta(41)*C(5) - theta(42)*C(7)*C(8) - theta(43)*C(7) + theta(44)*C(9) - theta(45)*C(7)/(theta(46) + C(7)) - theta(47)*C(7);

% pcTIM
dC(8) = theta(48)*C(6) - theta(49)*C(7)*C(8) - theta(50)*C(8) - theta(51)*C(8)/(theta(52) + C(8)) - theta(53)*C(8);

% pPER/TIM
dC(9) = theta(54)*C(7)*C(8) - theta(55)*C(9)/(theta(56) + C(9)) + theta(57)*C(10)/(theta(58) + C(10)) - theta(59)*C(9) - theta(60)*C(9)/(theta(61) + C(9)) - theta(62)*C(9);

% pphPER/TIM
dC(10) = theta(63)*C(9)/(theta(64) + C(9)) - theta(65)*C(10)/(theta(66) + C(10)) - theta(67)*C(10) - theta(68)*C(10) - theta(69)*C(10)/(theta(70) + C(10)) - theta(71)*C(10);

% pcphpPER
dC(11) = theta(72)*C(10) - theta(73)*C(11) + theta(74)*C(10) - theta(75)*C(11)/(theta(76) + C(11)) - theta(77)*C(11);

% pcphpTIM
dC(12) = theta(78)*C(10) - theta(79)*C(12) - theta(80)*C(12) - theta(81)*C(12)/(theta(82) + C(12)) - theta(83)*C(12);

% pnPER
dC(13) = theta(84)*C(7) + theta(85)*C(11) + theta(86)*C(15) - theta(87)*C(4)*C(13) - theta(88)*C(13)/(theta(89) + C(13)) - theta(90)*C(13);

% pnTIM
dC(14) = theta(91)*C(12) - theta(92)*C(14) - theta(93)*C(14)*C(15) + theta(94)*C(16) - theta(95)*C(14)/(theta(96) + C(14)) - theta(97)*C(14);

% pPER/CLK/CYC
dC(15) = theta(98)*C(4)*C(13) - theta(99)*C(15) - theta(100)*C(14)*C(15) + theta(101)*C(16) + theta(102)*C(16) - theta(103)*C(15)/(theta(104) + C(15)) - theta(105)*C(15);

% pPER/TIM/CLK/CYC
dC(16) = theta(106)*C(14)*C(15) - theta(107)*C(16) - theta(108)*C(16) - theta(109)*C(16)/(theta(110) + C(16)) - theta(111)*C(16);


%% Controller
dC(17) = gE*(Rf - C(5) - C(17));

dC(18) = Ki*C(17);

dC(19) = Kp*C(17) - C(19);

dC(20) = gS*(C(18) + C(19) - C(20));