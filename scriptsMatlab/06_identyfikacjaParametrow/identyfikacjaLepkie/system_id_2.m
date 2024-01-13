%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dane pomiarowe, prep
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
the11   = data1(:, 1) + pi - data1(1,1);     %the11     = the11(idx_int1);
Dthe11  = data1(:, 2);                       %Dthe11    = Dthe11(idx_int1);
DtheF11 = data1(:, 3);                       %DtheF11   = DtheF11(idx_int1);
xw11    = data1(:, 4) .* 0.01;               %xw11      = xw11(idx_int1);
Dxw11   = data1(:, 5) .* 0.01;               %Dxw11     = Dxw11(idx_int1);
DxwF11  = data1(:, 6) .* 0.01;               %DxwF11    = DxwF11(idx_int1);
volt11  = data1(:, 7);                       %volt11    = volt11(idx_int1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Początkowy stan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IC = [0;pi;0;0];

meas_data  = [xw11, the11];                     % przekazywane do obj_func_lsqnonlin.m
volt = volt11;                                  % przekazywane do obj_func_lsqnonlin.m
end_time   = time1(end);                        % przekazywane do obj_func_lsqnonlin.m
data_len   = length(time1);
odetime    = linspace(0, end_time, data_len);   % przekazywane do obj_func_lsqnonlin.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Punkt początkowy poszukiwań
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ( class(params0)~="double" )
    params0 = cell2mat(params0);
end
if isempty(params0) 
    params0 = params_to_find;
    if(~isempty(lb))
        % assert na rozmiar params0
        if ~all(params0 < ub & params0 > lb)
            disp(params0 < ub & params0 > lb)
            disp("starting point 'params0' not in optim bounds")
            return 
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wywołanie optymalizatora
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%| START lsqnonlin |%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
[params_optim, final_summed_cost, residual, exitflag, output] = lsqnonlin( ...
    @(params) obj_func_lsqnonlin(params, IC, meas_data, volt, odetime, options_ode), ...
    params0, ...
    lb,ub,options_optim ...
);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Znalezione parametry
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
params_optim = num2cell(params_optim);
[M, mp, mc, Lp, B, gamma_vis, alpha_dcm] = params_optim{:};
%--------------------------------------------------------------------------------------------------------
g               = 9.8145;
i_i             = 2;
delta_          = 600;
Lc = 2*Lp;
mr = mc + mp;
Mt = mr + M;
L = (Lc*mc + Lp*mp) / mr;
Jcm = mp*Lp^2;
Jt = Jcm + mr*L^2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do simulinka
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if plot_simulink_result
    params_lepkie = [M, mp, mc, Lp, B, gamma_vis, alpha_dcm];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Input struktura do simulinka
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ind.time = time1;
    ind.signals.values = volt;
    ind.signals.dimensions = 1;
    % end_time = time(end);
    out = sim(sprintf("%s", model_name));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Dane z symulacji
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    t        = out.tout;
    d        = out.out.getElement('dist').Values.Data;
    xw_nl    = out.out.getElement('xw_nl').Values.Data;
    the_nl   = out.out.getElement('the_nl').Values.Data;
    Dxw_nl   = out.out.getElement('Dxw_nl').Values.Data;
    Dthe_nl  = out.out.getElement('Dthe_nl').Values.Data;
    volt_sim = out.out.getElement('volt_s').Values.Data;
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Plot
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clf;
    legend_fontsize = 13;
    fig = figure(1);
    font_size = 18;
    NumTicks = 5;
    blue = [0,0,1,0.5];
    red  = [1,0,0,1];
    % sgtitle('Pomiar odpowiedzi wahadła na zadany przebieg napięcia wejściowego porównane z odpowiedzią modelu');
    subplot(511); % xw
        p00 = plot( time1,xw11,'Color',blue,'LineWidth',2); hold on;
        p01 = plot( t,xw_nl,'Color',red, LineWidth=2, LineStyle='--');
        grid on;
        axis tight;
        ax=gca;
        ax.YAxis.FontSize = font_size;
        lgd = legend('$x_1\ [m]$ pomiar','$x_1\ [m]$ model','Location','northeast');
        lgd.FontSize = legend_fontsize;
        ax.XAxis.Visible = 'off'; 
        L = get(gca,'YLim');
        set(gca,'YTick',linspace(L(1),L(2),NumTicks))
        set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
        
    subplot(512); % Dxw
        p10 = plot( time1,Dxw11,'Color',blue,LineWidth=2); hold on;
        p12 = plot( t,Dxw_nl,'Color',red , LineWidth=2, LineStyle='--'); hold on;
        grid on;
        axis tight;
        ax=gca;
        ax.YAxis.FontSize = font_size;
        lgd = legend('$x_3\ [m/s]$ pomiar','$x_3\ [m/s]$ model','Location','northeast');
        lgd.FontSize = legend_fontsize;
        ax.XAxis.Visible = 'off'; 
        L = get(gca,'YLim');
        set(gca,'YTick',linspace(L(1),L(2),NumTicks))
        set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))

    subplot(513) % theta
        % title('Wychylenie wahadła');
        p20 = plot( time1,the11,'Color',blue,LineWidth=2); hold on;
        p21 = plot( t,the_nl,'Color',red,LineWidth=2,LineStyle='--');
        grid on;
        axis tight;
        ax=gca;
        ax.YAxis.FontSize = font_size;
        lgd = legend('$x_2\ [rad]$ pomiar','$x_2\ [rad]$ model','Location','northeast');
        lgd.FontSize = legend_fontsize;
        ax.XAxis.Visible = 'off'; 
        L = get(gca,'YLim');
        set(gca,'YTick',linspace(L(1),L(2),NumTicks))
        set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    subplot(514) % Dthe
        % title('Prędkość kątowa wahadła');
        p30 = plot( time1,Dthe11,'Color',blue,LineWidth=2); hold on;
        p32 = plot( t,Dthe_nl,'Color',red,LineWidth=2,LineStyle='--'); hold off;
        grid on;
        axis tight;
        ax=gca;
        ax.YAxis.FontSize = font_size;
        lgd = legend('$x_4 \ [rad/s]$ pomiar','$x_4\ [rad/s]$ model','Location','northeast');
        lgd.FontSize = legend_fontsize;
        ax.XAxis.Visible = 'off'; 
        L = get(gca,'YLim');
        set(gca,'YTick',linspace(L(1),L(2),NumTicks))
        set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    subplot(515) % input voltage
        p40 = plot( time1,volt11,'Color',blue,LineWidth=2);
        % ylabel('$v\ [V]$','FontSize',font_size, 'Rotation', 0)
        xlabel('$t\ [s]$','interpreter','latex','FontSize',font_size)
        grid on;
        axis tight;
        ax=gca;
        ax.YAxis.FontSize = font_size;
        ax.XAxis.FontSize = font_size;
        lgd = legend('$v\ [V]$ pomiar','Location','northeast');
        lgd.FontSize = legend_fontsize;
        L = get(gca,'YLim');
        set(gca,'YTick',linspace(L(1),L(2),NumTicks))
        set(gca,'xticklabel',num2str(get(gca,'xtick')','%.1f'))
        set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    drawnow
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % Plot
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % clf;
    % legend_fontsize = 13;
    % fig = figure(1);
    % font_size = 18;
    % NumTicks = 5;
    % blue = [0,0,1,1];
    % red  = [1,0,0,0.45];
    % % sgtitle('Pomiar odpowiedzi wahadła na zadany przebieg napięcia wejściowego porównane z odpowiedzią modelu');
    % subplot(511); % xw
    %     p00 = plot( time1,xw11,'Color',blue ); hold on;
    %     p00.LineWidth = 1.15;
    %     % xl = ylabel('$x_{\mathrm{w}}\ \left[m\right]$','interpreter','latex','FontSize',font_size, 'Rotation', 0);
    %     % xl.Position(1) = xl.Position(1) - 0.34; 
    %     xlabel('$t\ [s]$')
    %     p01 = plot( t,xw_nl,'Color',red );
    %     p01.LineWidth = 1.15;
    %     grid on;
    %     axis tight;
    %     ax=gca;
    %     ax.YAxis.FontSize = font_size;
    %     lgd = legend('$$x_{\mathrm{w}}$$ pomiar','$$x_{\mathrm{w}}$$ model','Location','southeast');
    %     lgd.FontSize = legend_fontsize;
    %     ax.XAxis.Visible = 'off'; 
    %     L = get(gca,'YLim');
    %     set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    %     set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    % subplot(512); % Dxw
    %     p10 = plot( time1,Dxw11,'Color',blue ); hold on;
    %     p10.LineWidth = 1.15;
    %     % xl = ylabel('$\dot{x}_{\mathrm{w}}\ \left[\frac{m}{s}\right]$','interpreter','latex','FontSize',font_size, 'Rotation', 0);
    %     % xl.Position(1) = xl.Position(1) - 0.34; 
    %     p12 = plot( t,Dxw_nl,'Color',red ); hold on;
    %     p12.LineWidth = 1.15;
    %     grid on;
    %     axis tight;
    %     ax=gca;
    %     ax.YAxis.FontSize = font_size;
    %     lgd = legend('$$\dot{x}_{\mathrm{w}}$$ pomiar','$$\dot{x}_{\mathrm{w}}$$ model','Location','southeast');        lgd.FontSize = legend_fontsize;
    %     ax.XAxis.Visible = 'off'; 
    %     L = get(gca,'YLim');
    %     set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    %     set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    % subplot(513) % theta
    %     % title('Wychylenie wahadła');
    %     p20 = plot( time1,the11,'Color',blue ); hold on;
    %     p20.LineWidth = 1.15;
    %     % xl = ylabel('$\theta\ [rad]$','interpreter','latex','FontSize',font_size, 'Rotation', 0);
    %     % xl.Position(1) = xl.Position(1) - 0.33;
    %     p21 = plot( t,the_nl,'Color',red );
    %     p21.LineWidth = 1.15;
    %     grid on;
    %     axis tight;
    %     ax=gca;
    %     ax.YAxis.FontSize = font_size;
    %     lgd = legend('$$\theta$$ pomiar','$$\theta$$ model','Location','southeast');        lgd.FontSize = legend_fontsize;
    %     lgd.FontSize = legend_fontsize;
    %     ax.XAxis.Visible = 'off'; 
    %     L = get(gca,'YLim');
    %     set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    %     set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    % subplot(514) % Dthe
    %     % title('Prędkość kątowa wahadła');
    %     p30 = plot( time1,Dthe11,'Color',blue ); hold on;
    %     p30.LineWidth = 1.15;
    %     % xl = ylabel('$\dot{\theta}\ \left[\frac{rad}{s}\right]$','interpreter','latex','FontSize',font_size, 'Rotation', 0);
    %     % xl.Position(1) = xl.Position(1) - 0.32;
    %     p32 = plot( t,Dthe_nl,'Color',red ); hold off;
    %     p32.LineWidth = 1.15;
    %     grid on;
    %     axis tight;
    %     ax=gca;
    %     ax.YAxis.FontSize = font_size;
    %     lgd = legend('$$\dot{\theta}$$ pomiar','$$\dot{\theta}$$ model','Location','southeast');        lgd.FontSize = legend_fontsize;
    %     lgd.FontSize = legend_fontsize;
    %     ax.XAxis.Visible = 'off'; 
    %     L = get(gca,'YLim');
    %     set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    %     set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    % subplot(515) % input voltage
    %     p40 = plot( time1,volt11,'Color','blue');
    %     p40.LineWidth = 1.15;
    %     % xl = ylabel('$v\ [V]$','FontSize',font_size, 'Rotation', 0)
    %     xlabel('$t\ [s]$','interpreter','latex','FontSize',font_size)
    %     % xl.Position(1) = xl.Position(1) - 0.33; % dla skok 8 V
    %     % xl.Position(1) = xl.Position(1) - 0.66;
    %     grid on;
    %     axis tight;
    %     ax=gca;
    %     ax.YAxis.FontSize = font_size;
    %     ax.XAxis.FontSize = font_size;
    %     lgd = legend('$$v$$ pomiar i model','Location','southeast');
    %     lgd.FontSize = legend_fontsize;
    %     L = get(gca,'YLim');
    %     set(gca,'YTick',linspace(L(1),L(2),NumTicks))
    %     set(gca,'xticklabel',num2str(get(gca,'xtick')','%.1f'))
    %     set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
    % drawnow
end

