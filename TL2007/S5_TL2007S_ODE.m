function dC = S5_TL2007S_ODE(t,C)


global theta Rf Ki Kp gE gS


dC = zeros(16,1);

% mCLK
dC(1) = real(theta(1)*(C(4) + theta(2)*C(16))^(-theta(3)) - theta(4)*C(1));

% pCLK
dC(2) = real(theta(5)*C(1) - theta(6)*C(2));

% pcCLK/CYC
dC(3) = real(theta(7)*C(2)^theta(8) - theta(9)*C(3));

% pnCLK/CYC
dC(4) = real(theta(10)*C(3)^(theta(11)) - theta(12)*C(4) - theta(13)*C(4)*C(13) + theta(14)*C(15));

% mPER
dC(5) = real(theta(15)*(C(20))^(theta(17)) - theta(18)*C(5));

% mTIM
dC(6) = real(theta(19)*(C(4) + theta(20)*C(16))^(theta(21)) - theta(22)*C(6));

% pcPER
dC(7) = real(theta(23)*C(5)^(theta(24)) - theta(25)*C(7) - theta(26)*C(7)*C(8) + theta(27)*C(9));

% pcTIM
dC(8) = real(theta(28)*C(6)^(theta(29)) - theta(30)*C(8) - theta(31)*C(7)*C(8));

% pPER/TIM
dC(9) = real(theta(32)*(C(7)*C(8))^(theta(33)) - theta(34)*C(9));

% pphPER/TIM
dC(10) = real(theta(35)*C(9)^(theta(36)) - theta(37)*C(10));

% pcphpPER
dC(11) = real(theta(38)*C(10) - theta(39)*C(11));

% pcphpTIM
dC(12) = real(theta(40)*C(10) - theta(41)*C(12));

% pnPER
dC(13) = real(theta(42)*C(7)^(theta(43)) - theta(44)*C(13) - theta(45)*C(13)*C(4) + theta(46)*C(15) + theta(47)*C(11));

% pnTIM
dC(14) = real(theta(48)*C(12)^(theta(49)) - theta(50)*C(14) - theta(51)*C(14)*C(15) + theta(52)*C(16));

% pPER/CLK/CYC
dC(15) = real(theta(53)*C(4)*C(13) - theta(54)*C(15) - theta(55)*C(14)*C(15) + theta(56)*C(16));

% pPER/TIM/CLK/CYC
dC(16) = real(theta(57)*C(14)*C(15) - theta(58)*C(16));


%% Controller
dC(17) = gE*(Rf - C(5) - C(17));

dC(18) = Ki*C(17);

dC(19) = Kp*C(17) - C(19);

dC(20) = gS*(C(18) + C(19) - C(20));