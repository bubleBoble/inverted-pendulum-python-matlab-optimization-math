t            = out.tout;
%nieliniowy
d            = out.out.getElement('dist').Values.Data;
xw_ref       = out.out.getElement('xw_ref').Values.Data;
xw_nl        = out.out.getElement('xw_nl').Values.Data;
the_nl       = out.out.getElement('the_nl').Values.Data;
Dxw_nl       = out.out.getElement('Dxw_nl').Values.Data;
Dthe_nl      = out.out.getElement('Dthe_nl').Values.Data;
ctrl_sig     = out.out.getElement('ctrl_sig').Values.Data;
ctrl_sig_raw = out.out.getElement('ctrl_sig_raw').Values.Data;
%liniowy
xw_l       = out.out.getElement('xw_l').Values.Data;
the_l      = out.out.getElement('the_l').Values.Data;
Dxw_l      = out.out.getElement('Dxw_l').Values.Data;
Dthe_l     = out.out.getElement('Dthe_l').Values.Data;
ctrl_sig_l = out.out.getElement('ctrl_sig_l').Values.Data;