clc; clear;
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% JAKIE PARAMETRY DLA NIELINIOWEGO MODELU W SIMULINKU i do optymalizacji.
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% params_for_nonlin_mdl = "rampa_stribeck_4V.mat";
% params_for_nonlin_mdl = "rampa_stribeck_6V.mat";
% params_for_nonlin_mdl = "skok_stribeck_2V.mat";
% params_for_nonlin_mdl = "skok_stribeck_8V.mat";
% params_for_nonlin_mdl = "skok_stribeck_10V.mat";
% params_for_nonlin_mdl = "skok_stribeck_12V.mat";
params_for_nonlin_mdl = "stribeck_4V_12V_rampa.mat";

% Parametry dla Stribecka
load("pomoce/"+params_for_nonlin_mdl, "params_optim", "params_const");
params_const     = num2cell(params_const);
params_stribeck  = [cell2mat(params_optim), cell2mat(params_const)];
% Model w simulink wynierany na podstawie nazwy pomiarów
model_name       = "model_stribeck";

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% Linearyzacja po trajektorii nominalnej.
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
syms x_1 x_2 x_3 x_4 u
% format short
% digits(3)
% sympref('FloatingPointOutput',true);
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% Symboliczna funkcja stanu modelu nieliniowego.
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
x_vec = [x_1; x_2; x_3; x_4];

params_stribeck = num2cell(params_stribeck);
[alpha_dcm, beta_dcm, b_stri, gamma_stri, miu_c, miu_s, vs, M, mp, mc, Lp] = params_stribeck{:};
g = 9.8145;
Lc = 2*Lp;
mr = mc + mp;
Mt = mr + M;
L = (Lc*mc + Lp*mp) / mr;
Jcm = 0.3333333*mp*Lp^2 + mp*(L-Lp)^2 + mc*(L-Lc)^2;
Jt = Jcm + mr*L^2;
i_i = 2;
delta_ = 600;
d = 0;

Ff = (miu_c + (miu_s-miu_c)*exp(-(x_3/vs).^i_i)) .* Mt.*g.*tanh(delta_.*x_3) + b_stri.*x_3;
Fi = alpha_dcm*u - beta_dcm*x_3;
A = d*cos(x_2) - Ff + L*mr*x_4.^2.*sin(x_2) + Fi;
B = d*Lc + L*g*mr*sin(x_2) - gamma_stri*x_4;
DEN = Jt*Mt - (L*mr*cos(x_2)).^2;

ddt_x1 = x_3;
ddt_x2 = x_4;
ddt_x3 = (Jt*A - L*mr*cos(x_2).*B) ./ DEN;
ddt_x4 = (Mt*B - L*mr*cos(x_2).*A) ./ DEN;

f_vec = [ddt_x1; ddt_x2; ddt_x3; ddt_x4];

% f_vec = expand(f_vec);
f_vec = simplify(f_vec);
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% Wywołanie funkcji do symbolicznej linearyzacji.
% Punkt pracy dla modelu w p.stanu jest w formie 
% [ #wektor_stanu, #wektor_sterowań ]
% Tutaj zamiast liczb, pod punkt pracy podstawia się inne zmienne
% symboliczne.
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
syms x_1_tn x_2_tn x_3_tn x_4_tn u_tn
nominal_traj_vars = [x_1_tn; x_2_tn; x_3_tn; x_4_tn; u_tn];
[A, B, C, D] = linearizationSS_syms(f_vec, [], x_vec, u, nominal_traj_vars);
% A = expand(A);
% B = expand(B);
A = simplify(A);
B = simplify(B);

% convert A matrix to matlab function A = A(xw, the, Dxw, Dthe, u) over
% nominal trajectory
A_fun = matlabFunction(A, 'Vars', nominal_traj_vars);
B_fun = matlabFunction(B, 'Vars', nominal_traj_vars);

% currentState = [2, 0, 0, 0, 0];
% A = subs(A, [x_1_tn, x_2_tn, x_3_tn, x_4_tn, u_tn], currentState);

% sterowalnośc w funkcji kąta - to możne nie jest zbyt przydatne ale za to
% bardzo fajnie się na to patrzy.
%===========================================================================%
figure(1);

angle_interval = 0:0.01:2*pi;
det_ctrb_A_the = zeros(size(angle_interval));
for i=1:length(angle_interval)
    det_ctrb_A_the(i) = det(ctrb(A_fun(2, angle_interval(i), 0, 0, 0), B_fun(2, angle_interval(i), 0, 0, 0)));
end
subplot(321)
plot(angle_interval.*180/pi, det_ctrb_A_the, 'LineWidth', 2, 'Color', 'black'); grid on;
xlabel('Wychylenie wahadła [deg]');
ylabel('det(ctrb(A,B))');
xline(90, 'LineWidth',1.5, 'Color','red', 'LineStyle','--'); xline(270, 'LineWidth',1.5, 'Color','red', 'LineStyle','--');
title('$$x_w = 2,\ \ \theta=var,\ \ \dot{x}_w=0,\ \ \dot{\theta}=0$$')

Dx_interval = -15:0.01:15;
det_ctrb_A_Dx = zeros(size(Dx_interval));
for i=1:length(Dx_interval)
    det_ctrb_A_Dx(i) = det(ctrb(A_fun(2, 0, Dx_interval(i), 0, 0), B_fun(2, Dx_interval(i), 0, 0, 0)));
end
subplot(323)
plot(Dx_interval, det_ctrb_A_Dx, 'LineWidth', 2, 'Color', 'black'); grid on;
xlabel('$$x_w\ [\frac{m}{s}]$$');
ylabel('det(ctrb(A,B))');
% xline(90, 'LineWidth',1.5, 'Color','red', 'LineStyle','--'); xline(270, 'LineWidth',1.5, 'Color','red', 'LineStyle','--');
title('$$x_w = 2,\ \ \theta=0,\ \ \dot{x}_w=var,\ \ \dot{\theta}=0$$, \textbf{GORNE POLOZENIE}')

det_ctrb_A_Dx = zeros(size(Dx_interval));
for i=1:length(Dx_interval)
    det_ctrb_A_Dx(i) = det(ctrb(A_fun(2, pi, Dx_interval(i), 0, 0), B_fun(2, Dx_interval(i), 0, 0, 0)));
end
subplot(325)
plot(Dx_interval, det_ctrb_A_Dx, 'LineWidth', 2, 'Color', 'black'); grid on;
xlabel('$$x_w\ [\frac{m}{s}]$$');
ylabel('det(ctrb(A,B))');
% xline(90, 'LineWidth',1.5, 'Color','red', 'LineStyle','--'); xline(270, 'LineWidth',1.5, 'Color','red', 'LineStyle','--');
title('$$x_w = 2,\ \ \theta=180[deg],\ \ \dot{x}_w=var,\ \ \dot{\theta}=0$$, \textbf{DOLNE POLOZENIE}')

det_ctrb_A_Dx = zeros(size(Dx_interval));
for i=1:length(Dx_interval)
    det_ctrb_A_Dx(i) = det(ctrb(A_fun(2, pi/2, Dx_interval(i), 0, 0), B_fun(2, Dx_interval(i), 0, 0, 0)));
end
subplot(322)
plot(Dx_interval, det_ctrb_A_Dx, 'LineWidth', 2, 'Color', 'black'); grid on;
xlabel('$$x_w\ [\frac{m}{s}]$$');
ylabel('det(ctrb(A,B))');
% xline(90, 'LineWidth',1.5, 'Color','red', 'LineStyle','--'); xline(270, 'LineWidth',1.5, 'Color','red', 'LineStyle','--');
title('$$x_w = 2,\ \ \theta=90[deg],\ \ \dot{x}_w=var,\ \ \dot{\theta}=0$$, \textbf{WAHADLO POZIOMO}')

% Dthe_interval = -10:0.01:10;
% det_ctrb_A_Dthe1 = zeros(size(Dthe_interval));
% for i=1:length(Dthe_interval)
%     det_ctrb_A_Dthe1(i) = det(ctrb(A_fun(2, 0, 0, Dthe_interval(i), 0), B_fun(2, 0, 0, Dthe_interval(i), 0)));
% end
% subplot(324)
% plot(Dthe_interval, det_ctrb_A_Dthe1, 'LineWidth', 2, 'Color', 'black'); grid on;
% xlabel('$$x_w\ [\frac{rad}{s}]$$');
% ylabel('det(ctrb(A,B))');
% % xline(90, 'LineWidth',1.5, 'Color','red', 'LineStyle','--'); xline(270, 'LineWidth',1.5, 'Color','red', 'LineStyle','--');
% title('$$x_w = 2,\ \ \theta=0[deg],\ \ \dot{x}_w=0,\ \ \dot{\theta}=var$$, \textbf{dolne polozenie }')
% 
% Dthe_interval = -10:0.01:10;
% det_ctrb_A_Dthe2 = zeros(size(Dthe_interval));
% for i=1:length(Dthe_interval)
%     det_ctrb_A_Dthe2(i) = det(ctrb(A_fun(2, pi, 0, Dthe_interval(i), 0), B_fun(2, pi, 0, Dthe_interval(i), 0)));
% end
% subplot(326)
% plot(Dthe_interval, det_ctrb_A_Dthe1, 'LineWidth', 2, 'Color', 'black'); grid on; hold on
% % plot(Dthe_interval, det_ctrb_A_Dthe2, 'LineWidth', 2, 'Color', 'black'); grid on; hold off
% xlabel('$$x_w\ [\frac{rad}{s}]$$');
% ylabel('det(ctrb(A,B))');
% % xline(90, 'LineWidth',1.5, 'Color','red', 'LineStyle','--'); xline(270, 'LineWidth',1.5, 'Color','red', 'LineStyle','--');
% title('$$x_w = 2,\ \ \theta=pi[deg],\ \ \dot{x}_w=0,\ \ \dot{\theta}=var$$, \textbf{dolne polozenie }')

% wywołanie fhLQR
%===========================================================================%



