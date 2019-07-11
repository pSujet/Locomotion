clc;
close all;
clear all;

%% initial parameter
load('profile_test.mat');
open('kinematic.slx');
%% Update Model
set_param(gcs,'SimulationCommand','Update'); % Update Model

%% Simulate the Simulink Model
sim('kinematic.slx');

%% optimization initial
% L1 = 2.1958 [cm]
% L2 = 2.2597 [cm]
% L3 = 3.5293 [cm]
x_ref = posx; 
z_ref = posz;

%% optimization
clc;
close all;

X0 = [2.3 1.85 3]; %initial guess
lower_bound = [1.8, 1.8, 2];
upper_bound = [2.5, 2.5, 4];
objective = @(X)cost(X, [x_ref z_ref]);
options = optimset('Display','iter','TolX',1e-8, 'MaxIter', 50, 'PlotFcns', {'optimplotx', 'optimplotfval' }); % optimplotfval

mdl = 'kinematic.slx';
open(mdl);

f = figure(101);
set(gcf, 'Position', [1000 200 2560 1280]/2);
plot(x_ref, z_ref, 'LineWidth', 4, 'Color', 'k');
hold on;
xlabel('X [cm]');
ylabel('Z [cm]');
title('Parametric Design Optimization for Trajectory Following Application');
grid on;
set(gca, 'FontSize', 16);

% Solve Optimization Problem
[X_opt, fval] = fmincon(objective, X0, [], [], [], [], lower_bound, upper_bound,[], options)
L1_opt = X_opt(1);
L2_opt = X_opt(2);
L3_opt = X_opt(3);

% Display Result
disp(sprintf('Optimal Design Parameters\nL1 = %.4f [cm]\nL2 = %.4f [cm]\nL3 = %.4f [cm]', L1_opt, L2_opt,L3_opt));


