% Użyty do wykreślenia wykresu z tarciem stribecka
% https://www.desmos.com/calculator/doycmfge0m
clc;

% dla płaskiego
% vel = 0:0.0001:0.06;
% dla fajnego
vel = -0.06:0.0001:0.06;

Ff = stribeck_fric(vel);

% Ff_zast = sign(vel) + 20.9002.*vel - 0.44;

figure(1)
ax = subplot(1,1,1);
plot(vel, Ff, 'LineWidth', 2.6); hold on;
plot(vel, Ff_zast)
grid on;
ylabel( 'Siła tarcia', FontSize=18 );
xlabel( 'Prędkość', FontSize=18 )
xline(0, 'LineWidth', 1.4, 'Color',[0,0,0,0.25]);
yline(0, 'LineWidth', 1.4, 'Color',[0,0,0,0.25]);
ax.YAxis.FontSize = 12;
ax.XAxis.FontSize = 12;
function Ff = stribeck_fric(vel)
    mc = 0.0644;
    ms = 0.1297;
    vs = 14.0001;
    mr = 0.4160;
    b  = 20.9002;
    Ff = ( mc + (ms - mc) .* exp( -(vel./vs).^2 ) ) .* mr .* 9.8145 .* tanh(600.*vel) + b.*vel;
end

