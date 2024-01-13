tsol = linspace(0, tf, nTime);

[Afunc, Bfunc] = utils.setUpgetABoverTrajectory();   % writes a function getABoverTrajectory that returns A,B matrices
% Afunc = f(xw, the, Dxw, Dthe), Bfunc the same
% sgetAB() passed to the fhLQR() has to be a function of only time
% sgetAB() i a wrapper for Afunc, Bfunc

getAB = @(t)( utils.sgetAB(t, Afunc, Bfunc, stateOT_func, uOT_func) );
soln = utils.fhLQR_traj(tsol,getAB,Q,R,Qf,tol);

% state and control signal trajectory interpolation
%==========================================================================================%
% no need for that bcs optimTraj returns interpolated functions of state and control
% state_OT = stateOT_func(nTime);
% xw_OT       = state_OT(1, :);
% the_OT      = state_OT(2, :);
% Dxw_OT      = state_OT(3, :);
% Dthe_OT     = state_OT(4, :);
% u_OT        = uOT_OT(nTime);
% 
% nFit = 5; % poly order
% xw_fit      = polyfit(tSol,xw_OT,nFit);
% the_fit     = polyfit(tSol,the_OT,nFit);
% Dxw_fit     = polyfit(tSol,Dxw_OT,nFit);
% Dthe_fit    = polyfit(tSol,Dthe_OT,nFit);
% u_fit       = polyfit(tSol,u_OT,nFit);

% gain trajectory interpolation
%==========================================================================================%
K = reshape([soln.K], 4, nTime);

nFit = 12; % poly order
k_xw_fit    = polyfit(tsol, K(1,:), nFit);  % polyfit returns polynomial coeffs
k_the_fit   = polyfit(tsol, K(2,:), nFit);  % polyval - evaluates poly from poly coeffs
k_Dxw_fit   = polyfit(tsol, K(3,:), nFit);
k_Dthe_fit  = polyfit(tsol, K(4,:), nFit);

figure(5)
stem(K(1,:)); hold on;
plot(polyval(k_xw_fit, tsol)); 
hold off;