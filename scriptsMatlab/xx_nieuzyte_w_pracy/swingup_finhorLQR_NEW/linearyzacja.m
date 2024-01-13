% clc;
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex;

params_lin_vis = [0.416, 0.089, 0, 0.1225, 23.8299, 0.0035, 1.5417];
params_nonlin_stri = [0.4160, 0.0890, 0, 0.1225, 1.5417, 20.9, 0.0067, 0.0651, 0.1284, 13.9989];

[A, B, C, D, E, H] = macierze_lin('lepki gora', params_lin_vis);
% [A, B, C, D, E, H] = macierze_lin('stribeck gora', params_nonlin_stri);
