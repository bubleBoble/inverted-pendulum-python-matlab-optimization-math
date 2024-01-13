%%
clc
clear
% close all
% clf(1)
% clf(2)
utils.change_simulink_stupid_cache_directory;
utils.change_text_interpreter_to_latex

%%
data_dir="pomiary/";

%% !!! WYBRAĆ MODEL !!!
% model="model_wahadla.slx";
model="model_wahadla_stribeck.slx";

%% LOG1_SCENARIO1_2V_Ts10ms.TXT
if 0
    data = readmatrix(data_dir+"LOG1_SCENARIO1_2V_Ts10ms.TXT");
    data(:,4) = data(:,4) + 8.457 + 180;
    time = data(:, 8) * 0.001;
    time = time - time(1);
    idx_int = time>0 & time<11;
    run("s2.m");
end

%% LOG1_SCENARIO1_4V_Ts10ms.TXT *
if 0
    data = readmatrix(data_dir+"LOG1_SCENARIO1_4V_Ts10ms.TXT");
    data(:,4) = data(:,4) + 9.4043 + 180;
    time = data(:, 8) * 0.001;
    time = time - time(1);
    idx_int = time>0;
    run("s2.m");
end

%% LOG1_SCENARIO1_6V_Ts10ms.TXT *
if 0
    data = readmatrix(data_dir+"LOG1_SCENARIO1_6V_Ts10ms.TXT");
    data(:,4) = data(:,4) + 9.4043 + 180;
    time = data(:, 8) * 0.001;
    time = time - time(1);
    idx_int = time>0;
    run("s2.m");
end

%% LOG1_SCENARIO1_8V_Ts10ms.TXT *
if 0
    data = readmatrix(data_dir+"LOG1_SCENARIO1_8V_Ts10ms.TXT");
    data(:,4) = data(:,4) + 9.84375 + 180;
    time = data(:, 8) * 0.001;
    time = time - time(1);
    idx_int = time>0;
    run("s2.m");
end

%% LOG1_SCENARIO1_10V_Ts10ms.TXT *
if 0
    data = readmatrix(data_dir+"LOG1_SCENARIO1_10V_Ts10ms.TXT");
    data(:,4) = data(:,4) + 9.22852 + 180;
    time = data(:, 8) * 0.001;
    time = time - time(1);
    idx_int = time>0;
    run("s2.m");
end

%% LOG1_SCENARIO1_12V_Ts10ms.TXT *
if 0
    data = readmatrix(data_dir+"LOG1_SCENARIO1_12V_Ts10ms.TXT");
    data(:,4) = data(:,4) + 8.61328 + 180;
    time = data(:, 8) * 0.001;
    time = time - time(1);
    idx_int = time>5;
    run("s2.m");
end

%% rampa1_Ts10ms.TXT * ????????????????????????????????????
if 0   
    data = readmatrix(data_dir+"rampa1_Ts10ms.TXT");
    data(:,4) = data(:,4) + 8.26172 + 180;
    time = data(:, 8) * 0.001;    
    time = time - time(1);
    idx_int = time>5 & time<13.5;
    run("s2.m");
end

%% rampa2_Ts10ms.TXT * ????????????????????????????????????
if 1
    data = readmatrix(data_dir+"rampa2_Ts10ms.TXT");
    data(:,4) = data(:,4) + 7.91016 + 180;
    time = data(:, 8) * 0.001;
    time = time - time(1);
    idx_int = time>6.76;
a    run("s2.m");
end

%% sin1_0.5Hz_Ts10ms.TXT *
if 0    
    data = readmatrix(data_dir+"sin1_0.5Hz_Ts10ms.TXT");
    data(:,4) = data(:,4) + 9.49219 + 180;
    time  = data(:, 8) .* 0.001;
    idx_int = time>63.5;
    run("s2.m");
end

%% sin2_0.25Hz_Ts10ms.TXT * ????????????????????????????????????
if 0
    data = readmatrix(data_dir+"sin2_0.25Hz_Ts10ms.TXT");
    data(:,4) = data(:,4) + 8.87695 + 180;
    time  = data(:, 8) .* 0.001;
    idx_int = time>0;
    run("s2.m");
end

%% sin3_1Hz_Ts10ms.TXT * chyba za szybko i jest drift xw
if 0
    data = readmatrix(data_dir+"sin3_1Hz_Ts10ms.TXT");
    data(:,4) = data(:,4) + 9.84375 + 180;
    time  = data(:, 8) .* 0.001;
    idx_int = time>12;
    run("s2.m");
end

%% sin4_2Hz_Ts10ms.TXT *
if 0
    data = readmatrix(data_dir+"sin4_2Hz_Ts10ms.TXT");
    data(:,4) = data(:,4) + 9.4043 + 180;
    time  = data(:, 8) .* 0.001;
    idx_int = time>0;
    run("s2.m");
end

%% sin5_4Hz_6V_Ts10ms.TXT * ???????????????????????????????????????
if 0
    data = readmatrix(data_dir+"sin5_4Hz_6V_Ts10ms.TXT");
    data(:,4) = data(:,4) + 9.4043 + 180;
    time  = data(:, 8) .* 0.001;
    idx_int = time>0;
    run("s2.m");
end

%% sin6_3Hz_85V_Ts10ms.TXT * ??????????????????????????????????????
if 0
    data = readmatrix(data_dir+"sin6_3Hz_85V_Ts10ms.TXT");
    data(:,4) = data(:,4) + 8.78906 + 180;
    time  = data(:, 8) .* 0.001;
    idx_int = time>0;
    run("s2.m");
end

%% sin7_4Hz_12V_Ts10ms.TXT * ??????????????????????????????????????
if 0
    data = readmatrix(data_dir+"sin7_4Hz_12V_Ts10ms.TXT");
    data(:,4) = data(:,4) + 9.05273 + 180;
    time  = data(:, 8) .* 0.001;
    idx_int = time>0;
    run("s2.m");
end

%% sin8_1Hz_6V_Ts10ms.TXT * ??????????????????????????????????????
if 0
    data = readmatrix(data_dir+"sin8_1Hz_6V_Ts10ms.TXT");
    data(:,4) = data(:,4) + 9.66797 + 180;
    time  = data(:, 8) .* 0.001;
    idx_int = time>20;
    run("s2.m");
end

%% sin8_07Hz_6V_Ts10ms.TXT * ??????????????????????????????????????
if 0
    data = readmatrix(data_dir+"sin8_07Hz_6V_Ts10ms.TXT");
    data(:,4) = data(:,4) + 8.08594 + 180;
    time  = data(:, 8) .* 0.001;
    idx_int = time>26.3;
    run("s2.m");
end

%% sin9_07Hz_6V___1.4Hz_1V_Ts10ms.TXT * ??????????????????????????????????????
if 0
    data = readmatrix(data_dir+"sin9_07Hz_6V___1.4Hz_1V_Ts10ms.TXT");
    data(:,4) = data(:,4) + 7.99805 + 180;
    time  = data(:, 8) .* 0.001;
    idx_int = time>22.04;
    run("s2.m");
end

%% wahadlo_puszczone_z_gory.TXT * ??????????????????????????????????????
if 0
    data = readmatrix(data_dir+"sin9_07Hz_6V___1.4Hz_1V_Ts10ms.TXT");
    data(:,4) = data(:,4) + 7.99805 + 180;
    time  = data(:, 8) .* 0.001;
    idx_int = time>21.95;
    run("s2.m");
end