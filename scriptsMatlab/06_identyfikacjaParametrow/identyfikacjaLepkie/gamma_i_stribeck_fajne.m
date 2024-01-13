clf
% Wyznaczone optymalne wartości parametrów, ze skryptu system_id_1.m
% parametry: M, mp, mc, Lp, B, gamma, alfha
optym_M  = [0.4178;0.4202;0.4118;0.4118;0.4118;0.4160];
optym_mp = [0.0881;0.0899;0.0881;0.0892;0.0881;0.0890];
optym_mc = [0;0;0;0;0;0;];
optym_Lp = [0.1213;0.1213;0.1213;0.1213;0.1213;0.1225];
optym_B  = [26.5928;23.8970;23.1800;23.1077;23.1016;23.1000];
optym_gm = [0.0087;0.0048;0.0028;0.0018;0.0014;0.0014];
optym_al = [1.5400;1.5400;1.5400;1.5400;1.5400;1.5500];

i = 1:6;

ticks = ['skok 2[V]', 'skok 4[V]', 'skok 6[V]', 'skok 8[V]', 'skok 10[V]', 'skok 12[V]'];

figure(1)
ax = subplot(131);
scatter(i, optym_gm, 100, 'red', 'filled'); grid on;
xticks(i)
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
ylabel("$\gamma$", 'Interpreter','latex', 'Rotation', 0, 'FontSize', 18)
xlabel('Iteracja', 'Interpreter','latex', 'Rotation', 0, 'FontSize', 18)
% ax.XAxis.Visible = 'off';
ax.XAxis.LineWidth = 1.2;
ax.YAxis.LineWidth = 1.2;
ax.Box = 'on';

ax = subplot(132);
scatter(i, optym_B, 100, 'red', 'filled'); grid on;
xticks(i)
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;
ylabel("$B$", 'Interpreter','latex', 'Rotation', 0, 'FontSize', 18)
xlabel('Iteracja', 'Interpreter','latex', 'Rotation', 0, 'FontSize', 18)
% ax.XAxis.Visible = 'off';
ax.XAxis.LineWidth = 1.2;
ax.YAxis.LineWidth = 1.2;
ax.Box = 'on';
vel = 0:0.0001:0.06;
Ff = stribeck_fric(vel);
ax = subplot(133);
plot(vel, Ff, 'LineWidth', 2.6)
grid on;
ax.YAxis.FontSize = 12;
ax.XAxis.FontSize = 12;
ylabel( '$F_{\mathrm{f}}$', FontSize=18, Interpreter='latex', rotation=0);
xlabel( 'Predkosc', 'Interpreter','latex', 'Rotation', 0, 'FontSize', 18)
xline(0, 'LineWidth', 1.4, 'Color',[0,0,0,0.25]);
yline(0, 'LineWidth', 1.4, 'Color',[0,0,0,0.25]);
ax.XAxis.LineWidth = 1.2;
ax.YAxis.LineWidth = 1.2;

function Ff = stribeck_fric(vel)
    % Dla płaskiego
    mc = 0.00053;
    ms = 0.0003;
    vs = 0.02;
    mr = 0.13;
    b  = 0.0000916;

    Ff = ( mc + (ms - mc) .* exp( -(vel./vs).^2 ) ) .* mr .* 9.8145 .* tanh(600.*vel) + b.*vel;
end