%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Skrypt do oglądania danych pomiarowych, kontynuacja w 's2.m'
% albo do testowania wyznaczonych parametrów
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ctrl shift q
clc
clear
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex;
data_dir="pomiary/krotki_pret/";
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Załadować wyzanczone parametry z idx/wyniki_idx.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test_params = "wyniki/lepkie_1.mat";
% load(test_params, 'params_optim');

swobodna=0;
model="model_wahadla_lepkie.slx";
% model="model_wahadla_stribeck.slx";
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1v.TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    data = readmatrix(data_dir+"1v.txt");
    time  = data(:, 8) .* 0.001;
    time = time - time(1);
    idx_int = time>2.88 & time<15;
    time = time(idx_int);
    time = time - time(1);
    run("ogladanie_s2.m");
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2v.TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    data = readmatrix(data_dir+"2v.txt");
    time  = data(:, 8) .* 0.001;
    time = time - time(1);
    idx_int = time>1.6 & time<8;
    time = time(idx_int);
    time = time - time(1);
    run("ogladanie_s2.m");
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4v.TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    data = readmatrix(data_dir+"4v.txt");
    time  = data(:, 8) .* 0.001;
    time = time - time(1);
    idx_int = time>3.3 & time<8;
    time = time(idx_int);
    time = time - time(1);
    run("ogladanie_s2.m");
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6v.TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    data = readmatrix(data_dir+"6v.txt");
    time  = data(:, 8) .* 0.001;
    time = time - time(1);
    idx_int = time>2.3 & time<8;
    % idx_int = time>2.5 & time<7;
    time = time(idx_int);
    time = time - time(1);
    run("ogladanie_s2.m");
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 8v.TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1
    data = readmatrix(data_dir+"8v.txt");
    time  = data(:, 8) .* 0.001;
    time = time - time(1);
    idx_int = time>3 & time<10;
    time = time(idx_int);
    time = time - time(1);
    run("ogladanie_s2.m");
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 10v.TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    data = readmatrix(data_dir+"10v.txt");
    time  = data(:, 8) .* 0.001;
    time = time - time(1);
    idx_int = time>2.8 & time<10;
    time = time(idx_int);
    time = time - time(1);
    run("ogladanie_s2.m");
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 12v.TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    data = readmatrix(data_dir+"12v.txt");
    time  = data(:, 8) .* 0.001;
    time = time - time(1);
    idx_int = time>4 & time<11;
    time = time(idx_int);
    time = time - time(1);
    run("ogladanie_s2.m");
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2vrampa.TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    data = readmatrix(data_dir+"2vrampa.txt");
    time  = data(:, 8) .* 0.001;
    time = time - time(1);
    idx_int = time>4.7 & time<11;
    time = time(idx_int);
    time = time - time(1);
    run("ogladanie_s2.m");
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4vrampa.TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    data = readmatrix(data_dir+"4vrampa.txt");
    time  = data(:, 8) .* 0.001;
    time = time - time(1);
    idx_int = time>5.2 & time<11;
    time = time(idx_int);
    time = time - time(1);
    run("ogladanie_s2.m");
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6vrampa.TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    data = readmatrix(data_dir+"6vrampa.txt");
    time  = data(:, 8) .* 0.001;
    time = time - time(1);
    idx_int = time>6.4;
    time = time(idx_int);
    time = time - time(1);
    run("ogladanie_s2.m");
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 8vrampa.TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    data = readmatrix(data_dir+"8vrampa.txt");
    time  = data(:, 8) .* 0.001;
    time = time - time(1);
    idx_int = time>5.218;
    time = time(idx_int);
    time = time - time(1);
    run("ogladanie_s2.m");
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 10vrampa.TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    data = readmatrix(data_dir+"10vrampa.txt");
    time  = data(:, 8) .* 0.001;
    time = time - time(1);
    idx_int = time>7.367;
    time = time(idx_int);
    time = time - time(1);
    run("ogladanie_s2.m");
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 12vrampa.TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    data = readmatrix(data_dir+"12vrampa.txt");
    time  = data(:, 8) .* 0.001;
    time = time - time(1);
    idx_int = time>5.65 & time<12;
    time = time(idx_int);
    time = time - time(1);
    run("ogladanie_s2.m");
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% swobodna.TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    data = readmatrix(data_dir+"swobodna.txt");
    time  = data(:, 8) .* 0.001;
    time = time - time(1);
    idx_int = time>7.04;
    time = time(idx_int);
    time = time - time(1);
    swobodna = 1;
    run("ogladanie_s2.m");
end
