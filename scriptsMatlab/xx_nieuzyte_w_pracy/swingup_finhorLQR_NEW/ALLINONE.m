clc; 
clear;
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex;

track_len   = 0.47;         % track length
the0deg     = 180;          % initial pendulum angle
end_time    = 4;            % simulation final time
sat         = [12, -12];    % ctrl signal saturation
animacjaON  = 0;            % aniamtion on/off
save_anim   = 0;            % animation save on/off
enableLinmodel = 0;         % on/off linear system in simulink

%% Calculate optimal swingup trajectory
%=========================================================================%
%                        SETTINGS for optimization                        %
%=========================================================================%
dt = 0.01; % potrzebuje dt tutaj
duration    = end_time;   % optimization final time
maxU        = 12;  % DCM saturation voltage
maxIter     = 1e3;
maxFunEval  = 1e7;      
accuracy    = 'high';

nGrid       = round(duration / dt / 2);  % for trapezoid method

nSegment_hermiteSimpson = round(duration/dt / 100);

nColPts_chebyshev = round(duration/dt / 500);

nSubSteps_RK = 2;
nSegment_RK = round(duration/dt / 100);
%=========================================================================%
%                                method                                   %
%=========================================================================%
% method
% method = 'trapezoid';
% method = 'hermiteSimpson';
% method = 'rungeKutta';
method = 'chebyshev';

%=========================================================================%
%                     path objective function integrand                   %
%=========================================================================%
% pathObjFunction = @(t,x,u)( 0.25*(u.^2) + 3*x(3, :).^2 + 2*x(4, :).^2 + 100*(x(1, :) - track_len) );
pathObjFunction = @(t,x,u)( 0.25*(u.^2)  );

%=========================================================================%
%                              Constraints                                %
%=========================================================================%
% initial & final state constraints
x0low   = [track_len/2;pi;0;0];
x0upp   = x0low;
xflow    = [track_len/2; 0; 0; 0];
xfupp    = xflow;

% state & control sig. constraints
xlow    = [0; -3*pi;-inf;-inf];
xupp    = [track_len; 3*pi;inf;inf];
ulow    = -maxU;
uupp    = maxU;

% time constraints
t0low   = 0;
t0upp   = 0;
tflow   = duration;
tfupp   = duration;

%=========================================================================%
%                            initial guess                                %
%=========================================================================%
time_guess = [0,duration];
state_guess = [x0low, xflow];
control_guess = [0,0]; 

%=========================================================================%
%                     Set up function handles                             %
%=========================================================================%
run('utils.model_params.m')
problem.func.dynamics   = @(t,x,u)( utils.IPdynamics(x,u,params_lepkie) );
problem.func.pathObj    = pathObjFunction;

%=========================================================================%
%                     Set up problem bounds                               %
%=========================================================================%
problem.bounds.initialTime.low = t0low;
problem.bounds.initialTime.upp = t0upp;
problem.bounds.finalTime.low = tflow;
problem.bounds.finalTime.upp = tfupp;

problem.bounds.initialState.low = x0low;
problem.bounds.initialState.upp = x0upp;
problem.bounds.finalState.low = xflow;
problem.bounds.finalState.upp = xfupp;

problem.bounds.state.low = xlow;
problem.bounds.state.upp = xupp;

problem.bounds.control.low = ulow;
problem.bounds.control.upp = uupp;

%=========================================================================%
%                    Initial guess at trajectory                          %
%=========================================================================%
problem.guess.time = time_guess;
problem.guess.state = state_guess;
problem.guess.control = control_guess;

%=========================================================================%
%                         Solver options                                  %
%=========================================================================%
problem.options.nlpOpt = optimset(...
    'Display','iter',...
    'MaxFunEvals',maxFunEval, ....
    'MaxIter', maxIter);
problem.options.trapezoid.nGrid = nGrid;
% problem.options.hermiteSimpson.nSegment = duration/dt / 5;
% problem.options.chebyshev.nColPts
problem.options.rungeKutta.nSegment = 40;
problem.options.rungeKutta.nSubStep = 3;

problem.options.method = method;
problem.options.verbose = 3;
problem.options.defaultAccuracy = accuracy;
%=========================================================================%
%                            Solve                                        %
%=========================================================================%
soln = optimTraj(problem);  
disp("===================================================================================")
disp("[XXX] OPTIM TRAJ DONE")
disp("===================================================================================")
%=========================================================================%
%                     Unpack the simulation                               %
%=========================================================================%
tOT = linspace(soln.grid.time(1), soln.grid.time(end), end_time/dt);
stateOT = soln.interp.state(tOT);
uOT = soln.interp.control(tOT);
uOT_func = soln.interp.control;
stateOT_func = soln.interp.state;

xOT    = stateOT(1, :);
theOT  = stateOT(2, :);
dxOT   = stateOT(3, :);
dtheOT = stateOT(4, :);

model_name = 'model1';
load_system(sprintf('%s', model_name))
set_param(...
    sprintf('%s', model_name),...
    'Solver','ode45',...
    'StopTime',sprintf('%d', end_time))
set_param(sprintf('%s', model_name),"FastRestart","off")
set_param(sprintf('%s', model_name),'AccelVerboseBuild','on')
set_param(sprintf('%s', model_name),'SimulationMode','normal') % accelerator
set_param(sprintf('%s', model_name),'SimCompilerOptimization','on')

IC = [track_len/2, pi, 0, 0]'; 
dt = 0.001;
time = 0:dt:end_time;
run('utils.model_params.m')

ind1.time = time';
ind1.signals(1).values = uOT_func(time)';
ind1.signals(1).dimensions = 1;
ind1.signals(2).values = zeros( size(ind1.signals(1).values) );
ind1.signals(2).dimensions = 1;

%simulation
out = sim('model1.slx');

% Simulink solution (optimTRaj solution: % tOT, xOT, theOT, dxOT, dtheOT, uOT)
t        = out.tout;
d        = out.out.getElement('d_sim').Values.Data;
xw_nl    = out.out.getElement('xw_nl').Values.Data;
the_nl   = out.out.getElement('the_nl').Values.Data;
Dxw_nl   = out.out.getElement('Dxw_nl').Values.Data;
Dthe_nl  = out.out.getElement('Dthe_nl').Values.Data;
ctrl_sig = out.out.getElement('v_sim').Values.Data;

disp("===================================================================================")
disp("[XXX] SIMULINK FOR SIM COMPARASION DONE")
disp("===================================================================================")

% Plot comparassion
figure(1);
subplot(321)
plot(tOT, xOT, t, xw_nl)
ylabel('x')
grid
legend('optimTraj', 'simulink');
subplot(322)
plot(tOT, theOT*180/pi, t, the_nl)
ylabel('the')
grid
subplot(323)
plot(tOT, dxOT, t, Dxw_nl)
ylabel('dx')
grid
subplot(324)
plot(tOT, dtheOT*180/pi, t, Dthe_nl)
ylabel('dthe')
grid
subplot(325)
plot(tOT, uOT, t, ctrl_sig)
ylabel('u')
grid
sgtitle('Simulink sim vs optimTraj sim results')



























