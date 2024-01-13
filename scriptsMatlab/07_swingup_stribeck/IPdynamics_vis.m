function dx = IPdynamics_vis(x, u, params_lepkie)
    % x : stan
    % u : input - napięcie

    % Stan: x = [x Dx theta Dtheta]'
    % x1 = x(1, :);
    x2 = x(2, :); 
    x3 = x(3, :);
    x4 = x(4, :);

    % Parametry modelu.
    params_lepkie = num2cell(params_lepkie);
    [Bp, gamma_vis, alpha_dcm, M, mp, mc, Lp] = params_lepkie{:};

    g = 9.8145;
    Lc = 2*Lp;
    mr = mc + mp;
    Mt = mr + M;
    L = (Lc*mc + Lp*mp) / mr;
    Jcm = 0.3333333*mp*Lp^2 + mp*(L-Lp)^2 + mc*(L-Lc)^2;
    Jt = Jcm + mr*L^2;

    % Zerowe zakłócenie.
    d = 0;

    % Dynamika wahadła, tarcie lepkie.
    A = d*cos(x2) + L*mr*x4.^2 .*sin(x2) - Bp*x3 + alpha_dcm*u; % odpowiednio zmienione żeby używać B=b+beta
    B = d*Lc + L*g*mr*sin(x2) - gamma_vis*x4;
    DEN = Jt*Mt - (L*mr*cos(x2)).^2;
    
    ddt_x1 = x3;
    ddt_x2 = x4;
    ddt_x3 = (Jt*A - L*mr*cos(x2).*B) ./ DEN;
    ddt_x4 = (Mt*B - L*mr*cos(x2).*A) ./ DEN;
    
    % Pochodna wektora stanu.
    dx = [ddt_x1; ddt_x2; ddt_x3; ddt_x4];
end   