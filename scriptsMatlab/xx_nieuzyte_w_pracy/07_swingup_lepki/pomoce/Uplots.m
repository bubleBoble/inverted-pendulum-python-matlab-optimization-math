fig = figure(1); 
clf(1)
subplot(4,4,1); 
plot(t, xw_nl, 'LineWidth', 2); grid on; hold on;
plot(t, xw_ref, '--', 'Color', 'red'); 
plot(t, xw_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
ylim([0, track_len]);
% legend('$$x_w$$', '$$x_w\ (lin)$$', '$$x_{w, ref}$$', 'Location','best');
title('$$x_w(t)$$, $$x_{w, ref}(t)$$', 'FontSize', 13);
% legend('$$x_w$$'', 'Location','best');

subplot(4,4,5);
plot(t, Dxw_nl, 'LineWidth', 2); hold on; grid on;
plot(t, Dxw_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
title('$$\dot{x}_w(t)$$', 'FontSize', 13);

subplot(4,4,9);
plot(t(2:end), diff(Dxw_nl)./dt, 'LineWidth', 2); grid on;
title('$$\ddot{x}_w(t)$$', 'FontSize', 13);
xlabel("t [sek]")

subplot(4,4,13);
plot(t, ctrl_sig, 'LineWidth', 2); hold on; grid on;
plot(t, ctrl_sig_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green');
title('$$u(t)$$', 'FontSize', 13);
ylim([-12, 12]);

subplot(4,4,2);
plot(t, the_nl, 'LineWidth', 2); hold on; grid on;
plot(t, the_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
title('$$\theta(t)$$', 'FontSize', 13);
% legend('$$\theta$$', '$$\theta\ (lin)$$', 'Location','best');
ylim([2, 4]);

subplot(4,4,6);
plot(t, Dthe_nl, 'LineWidth', 2); hold on; grid on;
plot(t, Dthe_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
title('$$\dot{\theta}(t)$$', 'FontSize', 13); 

subplot(4,4,10);
plot(t(2:end), diff(Dthe_nl)./dt, 'LineWidth', 2); grid on;
title('$$\ddot{\theta}(t)$$', 'FontSize', 13);
xlabel("t [sek]")

subplot(4,4,14);
plot(t, d, 'LineWidth', 2); grid on;
title('$$d(t)$$', 'FontSize', 13);

subplot(4,4,3)
plot(t, ctrl_e_xw, 'LineWidth', 2); grid on;
title('$$u(e_{x_w})$$', 'FontSize', 13);

subplot(4,4,11)
plot(t, ctrl_e_Dxw, 'LineWidth', 2); grid on;
title('$$u(e_{\dot{x}_w})$$', 'FontSize', 13);

subplot(4,4,7)
plot(t, ctrl_e_the, 'LineWidth', 2); grid on;
title('$$u(e_{\theta})$$', 'FontSize', 13);

subplot(4,4,15)
plot(t, ctrl_e_Dthe, 'LineWidth', 2); grid on;
title('$$u(e_{\dot{\theta}})$$', 'FontSize', 13);

title_str_format = "Q = diag[%d %d %d %d]\nR = %d\nF=[%.3f %.3f %.3f %.3f]";
title_str = sprintf(title_str_format, [diag(Q); R; F']);
sgtitle(title_str);
