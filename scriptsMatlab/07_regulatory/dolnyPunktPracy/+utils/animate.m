function u = animate(IC, Lc, dt, x, theta, tout, save_anim, video_name)
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

    % start_line = xline(track_len/2);
    % start_line.LineStyle = '--';
    % start_line.Color = [110, 108, 104] ./ 255;
    % start_line.LineWidth = 1.5;

    % target1 = xline(0.35);
    % target1.LineStyle = '--';
    % target1.Color = [110, 108, 104] ./ 255;
    % target1.LineWidth = 1.5;

    % target2 = xline(0.1);
    % target2.LineStyle = '--';
    % target2.Color = [110, 108, 104] ./ 255;
    % target2.LineWidth = 1.5;

    % set(gca,'YTickLabel',[]);
    % set(gca,'XTickLabel',[]);
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
    
    text_format = 'time: %0.2f';
    text_text = sprintf(text_format, 0);
    text_ui = text(0.01, 0.125, text_text);
    text_ui.FontSize = 14;
    text_ui.FontWeight = 'bold';

    % grid(ax, 'on');
    % axis equal;
    % uistack(craneRail, 'bottom');
    
    set(gca, 'XTickLabel', []);
    set(gca, 'YTickLabel', []);
    
    %% downsampling factor
    FPS  = 30;
    decimationFactor = 20;
    pauseTime = dt * decimationFactor;
    fprintf("FPS: %.3f\n", 1/pauseTime);
        
    daspect([1 1 1]);

    %%
    drawnow();
    pause(pauseTime);
    
    x = x(1 : decimationFactor : end);
    theta = theta(1 : decimationFactor : end);
    tout = tout(1 : decimationFactor : end);

    %% anim
    mov(1) = getframe;
    disp('animating...');
    for i = 2:length(x)
        base.Position(1) = x(i) - baseWidth/2;
        base.rotationAxis.XData = x(i);
    
        rod.XData = [ x(i), x(i) + Lc*sin(theta(i)) ];
        rod.YData = [ 0, Lc*cos(theta(i))];
    
        mass.XData = x(i) + Lc*sin(theta(i));
        mass.YData = Lc*cos(theta(i));
        text_ui.String = sprintf(text_format, tout(i));
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