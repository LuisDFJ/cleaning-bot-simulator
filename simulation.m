% Discrete event collision simulation.
%  * f is the figure in which the simulation will occur. Only useful for
%  graphics display.
%  * v is a matrix of x, y coord of the room's corners. 
%  * b is an array with the visual scene. Only useful for graphics display.
%  * c is the position of the center of the robot.
%  * d is the direction of the robot.
%  * r is the radius of the robot.
%  * controller is a function that controls the behaviour of the robot when
%  colliding with a wall.
function [time, step, clean_percent] = simulation( f, v, b, c, d, r, controller ) 
    % Draws the walls, obstacles and cleanning area on the figure.
    generate_room( f, b );
    
    % ROBOT's GRAPHIC REPRESENTATION:
    %   1. Selects figure f for drawing.
    figure(f);
    hold on
    %   2. Creates a set of points of a circle with radius r centered at
    %   the origin.
    t = linspace( 0, 2*pi, 120 );
    robot = [ r * cos( t ); r * sin( t ) ]';
    %   3. Creates a dynamic plot showing the complete path of the robot.
    %     * path is a dynamic vector that will store all the positions
    %     where a collision occurs.
    %     * p is a dynamic plot that will refresh on each iteration with
    %     the actual position of the robot and its previous steps.
    path = c';
    p = plot( [ path(:,1); c(1) ], [ path(:,2); c(2) ], 'y', 'linewidth', 1.5 * r );
    p.XDataSource = '[ path(:,1); c(1) ]';
    p.YDataSource = '[ path(:,2); c(2) ]';
    %   4. Creates a dynamic plot of the robot (a circle).
    %     * h is a dynamic plot that will refresh on each iteration with
    %     the actual position of the robot.
    h = plot( robot(:,1) + c(1), robot(:,2) + c(2), 'g' );
    h.XDataSource = 'robot(:,1) + c(1)';
    h.YDataSource = 'robot(:,2) + c(2)';
    
    % Initialize metrics of the simulation
    step = 0;
    clean_percent = 1;
    % Count initial amount of white pixels on the figure.
    c_white = count_white_pixels( f, 255 );
    disp( c_white )
    % Tic is a Matlab expresion that sets a timer. The timer stops when toc
    % is called by the program.
    tic;
    
    % If the simulation is closed Matlab will raise an Exception, try is
    % used to avoid errors when the simulation figure is closed by the
    % user. 
    try
        % Run simulation undefinetly.
        while true
            % Coun the number of simulation steps.
            step = step + 1;
            % Change robot position by one step on the current direction.
            c = c + d;
            % Plot new position using the dynamic plots.
            refreshdata( p, 'caller' );
            refreshdata( h, 'caller' );
            
            % Check if new position collides with a wall. See
            % check_collision.m form more info.
            [flag, C] = check_collision( v, c', r );
            
            % If coliision occured.
            if flag
                % Generates a random angle between [ +5°, -5° ] in radians.
                angle = 5 * pi / 180 * rand() - 2.5 * pi / 180;
                % Change robot direction by calling the controller.
                d = controller( d, C', angle );
                % Append position to the current path.
                path = [path; c'];
                % Count number of remaining white pixels
                c_clean = count_white_pixels( f, 255 );
                % Calculate cleaning percent
                clean_percent = c_clean / c_white ;
                % If ramaining cleaning area is below 10%. Stop simulation.
                if clean_percent < 0.1
                    break
                end
            end
            %pause( 1/1000 )
        end
    catch
        fprintf( "Simulation failed\n" );
    end
    % Stop timer and capture time elapsed.
    time = toc;
    fprintf( "Simulation ended - Time elapsed: %0.5fs\n", time );
    
end