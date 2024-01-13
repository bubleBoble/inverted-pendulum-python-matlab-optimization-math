%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% Animacje
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
clc;
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex;

% Parametry dla modelu z tarciem z stribecka
params_strib = [0.4160, 0.0890, 0, 0.1225, 1.5417, 20.9, 0.0067, 0.0651, 0.1284, 13.9989]; 
% Parametry dla model z tarciem lepkim
params_vis   = [0.416, 0.089, 0, 0.1225, 23.8299, 0.0035, 1.5417];
% Macierze modelu liniowego
% [A, B, C, D, E, H] = macierze_lin('lepki dol', params_vis);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% Ustawienia
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
track_len               = 0.47;         % długość suwnicy, NIE ZMIENIAĆ
end_time                = 4;            % końcowy czas symulacji
sat                     = [-12, 12];    % saturacja sygnału sterującego
animacjaON              = 1;            % animacja on/off
save_anim               = 1;            % zapisanie animacji on/off
enableLinmodel          = 1;            % on/off system liniowy w modelu (simulink)
IC                      = [ ...
    0.2; ...
    0.1*pi/180; ...
    0; ...
    0 ... 
];
IC_liniowy              = IC - [0; pi; 0; 0];
% IC_liniowy              = [track_len/2; 0;  0; 0];

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% Symulacja
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
model_name = 'model_stribeck_IC';
if ~bdIsLoaded(sprintf('%s', model_name))
    load_system(sprintf('%s', model_name))
end
set_param(...
    sprintf('%s', model_name),...
    'Solver','ode45',...
    'StopTime',sprintf('%d', end_time))

% Sygnały do simulinka
dt = 0.01;
t=0:(end_time/dt); t=t*dt;
volt = ( utils.ustep(t, 1) - ...
         utils.ustep(t, 1.5) ) * 0.0;
dist = ( utils.ustep(t, 2.5) - ...
         utils.ustep(t, 3.5) ) * 0.0;
ind.time = t;
ind.signals(1).values = volt';
ind.signals(1).dimensions = 1;
ind.signals(2).values = dist';
ind.signals(2).dimensions = 1;

out = sim(sprintf('%s.slx', model_name));
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% Sygnały z simulinka
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
t            = out.tout;
dist         = out.out.getElement('dist').Values.Data;
volt         = out.out.getElement('volt').Values.Data;
% stribeck
xw_str        = out.out.getElement('xw_str').Values.Data;
the_str       = out.out.getElement('the_str').Values.Data;
Dxw_str       = out.out.getElement('Dxw_str').Values.Data;
Dthe_str      = out.out.getElement('Dthe_str').Values.Data;
% lepki
xw_vis        = out.out.getElement('xw_vis').Values.Data;
the_vis       = out.out.getElement('the_vis').Values.Data;
Dxw_vis       = out.out.getElement('Dxw_vis').Values.Data;
Dthe_vis      = out.out.getElement('Dthe_vis').Values.Data;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% ploty
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%%
fig = figure(1); 
clf(1)
subplot(3,2,1);
plot(t, xw_str, 'LineWidth', 2); grid on; hold on;
plot(t, xw_vis, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green');
ylim([0, track_len]);
% lgd = legend('$x_{\mathrm{w}}$ model nieliniowy','$x_{\mathrm{w}}$ model liniowy','$x_{\mathrm{w}}$ zadane', 'Location','best');
lgd = legend('$x_{\mathrm{1}}$ tarcie Stribecka','$x_{\mathrm{1}}$ tarcie lepkie','Location','northeast');
lgd.FontSize = 16;
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
ax.Box = 'on';
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');

subplot(3,2,3);
plot(t, Dxw_str, 'LineWidth', 2); hold on; grid on;
plot(t, Dxw_vis, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
% lgd = legend('$\dot{x}_w(t)$ model nieliniowy', '$\dot{x}_w(t)$ model liniowy', 'Location','best');
lgd = legend('$x_{\mathrm{3}}$ tarcie Stribecka','$x_{\mathrm{3}}$ tarcie lepkie','Location','northeast');
lgd.FontSize = 16;
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
% set(gca, 'XTickLabel', []);
ax.Box = 'on';
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');

subplot(3,2,5);
plot(t, volt, 'LineWidth', 2); hold on; grid on;
ylim([-12, 12]);
lgd = legend('$v$','Location','northeast');
lgd.FontSize = 16;
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
% set(gca, 'XTickLabel', []);
ax.Box = 'on';
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');

subplot(3,2,2);
plot(t, the_str, 'LineWidth', 2); hold on; grid on;
plot(t, the_vis, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
lgd = legend('$x_{\mathrm{2}}$ tarcie Stribecka','$x_{\mathrm{2}}$ tarcie lepkie','Location','northeast');
lgd.FontSize = 16;
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
% set(gca, 'XTickLabel', []);
ax.Box = 'on';
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');

subplot(3,2,4);
plot(t, Dthe_str, 'LineWidth', 2); hold on; grid on;
plot(t, Dthe_vis, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
lgd = legend('$x_{\mathrm{4}}$ tarcie Stribecka','$x_{\mathrm{4}}$ tarcie lepkie','Location','northeast');
lgd.FontSize = 16;
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
% set(gca, 'XTickLabel', []);
ax.Box = 'on';
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');

subplot(3,2,6);
plot(t, dist, 'LineWidth', 2); grid on;
lgd = legend('$d$','Location','northeast');
lgd.FontSize = 16;
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
xlabel('$t\ [s]$', 'Interpreter','latex');
% set(gca, 'XTickLabel', []);
ax.Box = 'on';
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% Animacja
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
Lc = 2*params_strib(4) / 3;
if animacjaON
    % utils.animate(IC, Lc, 0.001, xw_str, the_str, t, save_anim, "vid_new");
    utils.animate(IC, Lc, 0.001, xw_vis, the_vis, t, save_anim, "vid_new");
end

