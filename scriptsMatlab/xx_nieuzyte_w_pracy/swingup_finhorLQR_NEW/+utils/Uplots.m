%=======================================================================================%
% FIG 2 (FIGURE 1 IS IN UoptimTrajSimulinkComparassion.m)
%=======================================================================================%
f2 = figure(2); 
subplot(421); 
plot(t, xw_nl, 'LineWidth', 2); grid on; hold on;
plot(t, xw_ref, '--', 'Color', 'red'); 
plot(t, xw_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
ylim([0, track_len]);
% legend('$$x_w$$', '$$x_{w, ref}$$', '$$x_w\ (lin)$$', 'Location','best');
% title('$$x_w(t)$$, $$x_{w, ref}(t)$$', 'FontSize', 13);

subplot(422);
plot(t, the_nl, 'LineWidth', 2); hold on; grid on;
plot(t, the_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
% title('$$\theta(t)$$', 'FontSize', 13);
% legend('$$\theta$$', '$$\theta\ (lin)$$', 'Location','best');

subplot(423);
plot(t, Dxw_nl, 'LineWidth', 2); hold on; grid on;
plot(t, Dxw_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
% title('$$\dot{x}_w(t)$$', 'FontSize', 13);

subplot(424);
plot(t, Dthe_nl, 'LineWidth', 2); hold on; grid on;
plot(t, Dthe_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
% title('$$\dot{\theta}(t)$$', 'FontSize', 13); 

subplot(425);
plot(t, ctrl_sig, 'LineWidth', 2); hold on; grid on;
plot(t, ctrl_sig_l, 'LineWidth', 1.4, 'LineStyle', '--', 'Color', 'green'); hold off;
% title('$$u(t)$$', 'FontSize', 13);

subplot(426);
plot(t, d, 'LineWidth', 2); grid on;
% title('$$d(t)$$', 'FontSize', 13);

subplot(427);
plot(t(2:end), diff(Dxw_nl)./dt, 'LineWidth', 2); grid on;
% title('$$\ddot{x}_w(t)$$', 'FontSize', 13);
% xlabel("t [sek]")

subplot(428);
plot(t(2:end), diff(Dthe_nl)./dt, 'LineWidth', 2); grid on;
% title('$$\ddot{\theta}(t)$$', 'FontSize', 13);
% xlabel("t [sek]")

% title_str_format = "Q = diag[%d %d %d %d]\nR = %d";
% title_str = sprintf(title_str_format, [diag(Q); R]);
% sgtitle(title_str);

%=======================================================================================%
% FIG 3
%=======================================================================================%
% f3 = figure(3);
% 
% subplot(221);
% plot(ind.time, k_xw); grid on
% % title('$$ k_{x_w} $$');
% 
% subplot(222);
% plot(ind.time, k_the); grid on
% % title('$$ k_{\theta} $$');
% 
% subplot(223);
% plot(ind.time, k_Dxw); grid on
% % title('$$ k_{\dot{x}_w} $$');
% 
% subplot(224);
% plot(ind.time, k_Dthe); grid on
% % title('$$ k_{\dot{\theta}} $$');
% 
% sgtitle('Gain trajectories');

K(1,:)

% %=======================================================================================%
% % FIG 4
% %=======================================================================================%
% E = reshape([soln.E], 4, nTime);
% E = real(E);
% f4 = figure(4);
% 
% subplot(221);
% plot(tsol, E(1, :)); grid on
% % title('$$ eig[A-BK]\ pole\ 1 $$');
% 
% subplot(222);
% plot(tsol, E(2, :)); grid on
% % title('$$ eig[A-BK]\ pole\ 2 $$');
% 
% subplot(223);
% plot(tsol, E(3, :)); grid on
% % title('$$ eig[A-BK]\ pole\ 3 $$');
% 
% subplot(224);
% plot(tsol, E(4, :)); grid on
% % title('$$ eig[A-BK]\ pole\ 4 $$');
% 
% sgtitle('Real part of closed loop system');













