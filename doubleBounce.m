function [T, M, te, ye] = doubleBounce

% [T,M,te,ye] = doubleBounce(); clf; hold on; plot(T,M(:,1)); plot(te, ye(:,1));

% Model Parameters
k = 50000;                  % spring constant (N/m) *PLACEHOLDER*
cd = 1.2;                   % coefficient of drag (unitless)
rho = 1.2;                  % density of air at STP (kg/m^3)
area = .07;                 % area of standing human (m^2) *imprecise*
mass = 75;                  % weight of person (kg)
t0 = -.15;                  % double bounce deformation (m)
eff = .87;                  % effectiveness of trampoline (unitless)

% Physical Constants
g = 9.8;                    % acceleration of gravity (m/s^2)

% Initial conditions
init = [2, 0];     % [y, v] 

% Time
duration = 120;              % simulation length (s)
framerate = 30;             % animation framerate (s^-1)
timestep = 1/(framerate*10);
tspan = [0:timestep:duration];

% Set the events to capture end of simulation condition
options = odeset('Events', @event_func);

% Calculate the people's positions
[T, M, te, ye, ie] = ode23(@rate_func, tspan, init, options);

    function res = rate_func(~, X)
        % extract state
        y = X(1);
        v = X(2);
        
        fDrag = drag(v);
        
        if ((y < 0) & (v > 0))
            fSpring = spring(y) * eff;
        elseif (y < t0)
            fSpring = spring(y);
        else
            fSpring = 0;
        end
        
        a = (fSpring + fDrag) / mass - g;
        res = [v; a];
    end

    function res = spring(x)
        res = -k * x;
    end
    
    function res = drag(v)
        % Approximate drag force.  Human body shape is too complex.
        res = 0.5 * rho * v^2 * cd * area;
    end

    % Apex of jump
    function [value, isterminal, direction] = event_func(~, X)
        value = X(2);
        isterminal = 0;
        direction = -1;
    end

end