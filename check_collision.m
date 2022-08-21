% Check if a collision occured by iterating through all the available walls
% and running collision_detect function.
%   * v is a N x 2 matrix with the coordinates of all collision walls
%   corners.
%   * p is the current position of the robot.
%   * r is the radius of the robot.
function [c, C] = check_collision( v, p, r )
    len = size( v );
    % For each coner in matrix v
    for i = 1 : len(1) - 1
        % Run collision detect in couples of corners v_i & v_i + 1
        % to iterate through all posible walls in the room.
        %   * See collision_detect.m to explore the collision logics.
        [flag, N] = collision_detect( p, v(i, :), v(i + 1, :), r );
        % If a colision is detected stop the function.
        if flag
            C = N;
            c = true;
            return
        end
    end
    c = false;
    C = [0,0];
    return
end