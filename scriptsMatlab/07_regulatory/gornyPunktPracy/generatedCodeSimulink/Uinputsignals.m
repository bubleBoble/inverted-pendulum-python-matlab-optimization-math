% czas
dt = 0.01;
t=0:(end_time/dt); t=t*dt;

% sygnały
xw_ref_wybor = 1;
switch xw_ref_wybor
case 0
% troche bardziej zmienna
    xw_ref = ( ...
    utils.ustep(t, 0)*track_len/2 + ...
    utils.ustep(t, 1)*(0.35 - track_len/2) - ...
    utils.ustep(t, 4)*(0.25) .* 1 + ...
    utils.ustep(t, 8)*(track_len/2 - 0.1) );
case 1
% skok
    xw_ref = ( ...
    utils.ustep(t, 0)*track_len/2 + ...
    utils.ustep(t, 1)*(0.15) );
case 2
% sin
    T = 2;
    xw_ref = 0.1*utils.ustep(t, 1).*sin(2*pi/T * t) + utils.ustep(t, 0)*track_len/2;
case 3
% skok w t=0
    xw_ref = ( ...
    utils.ustep(t, 0)*track_len/2 + ...
    utils.ustep(t, 0)*(0.15) );
end
d = (utils.ustep(t, 2.5)-utils.ustep(t, 4.6)) * 0;

ind.time = t;
ind.signals(1).values = xw_ref';
ind.signals(1).dimensions = 1;
ind.signals(2).values = d';
ind.signals(2).dimensions = 1;

