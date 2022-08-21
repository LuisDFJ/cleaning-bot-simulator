% Load scene.mat - This file contains a blocks array and a collision array
%  * Blocks array is a set of boxes useful for drawing the simulation scene
%  (walls in black, obstacles in gray and cleaning area in white).
%  * Collision array is a simplified set of points conecting the outter
%  perimeter of the walls and obstacles.
%  * To change the dimensions of the room, you can modify scene.m file.
load( 'scene.mat', 'blocks', 'collision_blocks' )

% Inline functions to control robot's movement with respect to a Normal
% vector from the collided wall.
%  * d is a column vector with the current direction of the robot [d1;d2]
%  * C is a column vector with the normal vector of the collided wall
%  [n1;n2]
%  * a is a random scalar with values between [ +5°, -5° ] in radians
controller      = @(d, C, a) d - 2 * dot( d, C ) * C;

% V is a N x 2 matrix with the (x, y) coords for each corner of the outer
% perimeter of the room. Pack collision extracts the points from
% collision_blocks.
v = pack_collision( collision_blocks );
b = blocks;

% Initial position and direction of the robot.
c = [150;200];
d = 2*rand(2,1) - 1;

% Normalized initial direction of the robot. It is normalized so on each
% simulation step the robot will move 1unit of distance (1cm). To increase
% the displacement per simulation step, multiply d * scalar.
d = d / norm(d);

% Creates an empty figure with a reoslution of 424 x 424 pixels.
% Dimensions should match the dimensions of the room defined on scene.m.
f = create_figure( [424,424] );

% Run simulation. Check simulation.m for more info.
[time, step, clean_percent] = simulation( f, v, b, c, d, 15, controller );

% Metrics of the simulation.
fprintf( "Simulation time: %fs\n", time );
fprintf( "Simulation steps: %i\n", step );
fprintf( "Starting point: [%0.2f, %0.2f]\n", c(1), c(2) );
fprintf( "Starting direction: [%0.2f, %0.2f]\n", d(1), d(2) );
fprintf( "Cleaning percentage: %0.2f\n", 100 * ( 1 - clean_percent ) );
