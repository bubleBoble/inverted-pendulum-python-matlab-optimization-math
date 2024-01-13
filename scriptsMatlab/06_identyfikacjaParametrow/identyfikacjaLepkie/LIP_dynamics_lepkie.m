function dxdt = LIP_dynamics_lepkie(t, x, params, inputsig, end_time)
    x2 = x(2); 
    x3 = x(3);
    x4 = x(4);

    data_len = length(inputsig) - 1;
    n = round(t/end_time * data_len + 1);

    params_lepkie = num2cell(params);
    [M, mp, mc, Lp, B, gamma_lepkie, alpha_dcm]  = params_lepkie{:};

    g = 9.8145;
    Lc = 2*Lp;
    mr = mc + mp;
    Mt = mr + M;
    L = (Lc*mc + Lp*mp) / mr;
    Jcm = 1/12*mp*Lp;
    Jt = Jcm + mr*L^2;

    % Równania dynamiki wahadla
    u=inputsig(n); 
    d=0;
    A = d*cos(x2) + L*mr*x4^2*sin(x2) + alpha_dcm*u - B*x3;
    B = d*Lc + L*g*mr*sin(x2) - gamma_lepkie*x4;
    DEN = Jt*Mt - (L*mr*cos(x2))^2;

    dxdt(1) = x3;
    dxdt(2) = x4;
    dxdt(3) = (Jt*A - L*mr*cos(x2)*B) / DEN;
    dxdt(4) = (Mt*B - L*mr*cos(x2)*A) / DEN;
    dxdt = dxdt';
end