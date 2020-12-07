function [T, M] = doubleBounce(numBounces)

% Model Parameters
k = 500;                  % spring constant (N/m) *PLACEHOLDER*

% Physical Constants
g = 9.8;                  % acceleration of gravity (m/s^2)

% Initial conditions
init = [0, 0, 0, 0, 0]; % [y(bee), vbee, yber, vber, xspring] 

% Time

% Set the events to capture end of simulation condition
options = odeset('Events', @event_func);

% Calculate the people's positions
[t, y, te, ye, ie] = ode45(@rate_func, init, options);

    function res = rate_func(~, X) 
        
    end

    % Stop simulation when we aren't bouncing much.
    function [value, isterminal, direction] = event_func(~, X)
        value = 1; % *PLACEHOLDER*
        
    end

end