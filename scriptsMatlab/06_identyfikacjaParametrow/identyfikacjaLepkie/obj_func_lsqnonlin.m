function [ cost ] = obj_func_lsqnonlin( params, IC, meas_data, volt, odetime, options )
    global cumul_cost;
    global plot_intermediate_optim_step;
    global display_intermediate_optim_params;
    global intermediate_params;
    global save_intermediate_params;
    global mov; 
    global save_plot_for_anim;

    % Symulacja
    end_time = odetime(end);
    [ ~, x1 ] = ode45( @( t,x ) LIP_dynamics_lepkie( t,x,params,volt,end_time ), odetime, IC, options );
    sim_data = x1(:, 1:2);

    % normalizacja - nieużywane
    % sim_data(:, 2)  = sim_data(:, 2)  - pi; % żeby normalizacja miała podobny wpływ na każdą zmienną
    % meas_data(:, 2) = meas_data(:, 2) - pi; % trzeba przenieść theta do zera
    % 
    % sim_data = sim_data ./ max(sim_data);
    % meas_data = meas_data ./ max(meas_data);

    measured_data = reshape(meas_data, 1, []);
    sim_data = reshape(sim_data, 1, []);

    cost = measured_data - sim_data;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % To można zakomentować i nic się nie stanie
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if plot_intermediate_optim_step
        fig1 = figure(1);
        clf(1)
        subplot(221)
        p1 = plot( odetime,meas_data(:,1),'Color','blue' ); hold on;
        p1.LineWidth = 1.15;
        p1 = plot( odetime,x1(:,1),'Color','black','LineStyle','--' );
        p1.LineWidth = 1.15;
        grid on;
        axis tight;

        subplot(222)
        p1 = plot( odetime,meas_data(:,2),'Color','blue' ); hold on;
        p1.LineWidth = 1.15;
        p1 = plot( odetime,x1(:,2),'Color','black','LineStyle','--'  );
        p1.LineWidth = 1.15;
        grid on;
        axis tight;

        subplot(223)
        % p1 = plot( odetime,meas_data(:,3),'Color','blue' ); hold on;
        % p1.LineWidth = 1.15;
        p1 = plot( odetime,x1(:,3),'Color','black','LineStyle','--'  );
        p1.LineWidth = 1.15;
        grid on;
        axis tight;

        subplot(224)
        % p1 = plot( odetime,meas_data(:,4),'Color','blue' ); hold on;
        % p1.LineWidth = 1.15;
        p1 = plot( odetime,x1(:,4),'Color','black','LineStyle','--'  );
        p1.LineWidth = 1.15;
        grid on;
        axis tight;
    end
    
    if save_plot_for_anim
        mov = [mov; getframe(fig1)];
    end
    
    cumul_cost = [cumul_cost; cost];

    if display_intermediate_optim_params
        fprintf("Lc=%f, b+beta=%f, gamma=%f, mr=%f, Mt=%f, L=%f, Jt=%f, alpha=%f\n", params);
    end
    if save_intermediate_params 
        intermediate_params = [intermediate_params; params];
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end