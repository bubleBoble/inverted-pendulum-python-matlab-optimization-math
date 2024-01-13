function Soln = fhLQR(t,A,B,Q,R,Qf,tol)
%============================================================================%
% This function is used to solve the finite-horizon continuout-time linear
% quadratic regulator problem. Solves differential (matrix) Ricatti
% equation with terminal condition.
% 
% original author: Mathew Kelly
%============================================================================%
% NOTE:
%       zmieniłem na lqr ze skonczonym horyzontem czasowym dla punktu pracy
%       a nie trajektorii, fhLQR ze stabilizacją po trajektorii jest w 
%       fhLQR_traj.m
%
% INPUTS:
%   t       - monotonically increasing vector of times at which you would like
%             the gain matrix to be calculated
%   A,B     - matrices of system linearized in operating point
%   Q       - state cost matrix 
%   R       - input cost matrix 
%   Qf      - final state cost matrix 
%   tol     - accuracy of riccati equation propagation
%
% OUTPUTS:
%   Soln = struct array with solution at each point in t
%   Soln(i).t = t(i);
%   Soln(i).K = gain matrix at t(i)
%   Soln(i).S = Cost to go
%   Soln(i).E = close-loop eigen-values for system at t(i)
%
% LQR functional:
%   J = x'Fx + Integral {x'Qx + u'Ru} dt
%

% Solve Ricatti eqn. backwards in time, S(tf)=Qf
    nState = size(Q,1);
    nInput = size(R,1);
    z0 = reshape(Qf, nState*nState, 1); % z0=Qf
    odeFunc = @(t,z)rhs(t,z,A,B,Q,R,nState);
    tf = t(end);
    timeSpan = [tf, 0];
    
% ode solution
    options = odeset();
    options.RelTol = tol;
    options.AbsTol = tol;
    S = ode45(odeFunc, timeSpan, Qf); % solution is a series of matricies
    z = deval(S, t);
    
% output conditioning
    nSoln = length(t);
    Soln(nSoln).t = 0;
    Soln(nSoln).K = zeros(nState,nInput);
    Soln(nSoln).S = zeros(nState,nState);
    Soln(nSoln).E = zeros(nState,1);
    
    for idx=1:nSoln
        i = nSoln-idx+1;
        zNow = z(:,i);
        tNow = t(i);
        S = reshape(zNow,nState,nState);
        K = R\(B'*S);
        Soln(i).t = tNow;
        Soln(i).K = K;
        Soln(i).S = S;
        Soln(i).E = eig(A-B*K);
    end

end % fhLQR

% Wrapper for ode45
function dz = rhs(t,z,A,B,Q,R, nState)
    S = reshape(z,nState,nState); % do obliczeń 4x4
    % [A,B] = ...
    dS = ricattiRHS(A,B,Q,R,S);
    dz = reshape(dS, nState*nState, 1); % 16x1
end % rhs

% Riccatti differential equation RHS
function [dS, K] = ricattiRHS(A,B,Q,R,S)
    K = -R\B'*S; % R\B = inv(R)B
    dS = -( S*A + A'*S + S*B*K + Q ); 
end % ricattiRHS