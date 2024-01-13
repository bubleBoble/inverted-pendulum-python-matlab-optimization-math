function u = animate(IC, Lc, dt, x, theta, xp, thetap, tout, tp, save_anim, video_name)
    %% animacja 
    track_len = 0.47;
    XLIM = [0, track_len];
    YLIM = [-0.15, 0.15];
   
    craneRailMin = XLIM(1);
    craneRailMax = XLIM(2);

    fig = figure();
    set(gcf, 'Position',  [300, 100, 1000, 800])
    ax = axes(fig);
    ax.XLim = XLIM; ax.YLim = YLIM;
    box(ax, 'on');
    hold(ax, 'on');
    
    ax.XAxis.TickLength = [0 0];
    ax.YAxis.TickLength = [0 0];

    craneRail = plot([craneRailMin, craneRailMax], [0, 0]);
    craneRail.Color = 'Black';
    craneRail.LineWidth = 3.0;
    
    baseWidth = 0.045;
    baseHeight = 0.03;
    base = rectangle();
    base.Position = [0-baseWidth/2, 0-baseHeight/2, baseWidth, baseHeight];
    base.FaceColor = "#f5c33b";
    base.EdgeColor = "black";
    base.LineWidth = 2;
    rotationAxis = plot(0, 0, 'o');
    rotationAxis.MarkerFaceColor = 'black';
    rotationAxis.MarkerEdgeColor = 'black';
    base.addprop('rotationAxis');
    base.rotationAxis = rotationAxis;
    
    baseWidth_p = 0.055;
    baseHeight_p = 0.04;
    base_pom = rectangle();
    base_pom.Position = [0-baseWidth_p/2, 0-baseHeight_p/2, baseWidth_p, baseHeight_p];
    base_pom.FaceColor = [1, 0, 0, 0.25];
    base_pom.EdgeColor = "black";
    base_pom.LineWidth = 2;
    rotationAxis = plot(0, 0, 'o');
    rotationAxis.MarkerFaceColor = 'black';
    rotationAxis.MarkerEdgeColor = 'black';
    base_pom.addprop('rotationAxis');
    base_pom.rotationAxis = rotationAxis;

    xpen = [IC(1), IC(1)+Lc*cos(IC(2))];
    ypen = [0, Lc*cos(IC(2))];
    rod = plot(xpen, ypen);
    rod.LineWidth = 3;
    rod.Color = 'black';
    
    xmass = IC(1) + Lc*cos(IC(2));
    ymass = Lc*cos(IC(2));
    mass = plot(xmass, ymass, 'o');
    mass.MarkerSize = 12;
    mass.MarkerFaceColor = 'black';

    xpen_p = [IC(1), IC(1)+Lc*cos(IC(2))];
    ypen_p = [0, Lc*cos(IC(2))];
    rod_p = plot(xpen_p, ypen_p);
    rod_p.LineWidth = 10;
    rod_p.Color = [1,0,0,0.25];
    
    % xmass_p = IC(1) + Lc*cos(IC(2));
    % ymass_p = Lc*cos(IC(2));
    % mass_p = plot(xmass_p, ymass_p, 'o');
    % mass_p.MarkerSize = 20;
    % mass_p.Color = [0,0,0,0.25];
    
    text_format = 'czas: %0.2f';
    text_text = sprintf(text_format, 0);
    text_ui = text(0.01, 0.125, text_text);
    text_ui.FontSize = 16;
    text_ui.FontWeight = 'bold';

    % grid(ax, 'on');
    % axis equal;
    % uistack(craneRail, 'bottom');
    
    %% downsampling factor
    FPS  = 30;
    decimationFactor = 10;
    pauseTime = dt * decimationFactor;
    fprintf("FPS: %.3f\n", 1/pauseTime);
        
    daspect([1 1 1]);

    h(1) = plot(NaN,NaN,Color=[1,0,0,0.25]);
    h(2) = plot(NaN,NaN,Color='#f5c33b');
    legend(h, 'pomiar','symulacja');

    %%
    drawnow();
    pause(pauseTime);
    
    x = x(1 : decimationFactor : end);
    theta = theta(1 : decimationFactor : end);
    tout = tout(1 : decimationFactor : end);

    xp = xp(1 : decimationFactor : end);
    thetap = thetap(1 : decimationFactor : end);

    % legend('')

    h(1) = plot(NaN,NaN,Color=[1,0,0,0.25],LineWidth=10);
    h(2) = plot(NaN,NaN,Color='#f5c33b',LineWidth=10);

    %% anim
    mov(1) = getframe;
    disp('animating...');
    for i = 2:length(x)
        base.Position(1) = x(i) - baseWidth/2;
        base.rotationAxis.XData = x(i);
        base_pom.Position(1) = xp(i) - baseWidth_p/2;
        base_pom.rotationAxis.XData = xp(i);
    
        rod.XData = [ x(i), x(i) + Lc*sin(theta(i)) ];
        rod.YData = [ 0, Lc*cos(theta(i))];

        rod_p.XData = [ xp(i), xp(i) + Lc*sin(thetap(i)) ];
        rod_p.YData = [ 0, Lc*cos(thetap(i))];
    
        mass.XData = x(i) + Lc*sin(theta(i));
        mass.YData = Lc*cos(theta(i));
        
        mass_p.XData = xp(i) + Lc*sin(thetap(i));
        mass_p.YData = Lc*cos(thetap(i));

        text_ui.String = sprintf(text_format, tout(i));

        legend(h, 'pomiar','symulacja');

        drawnow();
        ax.XLim = XLIM; ax.YLim = YLIM;
        % pause(pauseTime);

        mov(i) = getframe;
    end
    disp('done animating.');

    %% zapisywanie
    if save_anim
        disp('saving...');
        v = VideoWriter(sprintf('%s', video_name), 'MPEG-4');
        v.FrameRate = 1/pauseTime;
        
        open(v);
        writeVideo(v, mov(2:end));
        close(v)
        disp('done saving.');
    end
u=0;
end