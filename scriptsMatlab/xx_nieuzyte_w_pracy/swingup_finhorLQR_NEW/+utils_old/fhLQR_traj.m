function Soln = fhLQR(t,getAB,Q,R,Qf,tol)
%============================================================================%
%   This function is used to solve the finite-horizon continuout-time linear
%   quadratic regulator problem over system nominal trajectory. Function
%   handle getAB is used to get A,B matricies in a current system state.
%   Matrices A,B are result of linearization of system over a nominal traj.
%
% [NOTE]
%   System is linearized over nominal trajetory - reference trajecry for a system 
%   Matricies A and B are parametrized by time t.
%   So to get 'current' A,B matrices of linear system in a 'current' state
%   t has to be used. 
%
% [IMPLEMENTATION NOTE]
%   Another approach would be to parametrize matrices A,B by some state
%   variable that can be measured, then to set a proper feedback gain K the 
%   measurement could be used. But the measurements can be noisy and real
%   system doesn't have to follow exacly the nonlinear model.
%   można : jeżeli aktualny stan rzeczywistego wahadła jest w jakiejś
%   przyzwoitej niezbyt dużej odległości od stanu z trajektorii nominalnej,
%   można próbować wyznaczyć stan, który jest najbliżej traj. nom. i dla
%   niego dać wzmocnienie.
%   
%   Czyli warto wyznaczyć trajektorie nominalne dla paru zachowań wahadła
%   1.  podnoszenie w lewo i w prawo
%       można załozyć, że wahadlo będzie rozbujane zawsze z pozycji dolnej i
%       z zerowej prędkości
%   2.  opadanie w lewo i w prawo
%       tutaj można założyc że IP będzie opuszczane zawsze z górnej pozycji
%       z zerowej prędkości 
%   inne stany:
%   1.  gdy wahadło spada z za dużą prędkością obsługiwane przez regulator 
%       stabilizujący wahadło w dolnej pozycji - żeby je zabezpieczyć i spokojnie rozbujać
%   2.  wychylenia u góry obsługuje regulator stabilizujący 
%   
% original author: Mathew Kelly
%============================================================================%
%
% INPUTS:
%   t       - monotonically increasing vector of times at which you would like
%             the gain matrix to be calculated
%   getAB   - function handle that returns A,B of lin. system, [A,B] = getAB(<currentTime>)
%   Q       - state cost matrix 
%   R       - input cost matrix 
%   F       - final state cost matrix 
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
    z0 = reshape(Qf, nState*nState, 1);         % z0=Qf
    odeFunc = @(t,z)rhs(t,z,getAB,Q,R,nState);
    tf = t(end);
    timeSpan = [tf, 0];
    
% ode solution
    options = odeset();
    options.RelTol = tol;
    options.AbsTol = tol;
    S = ode45(odeFunc, timeSpan, Qf);           % solution is a series of matricies
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
        [A,B] = getAB(tNow);
        K = R\(B'*S);
        Soln(i).t = tNow;
        Soln(i).K = K;
        Soln(i).S = S;
        Soln(i).E = eig(A-B*K);
    end

end % fhLQR

% Wrapper for ode45
function dz = rhs(t,z,getAB,Q,R, nState)
    S = reshape(z,nState,nState); % do obliczeń 4x4
    [A,B] = getAB(t);
    dS = ricattiRHS(A,B,Q,R,S);
    dz = reshape(dS, nState*nState, 1); % 16x1
end % rhs

% Riccatti differential equation RHS
function [dS, K] = ricattiRHS(A,B,Q,R,S)
    K = -R\B'*S; % R\B = inv(R)B
    dS = -( S*A + A'*S + S*B*K + Q ); 
end % ricattiRHS