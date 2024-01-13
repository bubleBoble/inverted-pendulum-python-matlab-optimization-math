%=======================================================================%
%
%   Main script to test finite time horizon LQR
%   uses:
%       fhLQR.m - finite horizon LQR
%
%=======================================================================%

clc; 
clear;
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex;

% settings
%=======================================================================%
track_len   = 0.47;         % track length
the0deg     = 180;          % initial pendulum angle
end_time    = 6;            % simulation final time
sat         = [12, -12];    % ctrl signal saturation
animacjaON  = 0;            % aniamtion on/off
save_anim   = 0;            % animation save on/off
enableLinmodel = 0;         % on/off linear system in simulink

%% Calculate optimal swingup trajectory
%  http://www.matthewpeterkelly.com/tutorials/trajectoryOptimization/index.html
%==========================================================================================%
run('utils.UoptimtrajSettings.m');              % all settings for optimTraj
run("utils.UoptimTrajSolve.m");                 % helper function for calculating optimTraj
model_name = 'model1';
run('utils.UsimulinkModelSetup.m')              % set smlk settings
run('utils.UoptimTrajSimulinkComparassion.m');  % run simulink model with optimTraj control signal
                                                % compare results FIGURE1
% outut : uOT_func(time)     - interpolated optimal control signal function
%         stateOT_func(time) - interpolated optimal state trajectory function

%% fhLQR.m - finite horizon LQR calculation - over trajectory
%==========================================================================================%
% LQR params
Qf = diag([0 0 0 0]); % weights for terminal state
Q = diag( [300e3, 0.2e3, 0, 0] );
R = 50;
tol = 1e-7;
tf = end_time;
nTime = 200; % The same number of samples for reference trajectory, and for calculated gain K
            % for interpolation
run('utils.run_fhLQR_trajectory.m')

%% Przyłożenie wzmocnień do modelu w simulinku
%==========================================================================================%
% simulation
%=======================================================================%
D=zeros(4,1); E=[1 0 0 0]; C=eye(4,4);
model_name = 'model2';
run('utils.UsimulinkModelSetup.m')
% here: xw_ref is taken from calculated optimal trajectory
run('utils.Uinputsignals.m'); run('utils.model_params.m');
IC = [track_len/2;the0deg*pi/180;0;0];
out = sim(sprintf('%s.slx', model_name));

% simulink output signals
%=======================================================================%
run('utils.Uoutputsignals.m') 

%%
% plots
%=======================================================================%
run('utils.Uplots.m');

% % Animacja
% %===========================================================================% 
% if animacjaON
%     utils.animate(IC, Lc, dt, xw_nl, the_nl*pi/180, t, save_anim, "vid_new");
% end
% 
