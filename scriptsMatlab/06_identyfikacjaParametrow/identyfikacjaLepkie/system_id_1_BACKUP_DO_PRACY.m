%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; 
% clear; 
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex
figure(1); pause(2);
dbstop if error
%#ok<*GVMIS> % Ignorowanie błędów o zmiennch globalnych
%#ok<*UNRCH> % Ignorowanie błędów: this statement cannot be reached
if ~bdIsLoaded('model_wahadla_lepkie')
    load_system('model_wahadla_lepkie')
end
% close_system('model_wahadla_lepkie')
global cumul_cost;
global intermediate_params;
global plot_intermediate_optim_step;
global display_intermediate_optim_params;
global save_intermediate_params;
global mov; global save_plot_for_anim;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do zmiany
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot_intermediate_optim_step        = 0;
display_intermediate_optim_params   = 0;
save_intermediate_params            = 0;
save_plot_for_anim                  = 0;
h                                   = 6;        % h iteracji optymalizacji
anim_name                           = "anim1";
plot_simulink_result                = 1;   
n_samples_to_the_bin                = 1;
%--------------------------------------------------------------------------------------------------------
model_name="model_wahadla_lepkie";
params0             = [];
mov                 = [];
cumul_cost          = [];
intermediate_params = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dane pomiarowe
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    data_dir="pomiary/krotki_pret/";
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 2v.TXT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 0
        data_name = data_dir+"2v.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);
        idx_int1 = time1>1.6 & time1<8;
        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples_to_the_bin:end,:);
        time1 = time1(1:n_samples_to_the_bin:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 4v.TXT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 0
        data_name = data_dir+"4v.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);
        idx_int1 = time1>3.3 & time1<8;
        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples_to_the_bin:end,:);
        time1 = time1(1:n_samples_to_the_bin:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 6v.TXT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 0
        data_name = data_dir+"6v.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);
        idx_int1 = time1>2.3 & time1<8;
        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples_to_the_bin:end,:);
        time1 = time1(1:n_samples_to_the_bin:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 8v.TXT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 1
        data_name = data_dir+"8v.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);

        % idx_int1 = time1>3 & time1<10; % ładny przebieg
        % idx_int1 = time1>3.9 & time1<5; % test
        idx_int1 = time1>3.9 & time1<7; % test
        
        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples_to_the_bin:end,:);
        time1 = time1(1:n_samples_to_the_bin:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 10v.TXT - potrzebowało 6 iteracji
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 0
        data_name = data_dir+"10v.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);
        idx_int1 = time1>2.8 & time1<10;
        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples_to_the_bin:end,:);
        time1 = time1(1:n_samples_to_the_bin:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %    12v.TXT - potrzebowało 6 iteracji
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 0
        data_name = data_dir+"12v.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);
        idx_int1 = time1>4 & time1<11;
        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples_to_the_bin:end,:);
        time1 = time1(1:n_samples_to_the_bin:end);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parametry początkowe
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M               = 0.416;   % Masa wózka
mp              = 0.089;   % Masa pręta
mc              = 0.0001;  % Dodatkowa masa na końcu pręta
Lp              = 0.245/2; % Połowa długości pręta
b_vis           = 19.225;  % Współczynnik tarcia lepkiego, wózek
gamma_vis       = 0.0002;  % Współczynnik tarcia lepkiego, ramię
alpha_dcm       = 1.75;    % Papier 1.7189
beta_dcm        = 7.5;     % Papier 7.682
Lc = 2*Lp; mr = mc + mp; Mt = mr + M; L = (Lc*mc + Lp*mp) / mr;
Jcm = 0.3333333*mp*Lp^2 + mp*(L-Lp)^2 + mc*(L-Lc)^2;
Jt = Jcm + mr*L^2; B = b_vis + beta_dcm;
params_to_find = [M, mp, mc, Lp, B, gamma_vis, alpha_dcm];
params_start = params_to_find;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ograniczenia
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lb=[ 
%     0.001,   % M
%     mp*0.99, % mp
%     0.000,   % mc
%     Lp*0.85, % Lp
%     0,       % B
%     0,       % gamma
%     0        % alfa
% ]';
lb=[ 
    M*0.99,   % M
    mp*0.99,   % mp
    0,   % mc
    Lp*0.85,   % Lp
    0,       % B
    0,       % gamma
    0        % alfa
]';
ub=[ 
    inf,     % M
    inf,     %mp*1.5, % mp
    0.001,    % mc
    inf, % Lp
    inf,     % B
    inf,     % gamma
    inf      % alfa
]';
params_to_find = params_start + [
    1.62, %1, % M
    0.05, % mp
    0, % mc
    0, % Lp
    1.95, %3.25, % B
    0.009, % gamma
    0.85 %0.7 % alfa
]';
params_start = params_to_find;
%
% params_to_find = [1.3246    0.0881    0.0051    0.1044   30.0230    0.0022    1.9249];

% lb = [];
% ub = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ustawienia optymalizatora
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options_optim = optimoptions('lsqnonlin');
options_optim.Algorithm = "levenberg-marquardt"; %"trust-region-reflective";
options_optim.Display = "iter";
options_optim.OptimalityTolerance = 1e-8;  % 1e-6
options_optim.FunctionTolerance   = 1e-8;  % 1e-6
options_optim.StepTolerance       = 1e-10; % 1e-10
% options_optim.FiniteDifferenceStepSize = 1e-3;
% options_optim.ScaleProblem = "Jacobian";
% % options_optim.InitDamping = 1e2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ustawienia solvera ode45
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options_ode = odeset();
% options_ode.RelTol = 1e-4;
% options_ode.AbsTol = 1e-6;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wywołanie 'system_id_2_help_optim.m' - skrypt do optymalizacj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% h=10;
% params0 = params_optim;
for i=1:(h-1)
    run('system_id_2.m')
    params0 = params_optim;
end
run('system_id_2.m')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Przebiegi parametrów
% można zobaczyć kiedy mniej więcej optymalizator utknął na rozwiązaniu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    for z=2:length(params0)
        figure(z+1)
        plot(intermediate_params(:, z));
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Zapis animacji
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if save_plot_for_anim
    disp('saving...');
    v = VideoWriter(sprintf('%s', anim_name), 'MPEG-4');
    v.FrameRate = 30;
    open(v);
    writeVideo(v, mov(2:end));
    close(v)
    disp('done saving.');
end

% żeby zobaczyć różnicę pomiędzy parametrami początkowymi a tymi znalezionymi
disp(params_start - cell2mat(params_optim))
