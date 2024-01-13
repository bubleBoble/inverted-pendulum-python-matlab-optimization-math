optym_M  = [0.4178;0.4202;0.4118;0.4118;0.4118;0.4160];
optym_mp = [0.0881;0.0899;0.0881;0.0892;0.0881;0.0890];
optym_mc = [0;0;0;0;0;0;];
optym_Lp = [0.1213;0.1213;0.1213;0.1213;0.1213;0.1225];
optym_B  = [26.5928;23.8970;23.1800;23.1077;23.1016;23.1000];
optym_gm = [0.0087;0.0048;0.0028;0.0018;0.0014;0.0014];
optym_al = [1.5400;1.5400;1.5400;1.5400;1.5400;1.5500];

%{
    Kolumny: M, mp, mc, Lp, B, gamma, alfha

    Rząd 1 - 2V skok
    Rząd 2 - 4V skok
    Rząd 3 - 6V skok
    Rząd 4 - 8V skok
    Rząd 5 - 10V skok
    Rząd 6 - 12V skok
%}
params = [optym_M, optym_mp , optym_mc, optym_Lp, optym_B, optym_gm, optym_al];

mean(params)