function dC = S3_MF2016KS_ODE(t,C)


global EL theta Rf Rl Ki Kp gSb gSm


dC = zeros(24,1);

% Protein P
dC(1) = real(theta(1) + theta(2)*C(1) + theta(3)*EL);

% LHY mRNA
dC(2) = real(theta(4)*(C(5) + C(7) + C(9))^(theta(5)) + theta(6)*C(2));

% LHY protein
dC(3) = real(theta(7)*C(2) + theta(8)*C(3));
 
% PRR9 mRNA
dC(4) = real(theta(9)*C(28)^(theta(10)) + theta(11)*C(4) + theta(12)*C(1)*EL);

% PRR9 protein
dC(5) = real(theta(13)*C(4) + theta(14)*C(5));

% PRR7 mRNA
dC(6) = real(theta(15)*C(11)^(theta(16))*C(12)^(theta(17)) + theta(18)*C(6));

% PRR7 protein
dC(7) = real(theta(19)*C(6) + theta(20)*C(7));

% PRR5 mRNA
dC(8) = real(theta(21)*C(3)^(theta(22))*C(11)^(theta(23)) + theta(24)*C(8));

% PRR5 protein
dC(9) = real(theta(25)*C(8) + theta(26)*C(9));

% TOC1 mRNA
dC(10) = real(theta(27)*C(3)^(theta(28))*C(12)^(theta(29)) + theta(30)*C(10));

% TOC1 protein
dC(11) = real(theta(31)*C(10) + theta(32)*C(11));

% EC protein
dC(12) = real(theta(33)*(C(16).*C(18).*C(20)) + theta(34)*C(12));

% RVE8 mRNA
dC(13) = real(theta(35)*C(9)^(theta(36)) + theta(37)*C(13));

% RVE8 protein
dC(14) = real(theta(38)*C(13) + theta(39)*C(14));

% ELF3 mRNA
dC(15) = real(theta(40)*C(3)^(theta(41)) + theta(42)*C(15));

% ELF3 protein
dC(16) = real(theta(43)*C(15) + theta(44)*C(16));

% ELF4 mRNA
dC(17) = real(theta(45)*C(3)^(theta(46))*C(12)^(theta(47)) + theta(48)*C(17));

% ELF4 protein
dC(18) = real(theta(49)*C(17) + theta(50)*C(18));

% LUX mRNA
dC(19) = real(theta(51)*C(3)^(theta(52))*C(12)^(theta(53)) + theta(54)*C(19));

% LUX protein
dC(20) = real(theta(55)*C(19) + theta(56)*C(20));

% GI mRNA
dC(21) = real(theta(57)*C(3)^(theta(58))*C(11)^(theta(59))*C(16)^(theta(60)) + theta(61)*C(21));

% GI protein
dC(22) = real(theta(62)*C(21) + theta(63)*C(22) + theta(64)*C(22)*C(16)*C(23));

% COP1 protein
dC(23) = real(theta(65) + theta(66)*C(23) + theta(67)*EL);

% ZTL protein
dC(24) = real(theta(68) + theta(69)*C(24) + theta(70)*C(24)*C(22));

%% Feedback control

dC(25) = (gSb)*(Rf - C(4) - C(25));

dC(26) = (Ki)*C(25);

dC(27) = (Kp)*C(25) - C(27);

dC(28) = (gSm)*(C(26) + C(27) - C(28));