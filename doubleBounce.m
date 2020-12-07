function [T, M] = doubleBounce

% Model Parameters
k = 500;                    % spring constant (N/m) *PLACEHOLDER*
cd = 1.2;                   % coefficient of drag (unitless)
rho = 1.2;                  % density of air at STP (kg/m^3)
area = .07;                 % area of standing human (m^2) *imprecise*
mass = 75;                  % weight of person (kg)

% Physical Constants
g = 9.8;                    % acceleration of gravity (m/s^2)

% Initial conditions
init = [0, 0, 0];     % [y, v, x] 

% Time
duration = 2;               % simulation length (s)
framerate = 30;             % animation framerate (s^-1)
timestep = 1/(framerate*10);
tspan = [0:timestep:duration];

% Set the events to capture end of simulation condition
options = odeset('Events', @event_func);

% Calculate the people's positions
[T, M, te, ye, ie] = ode45(@rate_func, tspan, init, options);

    function res = rate_func(~, X) 
        y = X(1);
        v = X(2);
        aDrag = drag(v) / mass;
        a = aDrag - g;
        res = [v; a; 0];
    end

    function res = drag(v)
        % Approximate drag force.  Human body shape is too complex.
        res = 0.5 * rho * v^2 * cd * area;
    end

    % Stop simulation when we aren't bouncing much.
    function [value, isterminal, direction] = event_func(~, X)
        value = 1; % *PLACEHOLDER*
        isterminal = 1;
        direction = 1;
    end

end