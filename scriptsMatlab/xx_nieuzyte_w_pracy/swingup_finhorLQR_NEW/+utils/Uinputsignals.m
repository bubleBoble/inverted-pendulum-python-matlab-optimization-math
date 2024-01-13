% time
%=======================================================================%
dt = 0.01;
t=0:(end_time/dt); t=t*dt;

% xw reference
%=======================================================================%
state_OT_func = stateOT_func(t);
xw_ref = state_OT_func(1,:) * 0; % przecież to musi być 0 bo regulator jest nieliniowy

% disturbances
%=======================================================================%
d = (utils.ustep(t, 2.5)-utils.ustep(t, 4.6)) * 0;

% Variable state feedback gains from 'fhLQR.m'
%=======================================================================%
% k_xw_fit - coeffs of interpolating polynomial for k_xw
% polynomials coeffs: k_xw_fit, k_the_fit, k_Dxw_fit, k_Dthe_fit
% polyval(arg1, arg2) - evaluates poly arg1 for argument arg2
k_xw    = polyval(k_xw_fit, t);
k_the   = polyval(k_the_fit, t);
k_Dxw   = polyval(k_Dxw_fit, t);
k_Dthe  = polyval(k_Dthe_fit, t);

% Input structure for simulink
%=======================================================================%
ind.time = t;
ind.signals(1).values = xw_ref';
ind.signals(1).dimensions = 1;
ind.signals(2).values = d';
ind.signals(2).dimensions = 1;
% gains
ind.signals(3).values = k_xw';
ind.signals(3).dimensions = 1;
ind.signals(4).values = k_the';
ind.signals(4).dimensions = 1;
ind.signals(5).values = k_Dxw';
ind.signals(5).dimensions = 1;
ind.signals(6).values = k_Dthe';
ind.signals(6).dimensions = 1;

