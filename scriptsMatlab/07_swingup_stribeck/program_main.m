%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%   OBLICZANIE OPTYM. TRAJEKTORII, SYMULACJA, ANIAMCJA
%   model stribeck
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
clc; clear;
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% JAKIE PARAMETRY DLA NIELINIOWEGO MODELU W SIMULINKU i do optymalizacji
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

% Parametry dla Stribecka
params_for_nonlin_mdl = "stribeck_4V_12V_rampa.mat";
load("pomoce/"+params_for_nonlin_mdl, "params_optim", "params_const");
params_const     = num2cell(params_const);
params_stribeck  = [cell2mat(params_optim), cell2mat(params_const)];

% params_stribeck = [1.7000, 4.6900, 17.1000,    0.0044,  0.0710,  0.1778, 1.0100,  0.4160, 0.0890, 0.0001,  0.1225];
% params_stribeck = [1.5417, 20.9,   0,          0.0067,  0.0651,  0.1284, 13.9989, 0.4160, 0.0890, 0.0001,  0.1225];
% params_stribeck = [1.5400  20.9004  0  0.0020  0.0644  0.1297  14.0001 0.4160  0.0890  0  0.1225];

params_stribeck = [1.5417, 20.9, 0, 0.002, 0.0651, 0.1284, 13.9989, 0.4160, 0.0890, 0.0001, 0.1225];

% alpha_dcm, beta_dcm, b_stri, gamma_stri, miu_c, miu_s, vs, M, mp, mc, Lp
% Model w simulink wynierany na podstawie nazwy pomiarów
model_name       = "model_stribeck";
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%   Ustawienia
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
lepkie_1_stribeck_0     = 1;
save_anim               = 0;
animateON               = 0;
track_len               = 0.407;
plotOT                  = 0;
end_time                = 4; %3;        % Czas końcowy dla animacji
dead_zone_ampl          = 1.0;          % Martwa strefa napięcia do silnika w MODELU
% n                       = 1;            % Liczba iteracji optymalizacji.

% Dla Optymalizacji
dt          = 0.005;         % Potrzebuje dt tutaj, 0.001?.
duration    = end_time;      % Końcowy czas dla optymalizacji - taki sam jak symulacji w simulinku.
maxU        = 12;            % Ograniczenie napięcia na silniku.
maxIter     = 2000;
maxFunEval  = 1e7;      
accuracy    = 'high';
nGrid       = duration / dt / 10;%25;  % for trapezoid method

% nSegment_hermiteSimpson;    % problem.options.hermiteSimpson.nSegment = 
% nColPts_chebyshev = 10;          % problem.options.chebyshev.nColPts = 
% nSegment_RK=100;               % problem.options.rungeKutta.nSegment 
% nSubSteps_RK=3;               % problem.options.rungeKutta.nSubStep 
problem.options.nlpOpt = optimset(...
    'Display','iter',...
    'MaxFunEvals',maxFunEval, ....
    'MaxIter', maxIter);

method = 'trapezoid';
% method = 'hermiteSimpson';
% method = 'rungeKutta';
% method = 'chebyshev';

problem.options.trapezoid.nGrid = nGrid;
% (Funkcja podcałowa z funk. celu)
pathObjFunction = @(t,x,u)( 0.001*(u.^2) );

% initial & final state constraints
% x0low       = [track_len/2;pi;0;0];
x0low       = [0.06  ;  pi  ;  0  ;  0];
x0upp       = x0low;

xflow       = [track_len/2-0.1  ;  -4*pi/180  ; 0; 0];
xfupp       = [track_len/2-0.05  ;   4*pi/180  ; 0; 0];
% xflow       = [0.1;  -4*pi/180  ; -100; -100];
% xfupp       = [0.3;   4*pi/180  ;  100;  100];

% state & control sig. constraints
xlow    = [0+0.05;              -6*pi;      -inf;       -inf];
xupp    = [track_len-0.05;       6*pi;       inf;        inf];
ulow    = -maxU;
uupp    =  maxU;

% time constraints
t0low   = 0;
t0upp   = 0;
tflow   = end_time;
tfupp   = tflow;

% initial guess - prosta od początku do końca dla każdego stanu.
time_guess      = [0,duration];
state_guess     = [x0low, xflow];
control_guess   = [0,0]; 
% ----------------------------------------------------------------------------
% ----------------------------------------------------------------------------
% ODPALENIE OPTYMALIZACJI
run("UoptTrajHelpScript.m");

%%
%=========================================================================%
%   Symulacja
%=========================================================================%
% na chwile
% load("dobredobre_fajne_mega.mat")
%
IC = x0low; 
dt = 0.001;
time = 0:dt:end_time;

ind.time = time;
ind.signals(1).values = uOT_func(time)';
ind.signals(1).dimensions = 1;
d = zeros(size(ind.signals(1).values));
ind.signals(2).values = d';
ind.signals(2).dimensions = 1;


ind.time = time';
ind.signals(1).values = uOT_func(time)';
ind.signals(1).dimensions = 1;
d = zeros(size(ind.signals(1).values));
ind.signals(2).values = d;
ind.signals(2).dimensions = 1;

run("pomoce/UsimulinkModelSetup");

out = sim('model_stribeck.slx');

% Wyniki z optimTraj: tOT, xwOT, theOT, DxwOT, DtheOT, uOT
% Wyniki z simulinka
t            = out.tout;
%nieliniowy
d            = out.out.getElement('dist').Values.Data;
xw_nl        = out.out.getElement('xw_nl').Values.Data;
the_nl       = out.out.getElement('the_nl').Values.Data;
Dxw_nl       = out.out.getElement('Dxw_nl').Values.Data;
Dthe_nl      = out.out.getElement('Dthe_nl').Values.Data;
% sygnał sterujący i składowe
ctrl_sig_nl  = out.out.getElement('ctrl_sig').Values.Data;

%=========================================================================%
%   Ploty z symulacji i z optymalizacji
%=========================================================================%
figure(1);
subplot(321);
plot(tOT, xwOT, t, xw_nl);
ylabel('x');
grid;
subplot(322);
plot(tOT, theOT, t, the_nl);
ylabel('the');
grid;
subplot(323);
plot(tOT, DxwOT, t, Dxw_nl);
ylabel('dx');
grid;
subplot(324);
plot(tOT, DtheOT, t, Dthe_nl);
ylabel('dthe');
grid;
subplot(325);
plot(tOT, uOT, t, ctrl_sig_nl);
ylabel('u');
grid;

disp('step size:');
disp(soln.info.stepsize);
disp('NLP time');
disp(soln.info.nlpTime);

%=========================================================================%
%   Animacja
%=========================================================================%
return; % odpalać ręcznie.
Lp = params_stribeck(end);
Lc = 2*Lp;
if animateON
    utils.animate(IC, Lc, dt, xw_nl, the_nl, t, save_anim)
end


