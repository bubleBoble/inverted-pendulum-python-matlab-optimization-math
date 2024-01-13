if ~bdIsLoaded(sprintf('%s', model_name))
    load_system(sprintf('%s', model_name))
end
set_param(...
    sprintf('%s', model_name),...
    'Solver','ode45',...
    'StopTime',sprintf('%d', end_time))
set_param(sprintf('%s', model_name),"FastRestart","off")
% set_param(sprintf('%s', model_name),'AccelVerboseBuild','on')
% set_param(sprintf('%s', model_name),'SimulationMode','accelerator')
set_param(sprintf('%s', model_name),'SimulationMode','normal')
% set_param(sprintf('%s', model_name),'SimCompilerOptimization','on')

