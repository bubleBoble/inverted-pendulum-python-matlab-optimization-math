% SETTINGS for optimization
dt = 0.01; % potrzebuje dt tutaj
duration    = end_time;   % optimization final time
maxU        = 12;  % DCM saturation voltage
maxIter     = 100;
maxFunEval  = 1e7;      
accuracy    = 'high';
nGrid       = round(duration / dt / 10);  % for trapezoid method

% integrand function from path cost function
pathObjFunction = @(t,x,u)( 0.25*(u.^2) + 3*x(3, :).^2 + 2*x(4, :).^2 + 100*(x(1, :) - track_len) );

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

% method
method = 'trapezoid';
% method = 'hermiteSimpson';
% method = 'rungeKutta';
% method = 'chebyshev';

% initial guess
time_guess = [0,duration];
state_guess = [x0low, xflow];
control_guess = [0,0]; 


