function dC = S3_MF2016KMM_ODE(t,C)


global EL theta Rf Rl Ki Kp gSb gSm

hc = 2;

dC = zeros(24,1);

% Protein P
dC(1) = real(theta(1)*EL + theta(2)*C(1) + theta(3));

% LHY mRNA
dC(2) = real(theta(4)./(theta(5).^hc + theta(6).*(theta(7).*C(5) + theta(8).*C(7) + theta(9).*C(9)).^hc)...
    + theta(10)*C(2));

% LHY protein
dC(3) = real(theta(11)*C(2) + theta(12)*C(3));
 
% PRR9 mRNA
dC(4) = real(theta(13)*C(1)*EL + theta(14)*1*C(28).^hc./(theta(15).^hc + 1*C(28).^hc)...
    + theta(16)*C(4));
 
% PRR9 protein
dC(5) = real(theta(17)*C(4) + theta(18)*C(5));

% PRR7 mRNA
dC(6) = real(theta(19)./((theta(20) + C(12)).*(theta(21).^hc + C(11).^hc)) + theta(22)*C(6));

% PRR7 protein
dC(7) = real(theta(23)*C(6) + theta(24)*C(7));

% PRR5 mRNA
dC(8) = real(theta(25)./((theta(26).^hc + C(11).^hc).*(theta(27).^hc + C(3).^hc)) + theta(28)*C(8));

% PRR5 protein
dC(9) = real(theta(29)*C(8) + theta(30)*C(9));

% TOC1 mRNA
dC(10) = real(theta(31)./((theta(32) + C(12)).*(theta(33).^hc + C(3).^hc)) + 1*theta(34)*C(10));

% TOC1 protein
dC(11) = real(theta(35)*C(10) + theta(36)*C(11));

% EC protein
dC(12) = real(theta(37)*(C(16).*C(18).*C(20)) + theta(38)*C(12));

% RVE8 mRNA
dC(13) = real(theta(39)./(theta(40).^hc + (theta(41).*C(9)).^hc) + theta(42)*C(13));

% RVE8 protein
dC(14) = real(theta(43)*C(13) + theta(44)*C(14));

% ELF3 mRNA
dC(15) = real(theta(45)./(theta(46).^hc + C(3).^hc) + theta(47)*C(15));

% ELF3 protein
dC(16) = real(theta(48)*C(15) + theta(49)*C(16));

% ELF4 mRNA
dC(17) = real(theta(50)./((theta(51) + C(12)).*(theta(52).^hc + C(3).^hc)) + theta(53)*C(17));

% ELF4 protein
dC(18) = real(theta(54)*C(17) + theta(55)*C(18));

% LUX mRNA
dC(19) = real(theta(56)./((theta(57) + C(12)).*(theta(58).^hc + C(3).^hc)) + theta(59)*C(19));

% LUX protein
dC(20) = real(theta(60)*C(19) + theta(61)*C(20));

% GI mRNA
dC(21) = real(theta(62)./((theta(63).^hc + C(3).^hc).*(theta(64).^hc + C(11).^hc).*(theta(65).^hc + C(16).^hc)) ...
    + theta(66)*C(21));

% GI protein
dC(22) = real(theta(67)*C(21) + theta(68)*C(16).*C(23).*C(22) + theta(69)*C(22));

% COP1 protein
dC(23) = real(theta(70)*EL + theta(71)*C(23) + theta(72));

% ZTL protein
dC(24) = real((theta(73)*C(24)*C(22))./(1 + theta(74).*C(24) + theta(75).*C(22)) ...
    + theta(76)*C(24) + theta(77));

%% Feedback control

dC(25) = (gSb)*(Rf - C(4) - C(25));

dC(26) = (Ki)*C(25);

dC(27) = (Kp)*C(25) - C(27);

dC(28) = (gSm)*(C(26) + C(27) - C(28));