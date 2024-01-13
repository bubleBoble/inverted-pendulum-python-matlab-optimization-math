%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear;
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kolejność:
% x2, x2_sp, x4, x1, x3, x1_sp, v, N_upc, czas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Dane
plik_1 = "pomiary/trzaskanieWahadlaGora.txt";

data1 = readmatrix(plik_1);
p1_time  = data1(:, 9) .* 0.001; % [s]
p1_time = p1_time - p1_time(1);
 
idx_int = p1_time>10;
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
    hold off;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$x_1 \ [m]$ pomiar','$x_1 \ [m]$ zadane','$x_1 \ [m]$ symulacja','Location','northeast');
    lgd.FontSize = legend_fontsize;
    ax.XAxis.Visible = 'on'; 
    set(gca, 'XTickLabel', []);
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    ax.Box = 'on';
subplot(512);
    plot(p1_time,p1_x3,Color=blue,LineWidth=2); hold on; grid on; axis tight;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$x_3 \ [m/s]$ pomiar','$x_3 \ [m/s]$ symulacja','Location','northeast');
    lgd.FontSize = legend_fontsize;
    ax.XAxis.Visible = 'on'; 
    set(gca, 'XTickLabel', []);
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    ax.Box = 'on';
subplot(513);
    plot(p1_time,p1_x2,Color=blue,LineWidth=2); hold on; grid on; axis tight;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$x_2 \ [rad]$ pomiar','$x_2 \ [rad]$ zadane','$x_2 \ [rad]$ symulacja','Location','northeast');
    lgd.FontSize = legend_fontsize;
    ax.XAxis.Visible = 'on'; 
    set(gca, 'XTickLabel', []);
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    ax.Box = 'on';
subplot(514);
    plot(p1_time,p1_x4,Color=blue,LineWidth=2); hold on; grid on; axis tight;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$x_4 \ [rad/s]$ pomiar','$x_4 \ [rad/s]$ symulacja','Location','northeast');
    lgd.FontSize = legend_fontsize;
    ax.XAxis.Visible = 'on';
    set(gca, 'XTickLabel', []);
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks));
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'));
    ax.Box = 'on';
subplot(515);
    plot(p1_time,p1_v,Color=blue,LineWidth=2); hold on; grid on; axis tight;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$v \ [V]$ pomiar','$v \ [V]$ symulacja','Location','northeast');
    lgd.FontSize = legend_fontsize;
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks));
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'));
    ax.Box = 'on';
    ax.YAxis.FontSize = font_size;
    ax.XAxis.FontSize = font_size;
    xlabel('$t\ [s]$', 'Interpreter','latex');