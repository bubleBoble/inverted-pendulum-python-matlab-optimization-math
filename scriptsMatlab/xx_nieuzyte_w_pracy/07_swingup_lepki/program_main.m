%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% Tylko dla modelu LEPKIEGO
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
clc; clear;
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex;
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% JAKIE PARAMETRY DLA NIELINIOWEGO MODELU W SIMULINKU i do optymalizacji
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% params_for_nonlin_mdl = "skok_lepki_2V.mat";
% params_for_nonlin_mdl = "skok_lepki_4V.mat";
% params_for_nonlin_mdl = "skok_lepki_6V.mat";
% params_for_nonlin_mdl = "skok_lepki_8V.mat";
% params_for_nonlin_mdl = "skok_lepki_10V.mat";
% params_for_nonlin_mdl = "skok_lepki_12V.mat";
params_for_nonlin_mdl = "lepki_4V_12V_skok.mat";
model_name = "model_lepki";

% Parametry dla lepkiego
load("pomoce/"+params_for_nonlin_mdl, "params_optim", "const_params");
const_params     = num2cell(const_params);
params_lepkie    = [cell2mat(params_optim), cell2mat(const_params)];

% [Bp, gamma_vis, alpha_dcm, M, mp, mc, Lp]  
% params_lepkie = [23.8299, 0.0035, 1.5417, 0.416, 0.089, 0.001, 0.1225];
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%   Ustawienia
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
lepkie_1_stribeck_0     = 1;
save_anim               = 0;
animateON               = 0;
track_len               = 0.407;
plotOT                  = 1;
end_time                = 3;      % Czas końcowy dla animacji
dead_zone_ampl          = 1.0;    % Martwa strefa napięcia do silnika w MODELU
n                       = 1;      % Liczba iteracji optymalizacji.

% Dla Optymalizacji
dt          = 0.001;          % Potrzebuje dt tutaj.
duration    = end_time;      % Końcowy czas dla optymalizacji - taki sam jak symulacji w simulinku.
maxU        = 12;            % Ograniczenie napięcia na silniku.
maxIter     = 1e4;
maxFunEval  = 1e7;      
accuracy    = 'high';
nGrid       = duration / dt / 10;%25;  % for trapezoid method

% (Funkcja podcałowa z funk. celu)
% pathObjFunction = @(t,x,u)( 0.25*(u.^2) + 3*x(3, :).^2 + 2*x(4, :).^2 + 100*(x(1, :) - track_len) );
pathObjFunction = @(t,x,u)( u.^2 );

% initial & final state constraints
% ??? A MOŻE STARTOWAĆ Z POCZĄTKU SUWNICY - no kurde no chyba tak ???
x0low       = [track_len/2;pi;0;0];
x0upp       = x0low;
% ??? MOŻE BARDZIEJ DOWOLNY STAN KOŃCOWY ???
xflow       = [track_len/2; 0; 0; 0];
xfupp       = xflow;

% state & control sig. constraints
xlow    = [0+0.05;              -3*pi;      -inf;       -inf];
xupp    = [track_len-0.05;       3*pi;       inf;        inf];
ulow    = -maxU;
uupp    =  maxU;

% time constraints
t0low   = 0;
t0upp   = 0;
tflow   = duration;
tfupp   = duration;

method = 'trapezoid';
% method = 'hermiteSimpson';
% method = 'rungeKutta';
% method = 'chebyshev';

% initial guess - prosta od początku do końca dla każdego stanu.
time_guess      = [0,duration];
state_guess     = [x0low, xflow];
control_guess   = [0,0]; 

% ODPALENIE OPTYMALIZACJI
run("UoptTrajHelpScript.m");

%=========================================================================%
%   Symulacja
%=========================================================================%
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

out = sim('model_lepki.slx');

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
%   Animacja
%=========================================================================%
if animateON
    utils.animate(IC, Lc, dt, x, the, tout, save_anim)
end
%=========================================================================%
%   Ploty z symulacji i z optymalizacji
%=========================================================================%
figure(1);
subplot(321);
plot(tOT, xwOT, t, xw_nl);
ylabel('x');
title('Single Pendulum Swing-Up');
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









