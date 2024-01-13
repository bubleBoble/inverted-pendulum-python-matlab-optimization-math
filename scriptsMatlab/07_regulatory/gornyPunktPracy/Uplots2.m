fig = figure(1); 
clf(1)
subplot(3,2,1);
plot(t, xw_nl, 'LineWidth', 2); grid on; hold on;
plot(t, xw_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green');
plot(t, xw_ref, '--', 'Color', 'red'); hold off;
ylim([0, track_len]);
% lgd = legend('$x_{\mathrm{w}}$ model nieliniowy','$x_{\mathrm{w}}$ model liniowy','$x_{\mathrm{w}}$ zadane', 'Location','best');
lgd = legend('$x_{\mathrm{1}}\ [m]$ model nieliniowy','$x_{\mathrm{1}} \ [m]$ model liniowy','$x_{\mathrm{1}} \ [m]$ zadane', 'Location','best');
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

subplot(3,2,3);
plot(t, Dxw_nl, 'LineWidth', 2); hold on; grid on;
plot(t, Dxw_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
% lgd = legend('$\dot{x}_w(t)$ model nieliniowy', '$\dot{x}_w(t)$ model liniowy', 'Location','best');
lgd = legend('$x_{\mathrm{3}}\ [m/s]$ model nieliniowy', '$x_{\mathrm{3}}\ [m/s]$ model liniowy', 'Location','best');
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
lgd.FontSize = 16;
% set(gca, 'XTickLabel', []);
ax.Box = 'on';
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');

subplot(3,2,5);
plot(t, ctrl_sig, 'LineWidth', 2); hold on; grid on;
plot(t, ctrl_sig_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green');
ylim([-12, 12]);
lgd = legend('$v\ [V]$ model nieliniowy', '$v\ [V]$ model liniowy', 'Location','best');
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
lgd.FontSize = 16;
% set(gca, 'XTickLabel', []);
ax.Box = 'on';
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');

subplot(3,2,2);
plot(t, the_nl, 'LineWidth', 2); hold on; grid on;
plot(t, the_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
% ylim([2, 4]);
lgd = legend('$x_{\mathrm{2}}\ [rad]$ model nieliniowy', '$x_{\mathrm{2}}\ [rad]$ model liniowy', 'Location','best');
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
lgd.FontSize = 16;
% set(gca, 'XTickLabel', []);
ax.Box = 'on';
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');

subplot(3,2,4);
plot(t, Dthe_nl, 'LineWidth', 2); hold on; grid on;
plot(t, Dthe_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
lgd = legend('$x_{\mathrm{4}}\ [rad/s]$ model nieliniowy', '$x_{\mathrm{4}}\ [rad/s]$ model liniowy', 'Location','best');
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
lgd.FontSize = 16;
% set(gca, 'XTickLabel', []);
ax.Box = 'on';
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');

subplot(3,2,6);
plot(t, d, 'LineWidth', 2); grid on;
lgd = legend('$d\ [N]$', 'Location','best');
ax = gca;
ax.YAxis.FontSize = 13;
ax.XAxis.FontSize = 13;
lgd.FontSize = 16;
xlabel('$t\ [s]$', 'Interpreter','latex');
% set(gca, 'XTickLabel', []);
ax.Box = 'on';
L = get(gca,'YLim');
set(gca,'YTick',linspace(L(1),L(2),10))
set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
xlabel('$t\ [s]$', 'Interpreter','latex');


 
% fig = figure(2); 
% clf(2)
% subplot(2,2,1)
% plot(t, ctrl_e_xw, 'LineWidth', 2); grid on;
% lgd = legend('$v_1\ [V]$','Location','northeast');
% lgd.FontSize = 16;
% ax = gca;
% ax.YAxis.FontSize = 13;
% ax.XAxis.FontSize = 13;
% % set(gca, 'XTickLabel', []);
% ax.Box = 'on';
% L = get(gca,'YLim');
% set(gca,'YTick',linspace(L(1),L(2),10))
% set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
% xlabel('$t\ [s]$', 'Interpreter','latex');
% 
% subplot(2,2,3)
% plot(t, ctrl_e_Dxw, 'LineWidth', 2); grid on;
% % title('$$u(e_{\dot{x}_w})$$', 'FontSize', 13);
% lgd = legend('$v_3\ [V]$','Location','northeast');
% lgd.FontSize = 16;
% ax = gca;
% ax.YAxis.FontSize = 13;
% ax.XAxis.FontSize = 13;
% % set(gca, 'XTickLabel', []);
% ax.Box = 'on';
% L = get(gca,'YLim');
% set(gca,'YTick',linspace(L(1),L(2),10))
% set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
% xlabel('$t\ [s]$', 'Interpreter','latex');
% 
% subplot(2,2,2)
% plot(t, ctrl_e_the, 'LineWidth', 2); grid on;
% % title('$$u(e_{\theta})$$', 'FontSize', 13);
% lgd = legend('$v_2\ [V]$','Location','northeast');
% lgd.FontSize = 16;
% ax = gca;
% ax.YAxis.FontSize = 13;
% ax.XAxis.FontSize = 13;
% % set(gca, 'XTickLabel', []);
% ax.Box = 'on';
% L = get(gca,'YLim');
% set(gca,'YTick',linspace(L(1),L(2),10))
% set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
% xlabel('$t\ [s]$', 'Interpreter','latex');
% 
% subplot(2,2,4)
% plot(t, ctrl_e_Dthe, 'LineWidth', 2); grid on;
% % title('$$u(e_{\dot{\theta}})$$', 'FontSize', 13);
% lgd = legend('$v_4\ [V]$','Location','northeast');
% lgd.FontSize = 16;
% ax = gca;
% ax.YAxis.FontSize = 13;
% ax.XAxis.FontSize = 13;
% % set(gca, 'XTickLabel', []);
% ax.Box = 'on';
% L = get(gca,'YLim');
% set(gca,'YTick',linspace(L(1),L(2),10))
% set(gca,'yticklabel',num2str(get(gca,'ytick')','%.2f'))
% xlabel('$t\ [s]$', 'Interpreter','latex');


