
switch ktory_model
    case 'lepki dol'
        % Dla lekpiego takie zmienne trzeba zimportować
        load(params_id_on, "params_optim", "const_params");
        const_params = num2cell(const_params);
       
        [B, gamma, alpha_dcm] = params_optim{:};
        [M, mp, mc, Lp] = const_params{:};
      
        g = 9.8145;
        Lc = 2*Lp;
        mr = mc + mp;
        Mt = mr + M;
        L = (Lc*mc + Lp*mp) / mr;
        Jcm = 0.3333333*mp*Lp^2 + mp*(L-Lp)^2 + mc*(L-Lc)^2;
        Jt = Jcm + mr*L^2;

        den = Jt*Mt-(L*mr)^2;
        a1 = -(L^2)*g*(mr^2)/den;
        a2 = -Jt*B/den;
        a3 = -L*gamma*mr/den;
        a4 = -L*Mt*g*mr/den;
        a5 = -L*mr*B/den;
        a6 = -Mt*gamma/den;
        b1 = Jt*alpha_dcm/den;
        b2 = L*mr*alpha_dcm/den;
        h1 = (-Jt+L*Lc*mr)/den;
        h2 = (Lc*Mt - L*mr)/den;
        
        A = [
            0  0  1  0;
            0  0  0  1; 
            0  a1 a2 a3;
            0  a4 a5 a6;
        ];
        B = [0;0;b1;b2];
        H = [0;0;h1;h2];

    case 'lepki gora'
        % Dla lekpiego takie zmienne trzeba zimportować
        load(params_id_on, "params_optim", "const_params");
        const_params = num2cell(const_params);

        [B, gamma, alpha_dcm] = params_optim{:};
        [M, mp, mc, Lp] = const_params{:};
        
        g = 9.8145;
        Lc = 2*Lp;
        mr = mc + mp;
        Mt = mr + M;
        L = (Lc*mc + Lp*mp) / mr;
        Jcm = 0.3333333*mp*Lp^2 + mp*(L-Lp)^2 + mc*(L-Lc)^2;
        Jt = Jcm + mr*L^2;

        den = Jt*Mt-(L*mr)^2;
        a1 = -(L^2)*g*(mr^2)/den;
        a2 = -Jt*B/den;
        a3 = -L*gamma*mr/den;
        a4 = -L*Mt*g*mr/den;
        a5 = -L*mr*B/den;
        a6 = -Mt*gamma/den;
        b1 = Jt*alpha_dcm/den;
        b2 = L*mr*alpha_dcm/den;
        h1 = (-Jt+L*Lc*mr)/den;
        h2 = (Lc*Mt - L*mr)/den;

        A = [
            0  0  1  0;
            0  0  0  1; 
            0  a1 a2 -a3;
            0  -a4 -a5 a6;
        ];
        B = [0;0;b1;-b2];
        H = [0;0;-h1;h2];
        
    case 'stribeck dol'
        % Dla stribecka tak nazwałem te zmienne (przez przypadek)
        load(params_id_on, "params_optim", "params_const");
        params_const = num2cell(params_const);

        [alpha_dcm, beta_dcm, b_stri, gamma, miu_c, miu_s, vs] = params_optim{:};
        [M, mp, mc, Lp] = params_const{:};
        
        g = 9.8145;
        Lc = 2*Lp;
        mr = mc + mp;
        Mt = mr + M;
        L = (Lc*mc + Lp*mp) / mr;
        Jcm = 0.3333333*mp*Lp^2 + mp*(L-Lp)^2 + mc*(L-Lc)^2;
        Jt = Jcm + mr*L^2;

        den = Jt*Mt-(L*mr)^2;
        a1 = -(L^2)*g*(mr^2)/den;
        % a2 = -Jt*B/den;
        a2 = -Jt*(600*Mt*g*miu_s+b_stri+beta_dcm)/den;
        a3 = -L*gamma*mr/den;
        a4 = -L*Mt*g*mr/den;
        % a5 = -L*mr*B/den;
        a5 = -L*mr*(600*Mt*g*miu_s+b_stri+beta_dcm)/den;
        a6 = -Mt*gamma/den;
        
        b1 = Jt*alpha_dcm/den;
        b2 = L*mr*alpha_dcm/den;
        
        h1 = (-Jt+L*Lc*mr)/den;
        h2 = (Lc*Mt - L*mr)/den;
        
        A = [
            0  0  1  0;
            0  0  0  1; 
            0  a1 a2 a3;
            0  a4 a5 a6;
        ];
        B = [0;0;b1;b2];
        H = [0;0;h1;h2];
    
    case 'stribeck gora'
        % Dla stribecka tak nazwałem te zmienne (przez przypadek)
        load(params_id_on, "params_optim", "params_const");
        
        [alpha_dcm, beta_dcm, b_stri, gamma, miu_c, miu_s, vs] = params_optim{:};
        [M, mp, mc, Lp] = params_const{:};
        
        g = 9.8145;
        Lc = 2*Lp;
        mr = mc + mp;
        Mt = mr + M;
        L = (Lc*mc + Lp*mp) / mr;
        Jcm = 0.3333333*mp*Lp^2 + mp*(L-Lp)^2 + mc*(L-Lc)^2;
        Jt = Jcm + mr*L^2;
        
        den = Jt*Mt-(L*mr)^2;
        a1 = -(L^2)*g*(mr^2)/den;
        % a2 = -Jt*B/den;
        a2 = -Jt*(600*Mt*g*miu_s+b_stri+beta_dcm)/den;
        a3 = -L*gamma*mr/den;
        a4 = -L*Mt*g*mr/den;
        % a5 = -L*mr*B/den;
        a5 = -L*mr*(600*Mt*g*miu_s+b_stri+beta_dcm)/den;
        a6 = -Mt*gamma/den;
        b1 = Jt*alpha_dcm/den;
        b2 = L*mr*alpha_dcm/den;
        h1 = (-Jt+L*Lc*mr)/den;
        h2 = (Lc*Mt - L*mr)/den;
        
        A = [
            0  0  1  0;
            0  0  0  1; 
            0  a1 a2 -a3;
            0  -a4 -a5 a6;
        ];
        B = [0;0;b1;-b2];
        H = [0;0;-h1;h2];

end

C = eye(4,4);
D = zeros(4,1);
E = [1 0 0 0];



