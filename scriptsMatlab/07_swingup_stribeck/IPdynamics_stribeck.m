function Dx = IPdynamics_stribeck(x, u, params_stribeck)
    % x : stan
    % u : input - napięcie

    % State, function input: x = [x Dx theta Dtheta]'
    % x1 = x(1, :);
    x2 = x(2, :);
    x3 = x(3, :);
    x4 = x(4, :);

    params_stribeck = num2cell(params_stribeck);
    [alpha_dcm, beta_dcm, b_stri, gamma_stri, miu_c, miu_s, vs, M, mp, mc, Lp] = params_stribeck{:};
    
    g = 9.8145;
    Lc = 2*Lp;
    mr = mc + mp;
    Mt = mr + M;
    L = (Lc*mc + Lp*mp) / mr;
    Jcm = 0.3333333*mp*Lp^2 + mp*(L-Lp)^2 + mc*(L-Lc)^2;
    % Jcm = 1/12 * mp*Lp^2;
    Jt = Jcm + mr*L^2;
    
    i_i = 2;
    delta_ = 600;

    d = 0;

    Ff = (miu_c + (miu_s-miu_c)*exp(-(x3/vs).^i_i)) .* Mt.*g.*tanh(delta_.*x3) + b_stri.*x3;
    Fi = alpha_dcm*u - beta_dcm*x3;
    A = d*cos(x2) - Ff + L*mr*x4.^2.*sin(x2) + Fi;
    B = d*Lc + L*g*mr*sin(x2) - gamma_stri*x4;
    DEN = Jt*Mt - (L*mr*cos(x2)).^2;
    
    ddt_x1 = x3;
    ddt_x2 = x4;
    ddt_x3 = (Jt*A - L*mr*cos(x2).*B) ./ DEN;
    ddt_x4 = (Mt*B - L*mr*cos(x2).*A) ./ DEN;
    
    % output
    Dx = [ddt_x1; ddt_x2; ddt_x3; ddt_x4];
end   

