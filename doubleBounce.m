function [T, M] = doubleBounce(numBounces)

% Model Parameters
k = 500;                    % spring constant (N/m) *PLACEHOLDER*
cd = 1.2;                   % coefficient of drag (unitless)
rho = 1.2;                  % density of air at STP (kg/m^3)
area = .07;                 % area of standing human (m^2) *imprecise*

% Physical Constants
g = 9.8;                    % acceleration of gravity (m/s^2)

% Initial conditions
init = [0, 0, 0, 0, 0];     % [y(bee), vbee, yber, vber, xspring] 

% Time

% Set the events to capture end of simulation condition
options = odeset('Events', @event_func);

% Calculate the people's positions
[t, y, te, ye, ie] = ode45(@rate_func, init, options);

    function res = rate_func(~, X) 
        
    end

    function res = drag_force(v)
        % Approximate drag force.  Human body shape is too complex.
        res = - 0.5 * rho * v^2 * C_d * area;
    end

    % Stop simulation when we aren't bouncing much.
    function [value, isterminal, direction] = event_func(~, X)
        value = 1; % *PLACEHOLDER*
        
    end

end