%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SKRYPT POMOCNICZY DO 's1.m'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M               = 0.4178;
mp              = 0.0881;
mc              = 0.0001;
Lp              = 0.1223;
b_lep = 26.5928;
gamma_lep = 0.0087;
b_str = 18;
gamma_str = 0.0015;
alpha_dcm = 1.54;
beta_dcm = 0;
miu_c = 0.17; 
miu_s = 0.27; 
vs = 2; 

i_i = 2;
g = 9.8145;
Lc = 2*Lp;
mr = mc + mp;
Mt = mr + M;
L  = (Lc*mc + Lp*mp) / mr;
Jcm = 1/12*mp*Lp^2;
Jt  = Jcm + mr*L^2;
delta_ = 600; % do tanh zamiast signum

params_lepkie = [M, mc, mp, Lp, Lc, g, b_lep, gamma_lep, mr, Mt, L, Jcm, Jt, alpha_dcm, beta_dcm];
params_stribeck = [M, mc, mp, Lp, Lc, g, b_str, gamma_str, mr, Mt, L, Jcm, Jt, alpha_dcm, beta_dcm, miu_c, miu_s, vs, i_i, delta_];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dane z pomiarow
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
the   = data(:, 1) + pi - data(1,1);    the     = the(idx_int);
Dthe  = data(:, 2);                     Dthe    = Dthe(idx_int);
DtheF = data(:, 3);                     DtheF   = DtheF(idx_int);
xw    = data(:, 4) .* 0.01;             xw      = xw(idx_int);
Dxw   = data(:, 5) .* 0.01;             Dxw     = Dxw(idx_int);
DxwF  = data(:, 6) .* 0.01;             DxwF    = DxwF(idx_int);
volt  = data(:, 7);                     volt    = volt(idx_int);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do simulinka
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if swobodna
%     IC = [xw(1);the(1);0;0];
%     swobodna = 0;
% else
%     IC = [0;pi;0;0];
% end
% 
% % input do symulacji
% ind.time = time;
% ind.signals.values = volt;
% ind.signals.dimensions = 1;
% end_time = time(end);
% out = sim(sprintf("%s", model));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dane z symulacji
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t        = out.tout;
% d        = out.out.getElement('dist').Values.Data;
% xw_nl    = out.out.getElement('xw_nl').Values.Data;
% the_nl   = out.out.getElement('the_nl').Values.Data;
% Dxw_nl   = out.out.getElement('Dxw_nl').Values.Data;
% Dthe_nl  = out.out.getElement('Dthe_nl').Values.Data;
% volt_sim = out.out.getElement('volt_s').Values.Data;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ploty
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



clf;
legend_fontsize = 13;
fig = figure(1);
font_size = 18;
NumTicks = 5;
blue = [0, 0, 1, 0.5];
% sgtitle('Pomiar odpowiedzi wahadła na zadany przebieg napięcia wejściowego porównane z odpowiedzią modelu');
subplot(511); % xw
    p00 = plot( time,xw,'Color',blue); hold on;
    p00.LineWidth = 2;
    grid on;
    axis tight;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$x_1 \ [m]$','Location','northeast');
    lgd.FontSize = legend_fontsize;
    ax.XAxis.Visible = 'off'; 
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
subplot(513); % Dxw
    p10 = plot( time,Dxw,'Color',blue); hold on;
    p10.LineWidth = 2;
    grid on;
    axis tight;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$x_3\ [m/s]$','Location','northeast');
    lgd.FontSize = legend_fontsize;
    ax.XAxis.Visible = 'off'; 
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
subplot(512) % theta
    % title('Wychylenie wahadła');
    p20 = plot( time,the,'Color',blue); hold on;
    p20.LineWidth = 2;
    grid on;
    axis tight;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$x_2\ [rad]$','Location','northeast');
    lgd.FontSize = legend_fontsize;
    ax.XAxis.Visible = 'off'; 
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
subplot(514) % Dthe
    % title('Prędkość kątowa wahadła');
    p30 = plot( time,Dthe,'Color',blue); hold on;
    p30.LineWidth = 2;
    grid on;
    axis tight;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$x_4\ [rad/s]$','Location','northeast');
    lgd.FontSize = legend_fontsize;
    ax.XAxis.Visible = 'off'; 
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
subplot(515) % input voltage
    p40 = plot( time,volt,'Color','blue');
    p40.LineWidth = 1.15;
    grid on;
    axis tight;
    ax=gca;
    ax.YAxis.FontSize = font_size;
    lgd = legend('$v\ [V]$','Location','northeast');
    lgd.FontSize = legend_fontsize;
    % ax.XAxis.Visible = 'off'; 
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    xlabel('$t\ [s]$','interpreter','latex','FontSize',font_size)
    ax.XAxis.FontSize = font_size;
% sgtitle();
% na razie tylko dla 4vrampa.txt    
% rampa=1;
% if rampa
%     subplot(326)
%         the   = data(:, 1) + pi - data(1,1);    the     = the(idx_int);
%         Dthe  = data(:, 2);                     Dthe    = Dthe(idx_int);
%         DtheF = data(:, 3);                     DtheF   = DtheF(idx_int);
%         xw    = data(:, 4) .* 0.01;             xw      = xw(idx_int);
%         Dxw   = data(:, 5) .* 0.01;             Dxw     = Dxw(idx_int);
%         DxwF  = data(:, 6) .* 0.01;             DxwF    = DxwF(idx_int);
%         volt  = data(:, 7);                     volt    = volt(idx_int);
% 
%         time = data(:, 8) * 0.001;
%         time = time - time(1);
% 
%         idx_int =time>5 & time < 8.2;
% 
%         time  = time(idx_int);
%         time  = time - time(1);
%         volt  = data(:, 7);         volt = volt(idx_int);
%         Dxw   = data(:, 5) .* 0.01; Dxw  = Dxw(idx_int);
%         DxwF  = data(:, 6) .* 0.01; DxwF = DxwF(idx_int);
% 
%         % idx_int_sim = t > 0;
%         % Dxw_nl = Dxw_nl(idx_int_sim);
%         % volt_sim = volt_sim(idx_int_sim);
% 
%         % p50 = plot( time, Dxw ); hold on
%         % p50 = plot( time, DxwF );
%         % p50.LineWidth = 1.15;
% 
%         % surowe
%         p50 = plot( Dxw, alpha_dcm*volt-beta_dcm*Dxw ); hold on
%         p50 = plot( DxwF, alpha_dcm*volt-beta_dcm*DxwF );
%         p50.LineWidth = 1.15;
%         % 
%         % p51 = plot(  Dxw_nl, alpha_*volt_sim-beta_*Dxw_nl );
%         % p51.LineWidth = 1.15;
%         % grid on;
% 
%         % legend('$$F_{i, obliczone\ np.\ modelu\ z\ pomiarow} vs. \dot{x}_{w,pomiar}$$', '$$F_{i, obliczone\ np.\ modelu z\ pomiarow} vs. \dot{x}_{w,model}$$');
% end
