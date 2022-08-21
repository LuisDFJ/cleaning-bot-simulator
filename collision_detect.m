% Detects if a robot with position p has collided with a wall delimited by
% two points (P1, P2).
%   * p is a row vector [p1, p2] with current coordinates of the robot.
%   * P1 is the first corner of the wall [p1, p2].
%   * P2 is the second corner of the wall [p1, p2].
%   * r is the radius of the robot.
function [collision, N] = collision_detect( p, P1, P2, r )
    
    P12 = P2 - P1;
    PA  = p - P1;
    PB  = p - P2;
    % If point p is near the collision area of the wall.
    %   * Collision area is defined using the distance from point P1 to p
    %   and from P2 to p. If these two distances are less than the length
    %   of the wall + a debugging componnet. Then, point p is able to
    %   collide with the wall.
    if ( norm( PA ) <= norm( P12 ) + r * sqrt(2) ) && ( norm( PB ) <= norm( P12 ) + r * sqrt(2) )
        % Calculate the normal vector of the wall.
        M = line_equation( P1, P2 );
        % Calculate the shortest distance from a line crossing P1 and P2 to
        % point p.
        d = abs( P12(1) * PA(2) - P12(2) * PA(1) ) / norm( P12 );
        % If the distance to the wall is less than the radius of the robot
        % a collision has occured.
        if d < r + 1
            
            % This statement is for avoiding the robot from glitching with
            % the walls.
            if d < r - 0.5
                collision = true;
                N = [ M(1), -2 * M(2) ];
                N = N / norm( N );
                return;
               
            % This statement is for the normal behaviour of the robot.
            else
                % Return the normal vector to the wall and a collision
                % flag.
                collision = true;
                N = [ M(2), -M(1) ];
                N = N / norm( N );
                return;
            end
        end
        
    end
    collision = false;
    N = [0,0];
    return;
end