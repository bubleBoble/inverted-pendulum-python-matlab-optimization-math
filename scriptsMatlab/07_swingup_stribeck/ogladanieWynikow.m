%
% end_time = 3
% 3/3000 = 1ms samplowanie
% czyli trzeba wziąc co 10-tą próbkę
% żeby było samplowanie 10ms
%
% load("dobredobre_fajne_mega.mat", "uOT_func", "time");
% load("dobrewynikiAle_35.mat");

% To jest ta użyta w pracy
% end_time = 4
% 4/4000 = 1ms samplowanie
% czyli trzeba wziąc co 10-tą próbkę
% żeby było samplowanie 10ms
%
% load("dobredobre_fajne_mega.mat", "uOT_func", "time", "ctrl_sig_nl", "t");
load("WYNIKI.mat");
% load("WYNIKI2.mat");

ctrl = uOT_func(time);
ctrl = ctrl(1:10:end);
time0 = time(1:10:end);

% size: 4000x1
del_sample = 1800;
ctrl_sig_nl = ctrl_sig_nl(1:end-8);
ctrl_sig_nl = ctrl_sig_nl(1:10:end-del_sample);
t = t(1:end-8);
t = t(1:10:end-del_sample);
% plot(time, ctrl, t, ctrl_sig_nl);

ctrl = ctrl_sig_nl;
vname='ctrl';
precision=16;
N=length(ctrl);
fmt=['float %s[%d]={' repmat('%f,',1,numel(ctrl)-1) '%f}'];
c_code=sprintf(fmt,vname,N,ctrl);
disp(c_code);
IC = x0low;         
dt = 0.001;
time = 0:dt:end_time;

ind.time = time;
ind.signals(1).values = uOT_func(time)';
ind.signals(1).dimensions = 1;
d = zeros(size(ind.signals(1).values));
ind.signals(2).values = d';
ind.signals(2).dimensions = 1;


ind.time = time';
ind.signals(1).values = uOT_func(time)';
ind.signals(1).dimensions = 1;
d = zeros(size(ind.signals(1).values));
ind.signals(2).values = d;
ind.signals(2).dimensions = 1;

% run("pomoce/UsimulinkModelSetup");
% alpha_dcm, beta_dcm, b_stri, gamma_stri, miu_c, miu_s, vs, M, mp, mc, Lp
% params_stribeck = [1.5417, 20.9, 0, 0.0067, 0.0651, 0.1284, 13.9989, 0.4160, 0.0890, 0.0001, 0.1225];
params_stribeck = [1.5417, 20.9, 0, 0.002, 0.0651, 0.1284, 13.9989, 0.4160, 0.0890, 0.0001, 0.1225];
out = sim('model_stribeck.slx');

% Wyniki z optimTraj: tOT, xwOT, theOT, DxwOT, DtheOT, uOT
% Wyniki z simulinka
t            = out.tout;
%nieliniowy
d            = out.out.getElement('dist').Values.Data;
xw_nl        = out.out.getElement('xw_nl').Values.Data;
the_nl       = out.out.getElement('the_nl').Values.Data;
Dxw_nl       = out.out.getElement('Dxw_nl').Values.Data;
Dthe_nl      = out.out.getElement('Dthe_nl').Values.Data;
% sygnał sterujący i składowe
ctrl_sig_nl  = out.out.getElement('ctrl_sig').Values.Data;

%=========================================================================%
%   Ploty z symulacji i z optymalizacji
%=========================================================================%
clf

figure(1);

subplot(321);
plot(tOT, xwOT, LineWidth=2, Color=[0,0,1,0.5]); hold on; plot(t, xw_nl, LineWidth=2, LineStyle='--', Color='red'); grid on;
lgd = legend('$x_{1}\ [m]$ OptimTraj', '$x_{1}\ [m]$ Simulink', 'Location', 'northeast');
lgd.FontSize = 16;
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
ax.Box = 'on';
% set(gca, 'XTickLabel', []);
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');

subplot(322);
plot(tOT, theOT, LineWidth=2, Color=[0,0,1,0.5]); hold on;
plot(t, the_nl, LineWidth=2, LineStyle='--', Color='red'); grid on;
lgd = legend('$x_2\ [rad]$ OptimTraj', '$x_2\ [rad]$ Simulink', 'Location', 'northeast');
lgd.FontSize = 16;
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
ax.Box = 'on';
% set(gca, 'XTickLabel', []);
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');

subplot(323);
plot(tOT, DxwOT, LineWidth=2, Color=[0,0,1,0.5]); hold on;
plot(t, Dxw_nl, LineWidth=2, LineStyle='--', Color='red'); grid on;
lgd = legend('$x_3\ [m/s]$ OptimTraj', '$x_3\ [m/s]$ Simulink', 'Location', 'northeast');
lgd.FontSize = 16;
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
ax.Box = 'on';
% set(gca, 'XTickLabel', []);
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');

subplot(324);
plot(tOT, DtheOT, LineWidth=2, Color=[0,0,1,0.5]); hold on;
plot(t, Dthe_nl, LineWidth=2, LineStyle='--', Color='red'); grid on;
lgd = legend('$x_4\ [rad/s]$ OptimTraj', '$x_4\ [rad/s]$ Simulink', 'Location', 'northeast');
lgd.FontSize = 16;
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
ax.Box = 'on';
% set(gca, 'XTickLabel', []);
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');

subplot(325);
plot(t, ctrl_sig_nl, LineWidth=2, Color=[0,0,1,0.5]); grid on; 
% plot(time0(time0<2.2), ctrl, LineWidth=2); grid on; 
% hold on; plot(t, ctrl_sig_nl);
lgd = legend('$v\ [V]$ Simulink', 'Location', 'northeast');
lgd.FontSize = 16;
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
ax.Box = 'on';
% set(gca, 'XTickLabel', []);
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');

%%
Lp = params_stribeck(end);
Lc = 2*Lp/3;
save_anim = 0;
animateON = 0;
if animateON
    % utils.animate(IC, Lc, dt, xw_nl, the_nl, t, save_anim)
    utils.animate(IC, Lc, 0.005, xwOT, theOT, tOT, save_anim)
end