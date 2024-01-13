%% Params
M = 0.416 ; mc = 0; mp = 0.089;
Lp = 0.113 / 2; Lc = 2*Lp; % 
g = 9.8145; 
b_lepkie = 1.5; gamma_ = 0.005;
% obliczone parametry
mr = mc + mp;
Mt = mr + M;
L  = (Lc*mc + Lp*mp) / mr;
Jcm = (L^2)*mr + (Lc^2)*mc + 4/3 * (Lp^2)*mp;
Jt  = Jcm + mr*L^2;
alpha_ = 1.719;
beta_ = 7.682;
% dodatkowe parametry do tarcia stribecka
miu_c = 0.0861; 
miu_s = 0.04287; 
vs = 0.105; 
i_ = 2; 
b_stribeck = 3;
delta_ = 400; % do tanh zamiast signum

params_lepkie = [M, mc, mp, Lp, Lc, g, b_lepkie, gamma_, mr, Mt, L, Jcm, Jt, alpha_, beta_];
params_stribeck = [M, mc, mp, Lp, Lc, g, b_stribeck, gamma_, mr, Mt, L, Jcm, Jt, alpha_, beta_, miu_c, miu_s, vs, i_, delta_];

%%
% save('model_params')