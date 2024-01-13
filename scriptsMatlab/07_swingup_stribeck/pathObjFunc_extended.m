function j = pathObjFunc_extended( t,x,u,dt )
    
    t;x;

    Du = diff(u) / dt; 
    Du(end+1) = Du(end);
    j = u.^2 + Du.^2;

end