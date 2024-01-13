function [A,B,C,D] = linearizationSS_syms(f_vec, h_vec, x_vec, u_vec, S0)
%=========================================================%
% Function to linearize ODE in the following form:
%     x' = f(x, u)  'state equation'
%     y  = h(x, u)  'output equation'
%      
%     If h_vec=0 then set h_vec=[]
%=========================================================%
% Arguments: 
%     f_vec   -   symbolic state function
%     h_vec   -   symbolic output function
%     x_vec   -   symbolic state vector
%     u_vec   -   symbolic control vector
%     S0      -   linearization point [xw the Dxw Dthe u], can be symbolic
% 
% Returns:
%     A, B, C, D of linearized system
%     Dx' = A Dx + B Du
%      y  = Cx + Du
%
% Examples:
%     syms x u
%     f_vec = 10*sin(x) + cos(u)
%     S0 = [0; 0];
%     [A,B,C,D] = linearizationSS_syms(f_vec, [], x, u, S0)
%
%     nabla_fVec_x
%           - matrix A - STATE MATRIX - f_vec gradients wrt. x_vec
%     nabla_hVec_x
%           - matrix C - OUTPUT MATRIX - h_vec gradients wrt. x_vec 
%     nabla_fVec_u
%           - matrix B - CONTROL MATRIX - f_vec gradients wrt. u_vec
%     nabla_hVec_u
%           - matrix D - FEEDTHROUGH MATRIX - h_vec gradients wrt. u_vec
%
    nStates  = length(x_vec);
    nCtrl    = length(u_vec);
    nOutputs = length(h_vec);
    
    nabla_fVec_x = gradient(f_vec(1), [x_vec]).';
    nabla_fVec_u = gradient(f_vec(1), [u_vec]).';
    if nStates>1
        for i=2:nStates
            nabla_fVec_x = [nabla_fVec_x; gradient(f_vec(i), [x_vec]).'];
            nabla_fVec_u = [nabla_fVec_u; gradient(f_vec(i), [u_vec]).'];
        end
    end

    if isempty(h_vec)
        nabla_hVec_x = sym(zeros(nOutputs, nStates));
        nabla_hVec_u = sym(zeros(nOutputs, nCtrl));
    else
        nabla_hVec_x = gradient(h_vec(1), [x_vec]).';
        nabla_hVec_u = gradient(h_vec(1), [u_vec]).';
        for i=2:nOutputs
            nabla_hVec_x = [nabla_hVec_x; gradient(h_vec(i), [x_vec]).'];
            nabla_hVec_u = [nabla_hVec_u, gradient(h_vec(i), [u_vec]).'];
        end
    end

    args_vec = [x_vec; u_vec];

    A = subs(nabla_fVec_x, args_vec, S0);
    B = subs(nabla_fVec_u, args_vec, S0);
    C = subs(nabla_hVec_x, args_vec, S0);
    D = subs(nabla_hVec_u, args_vec, S0);
end % linearizationSS_syms

