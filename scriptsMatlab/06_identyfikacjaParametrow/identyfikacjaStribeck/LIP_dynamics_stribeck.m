function dxdt = LIP_dynamics_stribeck(t, x, params, inputsig, end_time)
    % x1 = x(1);
    x2 = x(2); 
    x3 = x(3);
    x4 = x(4);

    % Index dla wymuszenia
    data_len = length(inputsig) - 1;
    n = round(t/end_time * data_len + 1);

    params_stribeck = num2cell(params);
    [M, mp, mc, Lp, alpha_dcm, B, gamma_str, miu_c, miu_s, vs] = params_stribeck{:};
    Lc = 2*Lp;
    mr = mc + mp;
    Mt = mr + M;
    L = (Lc*mc + Lp*mp) / mr;
    Jcm = 1/12*mp*Lp^2;
    Jt = Jcm + mr*L^2;
    i_i = 2;
    delta_ = 600;
    g = 9.8145;
    u=inputsig(n); 
    d=0;
    
    % Równania dynamiki wahadla
    % Ff = (miu_c + (miu_s-miu_c)*exp(-(x3/vs)^i_i)) * Mt*g*tanh(delta_*x3) + b_str*x3;
    % Fi = alpha_dcm*u - beta_dcm*x3;
    Ff = (miu_c + (miu_s-miu_c)*exp(-(x3/vs)^i_i)) * Mt*g*tanh(delta_*x3);
    Fi = alpha_dcm*u;
    A = d*cos(x2) - Ff + L*mr*x4^2*sin(x2) + Fi - B*x3;
    B = d*Lc + L*g*mr*sin(x2) - gamma_str*x4;
    DEN = Jt*Mt - (L*mr*cos(x2))^2;

    dxdt(1) = x3;
    dxdt(2) = x4;
    dxdt(3) = (Jt*A - L*mr*cos(x2)*B) / DEN;
    dxdt(4) = (Mt*B - L*mr*cos(x2)*A) / DEN;
    dxdt = dxdt';
end