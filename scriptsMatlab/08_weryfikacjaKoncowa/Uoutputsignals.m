t            = out.tout;
%nieliniowy
d            = out.out.getElement('dist').Values.Data;
xw_ref       = out.out.getElement('xw_ref').Values.Data;
xw_nl        = out.out.getElement('xw_nl').Values.Data;
the_nl       = out.out.getElement('the_nl').Values.Data;
Dxw_nl       = out.out.getElement('Dxw_nl').Values.Data;
Dthe_nl      = out.out.getElement('Dthe_nl').Values.Data;
% sygnał sterujący i składowe
ctrl_sig     = out.out.getElement('ctrl_sig').Values.Data;
ctrl_e_xw    = out.out.getElement('ctrl_e_xw').Values.Data;
ctrl_e_the   = out.out.getElement('ctrl_e_the').Values.Data;
ctrl_e_Dxw   = out.out.getElement('ctrl_e_Dxw').Values.Data;
ctrl_e_Dthe  = out.out.getElement('ctrl_e_Dthe').Values.Data;
%liniowy 
xw_l       = out.out.getElement('xw_l').Values.Data;
the_l      = out.out.getElement('the_l').Values.Data;
Dxw_l      = out.out.getElement('Dxw_l').Values.Data;
Dthe_l     = out.out.getElement('Dthe_l').Values.Data;
ctrl_sig_l = out.out.getElement('ctrl_sig_l').Values.Data;