%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; 
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex
figure(1); pause(2);
dbstop if error
%#ok<*GVMIS> % Ignorowanie błędów o zmiennch globalnych
%#ok<*UNRCH> % Ignorowanie błędów: this statement cannot be reached
if ~bdIsLoaded('model_wahadla_stribeck')
    load_system('model_wahadla_stribeck')
end
% close_system('model_wahadla_stribeck')
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
h                                   = 1; % h iteracji optymalizacji
anim_name                           = "anim1";
plot_simulink_result                = 1;     
n_samples                           = 2;
%--------------------------------------------------------------------------------------------------------
model_name="model_wahadla_stribeck";
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
        data1 = data1(1:n_samples:end,:);
        time1 = time1(1:n_samples:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 4v.TXT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 0
        data_name = data_dir+"4v.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);
        idx_int1 = time1>1.6 & time1<8;
        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples:end,:);
        time1 = time1(1:n_samples:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 6v.TXT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 0
        data_name = data_dir+"6v.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);
        idx_int1 = time1>1.6 & time1<8;
        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples:end,:);
        time1 = time1(1:n_samples:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 8v.TXT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 0
        data_name = data_dir+"8v.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);
        
        % idx_int1 = time1>3 & time1<10; % ładny przebieg
        idx_int1 = time1>3.9 & time1<7; % test

        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples:end,:);
        time1 = time1(1:n_samples:end);
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
        data1 = data1(1:n_samples:end,:);
        time1 = time1(1:n_samples:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 12v.TXT - potrzebowało 6 iteracji
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
        data1 = data1(1:n_samples:end,:);
        time1 = time1(1:n_samples:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 2vrampa.TXT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 1
        data_name = data_dir+"2vrampa.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);
        idx_int1 = time1>3.3 & time1<12;
        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples:end,:);
        time1 = time1(1:n_samples:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 4vrampa.TXT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 0
        data_name = data_dir+"4vrampa.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);
        idx_int1 = time1>3.3 & time1<12;
        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples:end,:);
        time1 = time1(1:n_samples:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 6vrampa.TXT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 0
        data_name = data_dir+"6vrampa.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);
        idx_int1 = time1>4 & time1<12;
        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples:end,:);
        time1 = time1(1:n_samples:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 8vrampa.TXT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 0
        data_name = data_dir+"8vrampa.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);
        idx_int1 = time1>4 & time1<12;
        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples:end,:);
        time1 = time1(1:n_samples:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 10vrampa.TXT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 0
        data_name = data_dir+"10vrampa.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);
        idx_int1 = time1>4 & time1<12;
        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples:end,:);
        time1 = time1(1:n_samples:end);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 12vrampa.TXT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 0
        data_name = data_dir+"12vrampa.txt";
        data1 = readmatrix(data_name);
        time1  = data1(:, 8) .* 0.001;
        time1 = time1 - time1(1);
        idx_int1 = time1>4 & time1<12;
        time1 = time1(idx_int1);
        time1 = time1 - time1(1);
        data1 = data1(idx_int1, :);
        data1 = data1(1:n_samples:end,:);
        time1 = time1(1:n_samples:end);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parametry początkowe
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M               = 0.416;
mp              = 0.089;
mc              = 0.0001;
Lp              = 0.245/2;
b_stri          = 18;
gamma_stri      = 0.0053;
miu_c           = 0.0651;
miu_s           = 0.1284;
vs              = 13.9983;
alpha_dcm       = 1.55; % 1.55
beta_dcm        = 4.682; % 7.5
B = 20.9002;
Lc = 2*Lp;mr = mc + mp;Mt = mr + M;L = (Lc*mc + Lp*mp) / mr;
Jcm = 1/12*mp*Lp^2;
Jt = Jcm + mr*L^2;
params_to_find = [M, mp, mc, Lp, alpha_dcm, B, gamma_stri, miu_c, miu_s, vs];  
params_start = params_to_find;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ograniczenia nierównościowe do optymalizacji
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lb=[
    M*0.99999;  % M
    mp*0.99999; % mp
    0;          % mc
    Lp*0.99999; % Lp
    1.54;       % alpha_dcm 
    B*0.99999;  % B
    0;          % gamma
    miu_c*0.99; % miu_c
    miu_s*0.99; % miu_s
    vs*0.99     % vs
]';
ub=[ 
    M*1.00001;  % M
    mp*1.00001; % mp
    mc*1.00001; % mc
    Lp*1.00001; % Lp
    1.56;       % alpha_dcm
    B*1.00001;  % B
    inf;        % gamma
    miu_c*1.01; % miu_c
    miu_s*1.01; % miu_s
    vs*1.01     % vs
]';
% params_to_find = params_to_find + [0, 0, 0, 0, 0, 0, 0.0016, 0, 0, 0];
% lb = [];
% ub = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ustawienia optymalizatora
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options_optim = optimoptions('lsqnonlin');
options_optim.Algorithm = "levenberg-marquardt";
options_optim.Display = "iter";
% options_optim.OptimalityTolerance = 1e-8;  % 1e-6
% options_optim.FunctionTolerance   = 1e-8;  % 1e-6
% options_optim.StepTolerance       = 1e-10; % 1e-10
% options_optim.FiniteDifferenceStepSize = 1e-3;
% options_optim.ScaleProblem = "Jacobian";
options_optim.InitDamping = 1e2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ustawienia solvera ode45
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options_ode = odeset();
options_ode.RelTol = 1e-9;
options_ode.AbsTol = 1e-11;
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
if 0
    save('wyniki/stribeck_6.mat')
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

disp(params_start - cell2mat(params_optim))
cell2mat(params_optim)
