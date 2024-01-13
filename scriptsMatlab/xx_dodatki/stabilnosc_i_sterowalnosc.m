clear
format long

params_vis = [0.416, 0.089, 0, 0.1225, 23.8299, 0.0035, 1.5417];
params_stri = [0.4160, 0.0890, 0, 0.1225, 1.5417, 20.9, 0.0067, 0.0651, 0.1284, 13.9989];

% [A, B, C, D, E, H] = macierze_lin('lepki gora', params_vis);
% [A, B, C, D, E, H] = macierze_lin('lepki dol', params_vis);
% [A, B, C, D, E, H] = macierze_lin('stribeck gora', params_stri);
[A, B, C, D, E, H] = macierze_lin('stribeck dol', params_stri);

A_bez_xw = A(2:end, 2:end);

eigsA = eig(A)
eigsA_bezxw = eig(A_bez_xw)

Msk = ctrb(A, B);
detmsk = det(Msk)