%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kolejność dla obu plików:
% x2, x2_sp, x4, x1, x3, x1_sp, v, N_upc, czas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Dane
plik_1 = "pomiary/swingup2.txt";

data1 = readmatrix(plik_1);
p1_time  = data1(:, 9) .* 0.001; % [s]
p1_time = p1_time - p1_time(1);
 
% idx_int = p1_time>0.61;
idx_int = p1_time>0.61 & p1_time<4.6;
p1_time = p1_time(idx_int);
p1_time = p1_time - p1_time(1);

p1_x2    = data1(idx_int, 1);          % [rad] 
p1_x2_sp = data1(idx_int, 2);          % [rad]
p1_x4    = data1(idx_int, 3);          % [rad/s]
p1_x1    = data1(idx_int, 4) * 0.01;   % [m]
p1_x3    = data1(idx_int, 5) * 0.01;   % [m/s]
p1_x1_sp = data1(idx_int, 6) * 0.01;   % [m]
p1_v     = data1(idx_int, 7);          % [V]
p1_N_upc = data1(idx_int, 8);          % [-]

%% Wyniki optimTraj
load("WYNIKI_OPTIMTRAJ.mat");
end_time = p1_time(end);
% time = time(time < end_time);
ctrl = uOT_func(time);
IC = x0low + [0.051; 0; 0; 0];         
dt = 0.001;
time = 0:dt:end_time;

%% Symulacja
ind.time = time';
ind.signals(1).values = uOT_func(time)';
ind.signals(1).dimensions = 1;
d = zeros(size(ind.signals(1).values));
ind.signals(2).values = d;
ind.signals(2).dimensions = 1;

% run("pomoce/UsimulinkModelSetup");
% p_2v_rampa    = [0.4160 0.0890 0 0.1225 1.5417 20.9002 0.0109 0.0651 0.1284 13.9983];
% p_4v_rampa    = [0.4160 0.0890 0 0.1225 1.5417 20.9004 0.0053 0.0651 0.1284 14.0000];
% p_6v_rampa    = [0.4160 0.0890 0 0.1225 1.5417 20.9004 0.0038 0.0651 0.1284 13.9983];
% p_2v_skok     = [0.4160 0.0890 0 0.1225 1.5417 20.9004 0.0090 0.0652 0.1297 13.9983];
% p_4v_skok     = [0.4160 0.0890 0 0.1225 1.5417 20.9004 0.0048 0.0656 0.1297 13.9983];
% p_6v_skok     = [0.4160 0.0890 0 0.1225 1.5417 20.9004 0.0033 0.0658 0.1297 13.9966];
% p_8v_skok     = [0.4160 0.0890 0 0.1225 1.5417 20.9004 0.0022 0.0651 0.1297 13.9986];
p_10v_skok    = [0.4160 0.0890 0 0.1225 1.5417 20.9004 0.0020 0.0644 0.1297 14.0001];
% params_nonlin_stri = [0.4160, 0.0890, 0, 0.1225, 1.5417, 20.9, 0.0067, 0.0651, 0.1284, 13.9989]; % średnie wartości z kolumn
params_nonlin_stri = p_10v_skok;
out = sim('model_swingup.slx');

t            = out.tout;
d            = out.out.getElement('dist').Values.Data;
xw_nl        = out.out.getElement('xw_nl').Values.Data;
the_nl       = out.out.getElement('the_nl').Values.Data;
Dxw_nl       = out.out.getElement('Dxw_nl').Values.Data;
Dthe_nl      = out.out.getElement('Dthe_nl').Values.Data;
ctrl_sig_nl  = out.out.getElement('ctrl_sig').Values.Data;

%% Wykresy
clf;
legend_fontsize = 13;
font_size = 18;
NumTicks = 5;
blue = [0, 0, 1, 0.7];
red  = [1, 0, 0, 1];
green = [0, 1, 0, 0.8];
% green = [0.9290 0.6940 0.1250, 0.7]; % złotawy
% green = [1,0,1,0.5]; % magenta

fig = figure(1);
subplot(511);
    plot(tOT,xwOT+0.051,LineWidth=2,Color=red,LineStyle="--"); hold on; axis tight; grid on;
    plot(p1_time,p1_x1,Color=blue,LineWidth=2); 
    plot(t, xw_nl,Color=green,LineWidth=2,LineStyle="-"); 
    hold off;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    % lgd = legend('$x_1 \ [m]$ pomiar','$x_1 \ [m]$ zadane, pomiar','$x_1 \ [m]$ symulacja model nielin.','$x_1 \ [m]$ symulacja model lin.','Location','northeast');
    % lgd = legend('$x_1 \ [m]$ pomiar','$x_1 \ [m]$ symulacja','Location','northeast');
    lgd = legend('$x_1\ [m]$ OptimTraj', '$x_1\ [m]$ pomiar', '$x_1\ [m]$ model');
    lgd.FontSize = legend_fontsize;
    ax.XAxis.Visible = 'on'; 
    set(gca, 'XTickLabel', []);
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    xlim([0, 4]);
    ax.Box = 'on';
subplot(512);
    plot(tOT, DxwOT, LineWidth=2,Color=red,LineStyle="--"); hold on; axis tight; grid on;
    plot(p1_time,p1_x3,Color=blue,LineWidth=2);
    plot(t,Dxw_nl,Color=green,LineWidth=2,LineStyle="-")
    % lgd = legend('$x_3 \ [m/s]$ pomiar','$x_3 \ [m/s]$ symulacja','Location','northeast');
    lgd = legend('$x_3\ [m]$ OptimTraj', '$x_3\ [m]$ pomiar', '$x_3\ [m]$ model');
    lgd.FontSize = legend_fontsize;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    ax.XAxis.Visible = 'on'; 
    set(gca, 'XTickLabel', []);
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    % xlim([1, 15]);
    xlim([0, 4]);
    ax.Box = 'on';
subplot(513);
    plot(tOT,theOT,LineWidth=2,Color=red,LineStyle="--"); hold on; axis tight; grid on;
    plot(p1_time,p1_x2,Color=blue,LineWidth=2);
    plot(t,the_nl,Color=green,LineWidth=2,LineStyle="-")
    % lgd = legend('$x_2 \ [rad]$ pomiar','$x_2 \ [rad]$ zadane','$x_2 \ [rad]$ symulacja','Location','northeast');
    lgd = legend('$x_2\ [m]$ OptimTraj', '$x_2\ [m]$ pomiar', '$x_2\ [m]$ model');
    lgd.FontSize = legend_fontsize;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    ax.XAxis.Visible = 'on'; 
    set(gca, 'XTickLabel', []);
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    % xlim([1, 15]);
    xlim([0, 4]);
    ax.Box = 'on';
subplot(514);
    plot(tOT,DtheOT,LineWidth=2,Color=red,LineStyle="--"); hold on; axis tight; grid on;
    plot(p1_time,p1_x4,Color=blue,LineWidth=2); hold on; grid on; axis tight;
    plot(t,Dthe_nl,Color=green,LineWidth=2,LineStyle="-")
    % lgd = legend('$x_4 \ [rad/s]$ pomiar','$x_4 \ [rad/s]$ symulacja','Location','northeast');
    lgd = legend('$x_4\ [m]$ OptimTraj', '$x_4\ [m]$ pomiar', '$x_4\ [m]$ model');
    lgd.FontSize = legend_fontsize;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    ax.XAxis.Visible = 'on';
    set(gca, 'XTickLabel', []);
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks));
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'));
    % xlim([1, 15]);
    xlim([0, 4]);
    ax.Box = 'on';
    % ax.YAxis.FontSize = 13;
    % ax.XAxis.FontSize = 13;
    % xlabel('$t\ [s]$', 'Interpreter','latex');
subplot(515);
    % plot(time,ctrl,LineWidth=2,Color=red,LineStyle="--");
    plot(p1_time,p1_v,Color=blue,LineWidth=2); hold on; grid on; axis tight;
    plot(t,ctrl_sig_nl,Color=green,LineWidth=2,LineStyle="-")
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$v \ [V]$ pomiar','$v \ [V]$ model','Location','northeast');
    lgd.FontSize = legend_fontsize;
    % ax.XAxis.Visible = 'off'; 
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks));
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'));
    % xlim([1, 15]);
    % ylim([-12, 12]);
    xlim([0, 4]);
    ax.Box = 'on';
    ax.YAxis.FontSize = font_size;
    ax.XAxis.FontSize = font_size;
    xlabel('$t\ [s]$', 'Interpreter','latex');

% 
% p1_x1 = interp1(p1_time, p1_x1, t);
% p1_x2 = interp1(p1_time, p1_x2, t);
% Lc = 2*params_nonlin_stri(4) / 3;
% utils.animate(IC, Lc, 0.001, xw_nl, the_nl, p1_x1, p1_x2+3*pi/180, t, t, 1, "vid_new");



