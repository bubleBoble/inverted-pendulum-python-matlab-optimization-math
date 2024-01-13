%
%   Main script to test finite time horizon LQR
%   uses:
%       fhLQR.m - finite horizon LQR
%

clc; 
clear;
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex;

%% fhLQR.m
%==========================================================================================%
[A,B,H]=utils.macierze_mdl_liniowy(2); % górne położenia, tarcie lepkie

% LQR params
Qf = diag([0 0 0 0]); % weights for terminal state
Q = diag( [300e3, 0.2e3, 0, 0] );
R = 50;
tol = 1e-7;
tf = 10;
nTime = 70; % The same number of samples for reference trajectory, and for calculated gain K
            % for interpolation
tsol = linspace(0, tf, nTime);

% gain interpolation
%==========================================================================================%
soln = fhLQR(tsol,A,B,Q,R,Qf,tol);
K = reshape([soln.K], 4, nTime);

nFit = 5; % poly order
k_xw_fit    = polyfit(tsol, K(1,:), nFit);  % polyfit zwraca wzpółczynniki wielomianów
k_the_fit   = polyfit(tsol, K(2,:), nFit);  % polyval - ewaluuje wielomian ze wsp.
k_Dxw_fit   = polyfit(tsol, K(3,:), nFit);
k_Dthe_fit  = polyfit(tsol, K(4,:), nFit);
% sygnały wejściowe do simulinka obliczone z tych wpasowań są napisane 
% w pliku 'skrypty_pomoce/Uinputsignals.m'

% settings
%=======================================================================%
track_len   = 0.47;         % długość suwnicy
the0deg     = 0;            % początkowa wartość kąta wychylenia wahadła
end_time    = tf;           % końcowy czas symulacji - TAKI SAM JAK CZAS fhLQR
sat         = [12, -12];    % saturacja sygnału sterującego
animacjaON  = 0;            % animacja on/off
save_anim   = 0;            % zapisanie animacji on/off
enableLinmodel = 1;         % on/off system liniowy w modelu
model_name = 'model_lqr_gora';

%% Przyłożenie wzmocnień do modelu w simulinku
%==========================================================================================%

% simulation
%=======================================================================%
D=zeros(4,1); E=[1 0 0 0]; C=eye(4,4);
run('skrypty_pomoce.UsimulinkModelSetup.m')
run('skrypty_pomoce.Uinputsignals.m'); run('utils.model_params.m');
% out = sim('model_lqr_gora.slx','SimulationMode','accelerator');
IC = [track_len/2;the0deg*pi/180;0;0];
out = sim(sprintf('%s.slx', model_name));
accelbuild(sprintf('%s', model_name));

% simulink output signals
%=======================================================================%
run('skrypty_pomoce.Uoutputsignals.m') 

% plots
%=======================================================================%
f1 = figure(1);
run('skrypty_pomoce.Uplots.m');
% set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',12,'FontWeight','Bold', 'LineWidth', 2);
% Closed loop system poles
E = reshape([soln.E], 4, nTime);
E = real(E);
f2 = figure(2);

subplot(221);
plot(tsol, E(1, :)); grid on
title('$$ eig[A-BK]\ pole\ 1 $$');

subplot(222);
plot(tsol, E(2, :)); grid on
title('$$ eig[A-BK]\ pole\ 2 $$');

subplot(223);
plot(tsol, E(3, :)); grid on
title('$$ eig[A-BK]\ pole\ 3 $$');

subplot(224);
plot(tsol, E(4, :)); grid on
title('$$ eig[A-BK]\ pole\ 4 $$');

sgtitle('Real part of closed loop system');
% set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',12,'FontWeight','Bold', 'LineWidth', 2);

%varying gain
f3 = figure(3);

subplot(221);
plot(ind.time, k_xw); grid on
title('$$ k_{x_w} $$');

subplot(222);
plot(ind.time, k_the); grid on
title('$$ k_{\theta} $$');

subplot(223);
plot(ind.time, k_Dxw); grid on
title('$$ k_{\dot{x}_w} $$');

subplot(224);
plot(ind.time, k_Dthe); grid on
title('$$ k_{\dot{\theta}} $$');

sgtitle('Gain trajectories');
% set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',12,'FontWeight','Bold', 'LineWidth', 2);
% Animacja
%===========================================================================% 
if animacjaON
    utils.animate(IC, Lc, dt, xw_nl, the_nl*pi/180, t, save_anim, "vid_new");
end

