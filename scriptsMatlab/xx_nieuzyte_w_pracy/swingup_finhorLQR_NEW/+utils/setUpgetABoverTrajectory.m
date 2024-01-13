function [Afunc, Bfunc] = setUpgetABoverTrajectory()
% Linearization over nominal trajectory
%===========================================================================%
syms x_1 x_2 x_3 x_4 u
% format short
% digits(3)
% sympref('FloatingPointOutput',true);

% Symbolic state function of nonlinear model
%===========================================================================%
run('utils.model_params.m');
x_vec = [x_1; x_2; x_3; x_4];
b = b_lepkie;
d = 0;
% Equations for pendulum dynamics
Ff = b*x_3;
Fi = alpha_*u - beta_*x_3;
A = d*cos(x_2) - Ff + L*mr*(x_4.^2).*sin(x_2) + Fi;
B = d*Lc + L*g*mr*sin(x_2) - gamma_*x_4;
DEN = Jt*Mt - (L*mr*cos(x_2)).^2;

ddt_x1 = x_3;
ddt_x2 = x_4;
ddt_x3 = (Jt*A - L*mr*cos(x_2).*B) ./ DEN;
ddt_x4 = (Mt*B - L*mr*cos(x_2).*A) ./ DEN;

f_vec = [ddt_x1; ddt_x2; ddt_x3; ddt_x4];
f_vec = expand(f_vec);
f_vec = simplify(f_vec);

syms x_1_tn x_2_tn x_3_tn x_4_tn u_tn
nominal_traj_vars = [x_1_tn; x_2_tn; x_3_tn; x_4_tn; u_tn];
% linearization script call
[A, B, C, D] = utils.linearizationSS_syms(f_vec, [], x_vec, u, nominal_traj_vars);
% A = expand(A);
% B = expand(B);
% A = simplify(A);
% B = simplify(B);

% convert A and B matrices to matlab function ( A = A(xw, the, Dxw, Dthe, u) ) over
% nominal trajectory
Afunc = matlabFunction(A, 'Vars', nominal_traj_vars);
Bfunc = matlabFunction(B, 'Vars', nominal_traj_vars);

end % setUpgetABoverTrajectory



