%=========================================================================%
%   tutaj można zmieniać:
%       - ograniczenia: stan, sterowanie, czas
%         wartości początkowych, końcowych i dla całego przebiegu
%=========================================================================%

%=========================================================================%
%                     Set up function handles                             %
%=========================================================================%
problem.func.dynamics   = @(t,x,u)( IPdynamics_vis(x,u,params_lepkie) );
problem.func.pathObj    = pathObjFunction;

%=========================================================================%
%                     Set up problem bounds                               %
%=========================================================================%
problem.bounds.initialTime.low      = t0low;
problem.bounds.initialTime.upp      = t0upp;
problem.bounds.finalTime.low        = tflow;
problem.bounds.finalTime.upp        = tfupp;
problem.bounds.initialState.low     = x0low;
problem.bounds.initialState.upp     = x0upp;
problem.bounds.finalState.low       = xflow;
problem.bounds.finalState.upp       = xfupp;
problem.bounds.state.low            = xlow;
problem.bounds.state.upp            = xupp;
problem.bounds.control.low          = ulow;
problem.bounds.control.upp          = uupp;
%=========================================================================%
%                    Initial guess at trajectory                          %
%=========================================================================%
problem.guess.time      = time_guess;
problem.guess.state     = state_guess;
problem.guess.control   = control_guess;
%=========================================================================%
%                         Solver options                                  %
%=========================================================================%
problem.options.nlpOpt = optimset(...
    'Display','iter',...
    'MaxFunEvals',maxFunEval, ....
    'MaxIter', maxIter);
problem.options.trapezoid.nGrid = nGrid;

% ZMIENNA method i accuracy JEST ZE SKRYPTU "sim_script.m"
problem.options.method          = method;
problem.options.verbose         = 3;
problem.options.defaultAccuracy = accuracy;
%=========================================================================%
%                            Solve                                        %
%=========================================================================%
soln = optimTraj(problem); 

tOT             = linspace(soln.grid.time(1), soln.grid.time(end), end_time/dt);
stateOT         = soln.interp.state(tOT);
uOT             = soln.interp.control(tOT);
uOT_func        = soln.interp.control;
stateOT_func    = soln.interp.state;

xwOT            = stateOT(1, :);
theOT           = stateOT(2, :);
DxwOT           = stateOT(3, :);
DtheOT          = stateOT(4, :);

if plotOT
    figure(1);
    
    subplot(321)
    plot(tOT, xwOT)
    ylabel('xw')
    grid
    
    subplot(322)
    plot(tOT, theOT)
    ylabel('the')
    grid
    
    subplot(323)
    plot(tOT, DxwOT)
    ylabel('dx')
    grid
    
    subplot(324)
    plot(tOT, DtheOT)
    ylabel('dthe')
    grid
    
    subplot(325)
    plot(tOT, uOT)
    ylabel('u')
    grid
end

% SOLNS = [];
% for k=1:n
%     soln = optimTraj(problem); 
%     SOLNS = [SOLNS; soln];
%     % Unpack sim n
%     tOT = linspace(soln.grid.time(1), soln.grid.time(end), end_time/dt);
%     stateOT = soln.interp.state(tOT);
%     uOT = soln.interp.control(tOT);
%     uOT_func = soln.interp.control;
%     stateOT_func = soln.interp.state;
% 
%     xwOT   = stateOT(1, :);
%     theOT  = stateOT(2, :);
%     DxwOT  = stateOT(3, :);
%     DtheOT = stateOT(4, :);
% 
%     % new guess = current solution
%     problem.guess.time = tOT;
%     problem.guess.state = stateOT;
%     problem.guess.control = uOT;
% 
%     if plotOT
%         figure(1);
% 
%         subplot(321)
%         plot(tOT, xwOT)
%         ylabel('xw')
%         grid
% 
%         subplot(322)
%         plot(tOT, theOT)
%         ylabel('the')
%         grid
% 
%         subplot(323)
%         plot(tOT, DxwOT)
%         ylabel('dx')
%         grid
% 
%         subplot(324)
%         plot(tOT, DtheOT)
%         ylabel('dthe')
%         grid
% 
%         subplot(325)
%         plot(tOT, uOT)
%         ylabel('u')
%         grid
%     end
%     pause;
% end






