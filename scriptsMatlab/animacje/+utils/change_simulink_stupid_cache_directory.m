%% Change simulink cache folders temporarly
cfg = Simulink.fileGenControl('getConfig');
cfg.CacheFolder = fullfile(eval(['pwd']),'generatedCacheSimulink');
cfg.CodeGenFolder = fullfile(eval(['pwd']),'generatedCodeSimulink');
Simulink.fileGenControl('setConfig', 'config', cfg,'createDir',true);
% Simulink.FileGenConfig -> to check if default cache dirs settings are set
% after this session
