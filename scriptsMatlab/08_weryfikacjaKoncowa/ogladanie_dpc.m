%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kolejność dla obu plików:
% x2, x2_sp, x4, x1, x3, x1_sp, v, N_upc, czas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Dane
plik_1 = "pomiary/dpc.txt";

data1 = readmatrix(plik_1);
p1_time  = data1(:, 9) .* 0.001; % [s]
p1_time = p1_time - p1_time(1);
 
idx_int = p1_time>2;
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

%% Symulacja sterowania
params_lin_vis = [0.416, 0.089, 0, 0.1225, 23.8299, 0.0035, 1.5417]; % średnie wartości z kolumn
[A, B, C, D, E, H] = macierze_lin('lepki dol', params_lin_vis);

p_2v_rampa    = [0.4160 0.0890 0 0.1225 1.5417 20.9002 0.0109 0.0651 0.1284 13.9983];
p_4v_rampa    = [0.4160 0.0890 0 0.1225 1.5417 20.9004 0.0053 0.0651 0.1284 14.0000];
p_6v_rampa    = [0.4160 0.0890 0 0.1225 1.5417 20.9004 0.0038 0.0651 0.1284 13.9983];
p_2v_skok     = [0.4160 0.0890 0 0.1225 1.5417 20.9004 0.0090 0.0652 0.1297 13.9983];
p_4v_skok     = [0.4160 0.0890 0 0.1225 1.5417 20.9004 0.0048 0.0656 0.1297 13.9983];
p_6v_skok     = [0.4160 0.0890 0 0.1225 1.5417 20.9004 0.0033 0.0658 0.1297 13.9966];
p_8v_skok     = [0.4160 0.0890 0 0.1225 1.5417 20.9004 0.0022 0.0651 0.1297 13.9986];
p_10v_skok    = [0.4160 0.0890 0 0.1225 1.5417 20.9004 0.0020 0.0644 0.1297 14.0001];
params_nonlin_stri = [0.4160, 0.0890, 0, 0.1225, 1.5417, 20.9, 0.0067, 0.0651, 0.1284, 13.9989]; % średnie wartości z kolumn
% params_nonlin_stri = p_2v_rampa;

track_len               = 0.47;         % długość suwnicy, NIE ZMIENIAĆ
end_time                = p1_time(end); % końcowy czas symulacji
sat                     = [-12, 12];    % saturacja sygnału sterującego
animacjaON              = 1;            % animacja on/off
save_anim               = 1;            % zapisanie animacji on/off
enableLinmodel          = 1;            % on/off system liniowy w modelu (simulink)
cart_pos_allowed_error  = 0.003;        % dozwolny uchyb położęnia wózka w metrach
pend_position_allowed_error = 1*pi/180; % dozwolony uchyb wychylenia wahadła
dead_zone_ctrl_ampl     = 0.75;         % martwa sterfa sygnału sterującego w REGULATORZE
dead_zone_ampl          = 0;            % martwa strefa napięcia do silnika w MODELU
IC                      = [ ...
    0.2; ...
    pi - 0*pi/180; ...
    0; ...
    0 ... 
];
IC_liniowy              = IC - [0; pi; 0; 0];
F = [44.721360, 20.131541, 5.820552, -0.529622];

model_name = 'model_lqr_dol_stribeck';
run('UsimulinkModelSetup.m')

dt = 0.01;
t=0:(end_time/dt); t=t*dt;

% xw_ref = p1_x1_sp;
% xw_ref = ones(size(t))*0.2;
xw_ref = ( utils.ustep(t, 0)*(0.2) + ...
           utils.ustep(t, 1.485)*(-0.1) + ...
           utils.ustep(t, 3.495)*(0.2) + ...
           utils.ustep(t, 5.489)*(-0.2) + ...
           utils.ustep(t, 7.485)*(0.2) + ...
           utils.ustep(t, 9.485)*(-0.2) + ...
           utils.ustep(t, 11.485)*(0.2) + ...
           utils.ustep(t, 13.485)*(-0.1));

d = t * 0.0;
    
ind.time = t;
ind.signals(1).values = xw_ref';
ind.signals(1).dimensions = 1;
ind.signals(2).values = d';
ind.signals(2).dimensions = 1;

ind.time = t;
ind.signals(1).values = xw_ref';
ind.signals(1).dimensions = 1;
ind.signals(2).values = d';
ind.signals(2).dimensions = 1;

out = sim(sprintf('%s.slx', model_name));

t_sim        = out.tout;
%nieliniowy
d            = out.out.getElement('dist').Values.Data;
xw_ref       = out.out.getElement('xw_ref').Values.Data;
xw_nl        = out.out.getElement('xw_nl').Values.Data;
the_nl       = out.out.getElement('the_nl').Values.Data;
Dxw_nl       = out.out.getElement('Dxw_nl').Values.Data;
Dthe_nl      = out.out.getElement('Dthe_nl').Values.Data;
% sygnał sterujący i składowe
ctrl_sig     = out.out.getElement('ctrl_sig').Values.Data;
ctrl_e_xw    = out.out.getElement('ctrl_e_xw').Values.Data;
ctrl_e_the   = out.out.getElement('ctrl_e_the').Values.Data;
ctrl_e_Dxw   = out.out.getElement('ctrl_e_Dxw').Values.Data;
ctrl_e_Dthe  = out.out.getElement('ctrl_e_Dthe').Values.Data;
%liniowy 
xw_l       = out.out.getElement('xw_l').Values.Data;
the_l      = out.out.getElement('the_l').Values.Data;
Dxw_l      = out.out.getElement('Dxw_l').Values.Data;
Dthe_l     = out.out.getElement('Dthe_l').Values.Data;
ctrl_sig_l = out.out.getElement('ctrl_sig_l').Values.Data;

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
    plot(p1_time,p1_x1,Color=blue,LineWidth=2); hold on; grid on; axis tight;
    plot(p1_time,p1_x1_sp,Color=red,LineWidth=2,LineStyle="--");
    plot(t_sim,xw_nl,Color=green,LineWidth=2,LineStyle="-"); hold off
    % plot(t_sim,xw_ref); hold off;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$x_1 \ [m]$ pomiar','$x_1 \ [m]$ zadane, pomiar','$x_1 \ [m]$ symulacja','Location','northeast');
    lgd.FontSize = legend_fontsize;
    ax.XAxis.Visible = 'on'; 
    set(gca, 'XTickLabel', []);
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    xlim([1, 15]);
    ax.Box = 'on';
subplot(512);
    plot(p1_time,p1_x3,Color=blue,LineWidth=2); hold on; grid on; axis tight;
    plot(t_sim,Dxw_nl,Color=green,LineWidth=2,LineStyle="-")
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$x_3 \ [m/s]$ pomiar','$x_3 \ [m/s]$ symulacja','Location','northeast');
    lgd.FontSize = legend_fontsize;
    ax.XAxis.Visible = 'on'; 
    set(gca, 'XTickLabel', []);
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    xlim([1, 15]);
    ax.Box = 'on';
subplot(513);
    plot(p1_time,p1_x2,Color=blue,LineWidth=2); hold on; grid on; axis tight;
    % yline(pi,Color=red,LineWidth=2,LineStyle="--");
    plot(t_sim,the_nl,Color=green,LineWidth=2,LineStyle="-")
    ax=gca;
    ax.YAxis.FontSize = font_size;
    % lgd = legend('$x_2 \ [rad]$ pomiar','$\pi \ [rad]$','$x_2 \ [rad]$ symulacja','Location','northeast');
    lgd = legend('$x_2 \ [rad]$ pomiar','$x_2 \ [rad]$ symulacja','Location','northeast');
    lgd.FontSize = legend_fontsize;
    ax.XAxis.Visible = 'on'; 
    set(gca, 'XTickLabel', []);
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    xlim([1, 15]);
    ax.Box = 'on';
subplot(514);
    plot(p1_time,p1_x4,Color=blue,LineWidth=2); hold on; grid on; axis tight;
    plot(t_sim,Dthe_nl,Color=green,LineWidth=2,LineStyle="-")
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$x_4 \ [rad/s]$ pomiar','$x_4 \ [rad/s]$ symulacja','Location','northeast');
    lgd.FontSize = legend_fontsize;
    ax.XAxis.Visible = 'on';
    set(gca, 'XTickLabel', []);
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks));
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'));
    xlim([1, 15]);
    ax.Box = 'on';
    % ax.YAxis.FontSize = 13;
    % ax.XAxis.FontSize = 13;
    % xlabel('$t\ [s]$', 'Interpreter','latex');
subplot(515);
    plot(p1_time,p1_v,Color=blue,LineWidth=2); hold on; grid on; axis tight;
    plot(t_sim,ctrl_sig,Color=green,LineWidth=2,LineStyle="-")
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$v \ [V]$ pomiar','$v \ [V]$ symulacja','Location','northeast');
    lgd.FontSize = legend_fontsize;
    % ax.XAxis.Visible = 'off'; 
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks));
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'));
    xlim([1, 15]);
    ax.Box = 'on';
    ax.YAxis.FontSize = font_size;
    ax.XAxis.FontSize = font_size;
    xlabel('$t\ [s]$', 'Interpreter','latex');

p1_x1 = interp1(p1_time, p1_x1, t_sim);
p1_x2 = interp1(p1_time, p1_x2, t_sim);
Lc = 2*params_nonlin_stri(4) / 3;
utils.animate(IC, Lc, 0.001, xw_nl, the_nl, p1_x1, p1_x2, t_sim, t_sim, 1, "vid_new");


