function dC = S4_AD2015MM_ODE(t,C)


global theta Rf Ki Kp gE gS

dC = zeros(9,1);

% mFRQ
dC(1) = theta(1)*C(13)^6/(theta(2) + C(13)^6) - theta(3)*C(1);

% pcFRQ
dC(2) = theta(4)*C(1) - theta(5)*C(2);

% pnFRQ
dC(3) = theta(6)*C(2) + theta(7)*C(7) - theta(8)*C(3) - theta(9)*C(3)*C(6);

% mWC1
dC(4) = theta(10)/(theta(11) + C(9)) - theta(12)*C(4);

% pcWC1
dC(5) = (theta(13)*C(2)^2/(theta(14) + C(2)^2))*(C(4)/(theta(15) + C(4))) - theta(16)*C(5);

% pnWC1
dC(6) = theta(17)*C(5) - theta(18)*C(6) - theta(19)*C(3)*C(6) + theta(20)*C(7);

% pFRQWC1
dC(7) = theta(21)*C(3)*C(6) - theta(22)*C(7);

% mCSP1
dC(8) = theta(23)*C(6)/(theta(24) + C(9)) - theta(25)*C(8);

% pCSP1
dC(9) = theta(26)*C(8) - theta(27)*C(9);

%% Controller
dC(10) = gE*(Rf - C(1) - C(10));

dC(11) = Ki*C(10);

dC(12) = Kp*(C(10) - C(12));

dC(13) = gS*(C(11) + C(12) - C(13));