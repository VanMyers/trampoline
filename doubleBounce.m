function [T, M] = doubleBounce

% Model Parameters
k = 50000;                 % spring constant (N/m) *PLACEHOLDER*
cd = 1.2;                   % coefficient of drag (unitless)
rho = 1.2;                  % density of air at STP (kg/m^3)
area = .07;                 % area of standing human (m^2) *imprecise*
mass = 75;                  % weight of person (kg)

% Physical Constants
g = 9.8;                    % acceleration of gravity (m/s^2)

% Initial conditions
init = [2, 0, 0, 0];     % [y, v, x, vx] 

% Time
duration = 2;              % simulation length (s)
framerate = 30;             % animation framerate (s^-1)
timestep = 1/(framerate*10);
tspan = [0:timestep:duration];

% Set the events to capture end of simulation condition
options = odeset('Events', @event_func);

% Calculate the people's positions
[T, M, te, ye, ie] = ode45(@rate_func, tspan, init, options);

    function res = rate_func(~, X)
        % extract state
        y = X(1);
        v = X(2);
        x = X(3);
        vx = X(4);
        
        fDrag = drag(v);
        fSpring = spring(x);
        fDown = fDrag - g*mass;

        % don't stick to the spring
        if y-x <= .00001
            fOnSpring = fDown;
            s = fSpring;
        else
            fOnSpring = 0;
            s = 0;
        end
        ax = (fSpring + fOnSpring) / mass;
        vx = 0;
        a = (fDown + s) / mass;
        res = [v; a; vx; ax];
    end

    function res = spring(x)
        res = k * x;
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