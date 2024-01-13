IC = [track_len/2, pi, 0, 0]'; 
dt = 0.001;
time = 0:dt:end_time;
run('utils.model_params.m')

ind1.time = time';
ind1.signals(1).values = uOT_func(time)';
ind1.signals(1).dimensions = 1;
ind1.signals(2).values = zeros( size(ind1.signals(1).values) );
ind1.signals(2).dimensions = 1;

%simulation
out = sim('model1.slx');

% Simulink solution (optimTRaj solution: % tOT, xOT, theOT, dxOT, dtheOT, uOT)
t        = out.tout;
d        = out.out.getElement('d_sim').Values.Data;
xw_nl    = out.out.getElement('xw_nl').Values.Data;
the_nl   = out.out.getElement('the_nl').Values.Data;
Dxw_nl   = out.out.getElement('Dxw_nl').Values.Data;
Dthe_nl  = out.out.getElement('Dthe_nl').Values.Data;
ctrl_sig = out.out.getElement('v_sim').Values.Data;

% Plot comparassion
figure(1);

subplot(321)
plot(tOT, xOT, t, xw_nl)
ylabel('x')
grid

subplot(322)
plot(tOT, theOT*180/pi, t, the_nl)
ylabel('the')
grid

subplot(323)
plot(tOT, dxOT, t, Dxw_nl)
ylabel('dx')
grid

subplot(324)
plot(tOT, dtheOT*180/pi, t, Dthe_nl)
ylabel('dthe')
grid

subplot(325)
plot(tOT, uOT, t, ctrl_sig)
ylabel('u')
grid

disp('optimTraj info:')
disp('----------------------------')
disp('step size:')
disp(soln.info.stepsize)
disp('NLP time')
disp(soln.info.nlpTime)