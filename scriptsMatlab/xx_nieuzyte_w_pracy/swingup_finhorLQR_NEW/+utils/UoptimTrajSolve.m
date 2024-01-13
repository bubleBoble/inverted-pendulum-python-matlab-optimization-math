%=========================================================================%
%                   HELPER SCRIPT - optimTraj
%=========================================================================%

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

problem.options.hermiteSimpson.nSegment = nSegment_hermiteSimpson;

problem.options.chebyshev.nColPts = nColPts_chebyshev;

problem.options.rungeKutta.nSegment = nSegment_RK;
problem.options.rungeKutta.nSubStep = nSubSteps_RK;


problem.options.method = method;
problem.options.verbose = 3;
problem.options.defaultAccuracy = accuracy;
%=========================================================================%
%                            Solve                                        %
%=========================================================================%
soln = optimTraj(problem);  

%%
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

%=========================================================================%
%                            Plot                                         %
%=========================================================================%
if 0 % ustawić na 1 tylko żeby zobaczyć wygenerowane przebiegi
    figure();
    
    subplot(321)
    plot(tOT, xOT)
    ylabel('x')
    title('Single Pendulum Swing-Up');
    grid
    
    subplot(322)
    plot(tOT, theOT)
    ylabel('the')
    grid
    
    subplot(323)
    plot(tOT, dxOT)
    ylabel('dx')
    grid
    
    subplot(324)
    plot(tOT, dtheOT)
    ylabel('dthe')
    grid
    
    subplot(325)
    plot(tOT, uOT)
    ylabel('u')
    grid
end