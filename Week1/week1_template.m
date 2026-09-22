%% SEMTM0009 Week 1 Worksheet -- computational template
%  Questions 2(e) and 2(f).
%
%  Nothing here is assessed on coding style. The scaffolding is done;
%  you only need to fill in the lines marked  % TODO.
%
%  Run each cell with Ctrl+Enter (MATLAB) or section-by-section.

%% ------------------------------------------------------------------
%  Q2(e) part 1: cobweb diagram
% -------------------------------------------------------------------
% A cobweb iterates x_{n+1} = f(x_n) graphically:
%   from (x_n, x_n) go VERTICALLY to the curve   -> (x_n, f(x_n))
%   then HORIZONTALLY to the diagonal            -> (f(x_n), f(x_n))
%   repeat.

clear; clc; close all

rvals = [2.6 3.2 3.9];      % try these three
x0    = 0.10;               % initial condition
nIter = 60;                 % number of iterations

figure('Position',[100 100 1100 340])
for k = 1:numel(rvals)
    r = rvals(k);

    % TODO: define the logistic map as an anonymous function of x
    f = @(x) r.*x.*(1-x);          % <-- already given; check you understand it

    subplot(1,3,k); hold on; box on
    xgrid = linspace(0,1,400);
    plot(xgrid, f(xgrid), 'LineWidth', 1.8)   % the map
    plot(xgrid, xgrid,   'k-', 'LineWidth', 1)% the diagonal y = x

    x = x0;
    for n = 1:nIter
        y = f(x);
        % TODO: draw the vertical segment from (x,x) to (x,y)
        plot([x x], [x y], 'r-', 'LineWidth', 0.8)
        % TODO: draw the horizontal segment from (x,y) to (y,y)
        plot([x y], [y y], 'r-', 'LineWidth', 0.8)
        x = y;                       % the new x_n is the old x_{n+1}
    end

    axis([0 1 0 1]); axis square
    xlabel('x_n'); ylabel('x_{n+1}')
    title(sprintf('r = %.1f', r))
end

% QUESTION: at r = 3.2 the cobweb closes onto a square. What is the
% biological meaning of that square?


%% ------------------------------------------------------------------
%  Q2(e) part 2: bifurcation diagram
% -------------------------------------------------------------------
% For each r, iterate long enough to forget the initial condition
% (the TRANSIENT), then record the next few hundred iterates (the
% ATTRACTOR). Plotting those against r gives the bifurcation diagram.

clear; close all

rvals    = linspace(2.4, 4.0, 1200);
nTrans   = 400;     % iterations discarded
nKeep    = 150;     % iterations plotted
x0       = 0.30;

R = []; X = [];
for r = rvals
    x = x0;
    for n = 1:nTrans
        x = r*x*(1-x);             % TODO: why do we throw these away?
    end
    for n = 1:nKeep
        x = r*x*(1-x);
        R(end+1) = r;  %#ok<SAGROW>
        X(end+1) = x;  %#ok<SAGROW>
    end
end

figure('Position',[100 100 800 420])
plot(R, X, '.', 'MarkerSize', 1)
xlabel('r'); ylabel('long-run values of x_n')
xline(3.0,       '--', 'r = 3');
xline(1+sqrt(6), ':',  'r = 1+\surd6');
xlim([2.4 4]); ylim([0 1])

% QUESTION: identify on your plot the values r = 3, r = 1+sqrt(6) ~ 3.449,
% and r_inf ~ 3.5699. What changes at each?


%% ------------------------------------------------------------------
%  Q2(f): the logistic ODE versus the logistic map
% -------------------------------------------------------------------
% The ODE's carrying capacity is stable for EVERY r > 0.
% The map's non-trivial fixed point destabilises at r = 3.
% This cell puts them side by side.

clear; close all

K  = 10;
x0 = 0.5;
rODE = [0.8 2.5 3.5];
rMAP = [2.5 3.2 3.9];

figure('Position',[100 100 1000 360])

% --- left: exact solution of the logistic ODE ---
subplot(1,2,1); hold on; box on
t = linspace(0,12,400);
for r = rODE
    % TODO: fill in the exact solution you derived in Q1(d)
    x = x0*K*exp(r*t) ./ (K - x0 + x0*exp(r*t));
    plot(t, x, 'LineWidth', 1.8, 'DisplayName', sprintf('r = %.1f', r))
end
yline(K,'k--'); legend('Location','southeast')
xlabel('t'); ylabel('x(t)'); ylim([0 12])
title('logistic ODE: x^* = K stable for all r > 0')

% --- right: iterates of the logistic map ---
subplot(1,2,2); hold on; box on
nSteps = 40;
for r = rMAP
    x = zeros(1,nSteps); x(1) = 0.2;
    for n = 1:nSteps-1
        x(n+1) = r*x(n)*(1-x(n));
    end
    plot(0:nSteps-1, x, '-o', 'MarkerSize', 3, 'LineWidth', 1, ...
         'DisplayName', sprintf('r = %.1f', r))
end
legend('Location','southeast')
xlabel('n'); ylabel('x_n'); ylim([0 1.05])
title('logistic map: loses stability at r = 3')

% --- the explanation, for you to verify numerically ---
% An Euler step of size h on the logistic ODE gives, after rescaling,
%       u_{n+1} = R u_n (1 - u_n)   with   R = 1 + h*r.
% So R = 3 corresponds to h*r = 2.
%
% TODO: set r = 1 and integrate the logistic ODE with forward Euler using
%       h = 0.5, h = 1.5 and h = 2.5. At which step size do you first see
%       oscillation, and does it match the prediction h = 2/r?
