function [A, B] = sgetAB(t, Afunc, Bfunc, state_OT_func, u_OT_func)
    cState= state_OT_func(t);
    cs1 = cState(1);
    cs2 = cState(2);
    cs3 = cState(3);
    cs4 = cState(4);
    cu = u_OT_func(t);
    A = Afunc( cs1, cs2, cs3, cs4, cu );
    B = Bfunc( cs1, cs2, cs3, cs4, cu );
end