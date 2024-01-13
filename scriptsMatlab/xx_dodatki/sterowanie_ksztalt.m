clear; clc;

e1 = -0.04:0.0001:0.05;
e2 = linspace(-0.1, 0.1, length(e1));

[ux1, ux2] = ctrl_downpos(e1, e2);

for i=1:length(e1)
    [ux1_arr(i), ux2_arr(i)] = ctrl_downpos(e1(i), e2(i));
end    

figure(1)
plot(e1, ux1_arr, LineWidth=2); grid on; axis tight; hold on
xlabel('$e_{\mathrm{1}}\ [m]$', 'Interpreter','latex');
ylabel('$c_{\mathrm{1}}\ [V]$', 'Interpreter','latex');
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
% lgd.FontSize = legend_fontsize;
% ax.XAxis.Visible = 'off'; 
% L = get(gca,'YLim');
% set(gca,'YTick',linspace(L(1),L(2),NumTicks))
% set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
% ax.Box = 'on';

figure(2)
plot(e2, ux2_arr, LineWidth=2); grid on; axis tight; hold on
xlabel('$e_{\mathrm{2}}\ [rad]$', 'Interpreter','latex');
ylabel('$c_{\mathrm{2}}\ [V]$', 'Interpreter','latex');
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;

% Regulator dla dolnego punktu równowagi
function [ux1, ux2] = ctrl_downpos(e1, e2)
    F1 = 44.72136;
    F2 = 17.707104;
    x1_allowed_error = 0.002;
    if( e1 > x1_allowed_error )
        ux1 =   tanh( 800 * e1 ) .* ( F1*e1 + 1 );
    elseif( e1 < -x1_allowed_error)
        ux1 = - tanh( 800 * e1 ) .* ( F1*e1 - 1 );
    else
        ux1 = 0;
    end
    % if( e1 > 0.002 )
    %     ux1 =   F1*e1 + 1;
    % elseif( e1 < -0.002)
    %     ux1 =   F1*e1 - 1;
    % else
    %     ux1 = 0;
    % end

    if( abs( e2 ) < 1*pi/180 )
        ux2 = 0;
    else
        ux2 = F2 * e2;
    end
end

