% Użyty do wykreślenia wykresu z tarciem stribecka
% https://www.desmos.com/calculator/doycmfge0m
clc; clf;

% dla płaskiego
% vel = 0:0.0001:0.06;
% dla fajnego
vel = -10:0.1:10;

Ff = stribeck_fric(vel);

figure()
ax = subplot(1,1,1);
plot(vel, Ff, 'LineWidth', 2.6)
grid on;
ylabel( 'Siła tarcia', FontSize=18 );
xlabel( 'Prędkość', FontSize=18 )
xline(0, 'LineWidth', 1.4, 'Color',[0,0,0,0.25]);
yline(0, 'LineWidth', 1.4, 'Color',[0,0,0,0.25]);
ax.YAxis.FontSize = 12;
ax.XAxis.FontSize = 12;
function Ff = stribeck_fric(vel)
    % % Dla płaskiego
    % mc = 0.00053;
    % ms = 0.0003;
    % vs = 0.02;
    % mr = 0.13;
    % b  = 0.0000916;
    % % Dla fajnego
    mc = 0.0062;
    ms = 0.038;
    vs = 1.3;
    mr = 11;
    b  = 0.9;
    Ff = ( mc + (ms - mc) .* exp( -(vel./vs).^2 ) ) .* mr .* 9.8145 .* tanh(600.*vel) + b.*vel;
end

