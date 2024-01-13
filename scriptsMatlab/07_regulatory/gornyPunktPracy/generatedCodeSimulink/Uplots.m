fig = figure(1); 
clf(1)
subplot(421); 
plot(t, xw_nl, 'LineWidth', 2); grid on; hold on;
plot(t, xw_ref, '--', 'Color', 'red'); 
plot(t, xw_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
ylim([0, track_len]);
% legend('$$x_w$$', '$$x_w\ (lin)$$', '$$x_{w, ref}$$', 'Location','best');
title('$$x_w(t)$$, $$x_{w, ref}(t)$$', 'FontSize', 13);
% legend('$$x_w$$'', 'Location','best');

subplot(422);
plot(t, the_nl, 'LineWidth', 2); hold on; grid on;
plot(t, the_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
title('$$\theta(t)$$', 'FontSize', 13);
legend('$$\theta$$', '$$\theta\ (lin)$$', 'Location','best');
ylim([2, 4]);

subplot(423);
plot(t, Dxw_nl, 'LineWidth', 2); hold on; grid on;
plot(t, Dxw_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
title('$$\dot{x}_w(t)$$', 'FontSize', 13);

subplot(424);
plot(t, Dthe_nl, 'LineWidth', 2); hold on; grid on;
plot(t, Dthe_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
title('$$\dot{\theta}(t)$$', 'FontSize', 13); 

subplot(425);
plot(t, ctrl_sig, 'LineWidth', 2); hold on; grid on;
plot(t, ctrl_sig_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green');
plot(t, ctrl_sig_raw, 'LineWidth', 0.25); hold off;
title('$$u(t)$$', 'FontSize', 13);
ylim([-12, 12]);

subplot(426);
plot(t, d, 'LineWidth', 2); grid on;
title('$$d(t)$$', 'FontSize', 13);

subplot(427);
plot(t(2:end), diff(Dxw_nl)./dt, 'LineWidth', 2); grid on;
title('$$\ddot{x}_w(t)$$', 'FontSize', 13);
xlabel("t [sek]")

subplot(428);
plot(t(2:end), diff(Dthe_nl)./dt, 'LineWidth', 2); grid on;
title('$$\ddot{\theta}(t)$$', 'FontSize', 13);
xlabel("t [sek]")

title_str_format = "Q = diag[%d %d %d %d]\nR = %d";
title_str = sprintf(title_str_format, [diag(Q); R]);
sgtitle(title_str);