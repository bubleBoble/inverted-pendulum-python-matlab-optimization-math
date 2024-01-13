function [A, B, C, D, E, H] = macierze_lin(ktory_model, params)
%
%   ktory model = 'lepki dol' / 'lepki gora' / 'stribeck dol' / 'stribeck gora'
%
switch ktory_model
    case 'lepki dol'
        if( length(params) ~= 7 )
            disp('złe parametry dla modelu');
            A=0; B=0; C=0; H=0;
            return
        else
            params = num2cell(params);
            [M, mp, mc, Lp, B, gamma, alpha_dcm] = params{:};
    
            g = 9.8145;
            Lc = 2*Lp;
            mr = mc + mp;
            Mt = mr + M;
            L = (Lc*mc + Lp*mp) / mr;
            Jcm = 1/12*mp*Lp^2;
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
        end
    case 'lepki gora'
        if( length(params) ~= 7 )
            disp('złe parametry dla modelu');
            A=0; B=0; C=0; H=0;
            return
        else
            params = num2cell(params);
            [M, mp, mc, Lp, B, gamma, alpha_dcm] = params{:};
        
            g = 9.8145;
            Lc = 2*Lp;
            mr = mc + mp;
            Mt = mr + M;
            L = (Lc*mc + Lp*mp) / mr;
            Jcm = 1/12*mp*Lp^2;
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
        end
    case 'stribeck dol'
        if( length(params) ~= 10 )
            disp('złe parametry dla modelu')
            A=0; B=0; C=0; H=0;
            return
        else
            params = num2cell(params);
            [M, mp, mc, Lp, alpha_dcm, B, gamma, miu_c, miu_s, vs] = params{:};
             
            g = 9.8145;
            Lc = 2*Lp;
            mr = mc + mp;
            Mt = mr + M;
            L = (Lc*mc + Lp*mp) / mr;
            Jcm = 1/12*mp*Lp^2;
            Jt = Jcm + mr*L^2;
    
            den = Jt*Mt-(L*mr)^2;
            a1 = -(L^2)*g*(mr^2)/den;
            % a2 = -Jt*B/den;
            a2 = -Jt*(600*Mt*g*miu_s+B)/den;
            a3 = -L*gamma*mr/den;
            a4 = -L*Mt*g*mr/den;
            % a5 = -L*mr*B/den;
            a5 = -L*mr*(600*Mt*g*miu_s+B)/den;
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
        end
    case 'stribeck gora'
        if( length(params) ~= 10 )
            disp('złe parametry dla modelu')
            A=0; B=0; C=0; H=0;
            return
        else
            params = num2cell(params);
            [M, mp, mc, Lp, alpha_dcm, B, gamma, miu_c, miu_s, vs] = params{:};
        
            g = 9.8145;
            Lc = 2*Lp;
            mr = mc + mp;
            Mt = mr + M;
            L = (Lc*mc + Lp*mp) / mr;
            Jcm = 1/12*mp*Lp^2;
            Jt = Jcm + mr*L^2;
            
            den = Jt*Mt-(L*mr)^2;
            a1 = -(L^2)*g*(mr^2)/den;
            % a2 = -Jt*B/den;
            a2 = -Jt*(600*Mt*g*miu_s+B)/den;
            a3 = -L*gamma*mr/den;
            a4 = -L*Mt*g*mr/den;
            % a5 = -L*mr*B/den;
            a5 = -L*mr*(600*Mt*g*miu_s+B)/den;
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
end

C = eye(4,4);
D = zeros(4,1);
E = [1 0 0 0];

end

