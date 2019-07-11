clc;
close all;
clear all;
%% initial parameter
L = 7.984803; %leg length[m]
R = L/200; %cylinder radius[m]
L1 = 0.275*L; %femur length[m] 0.275
L2 = 0.283*L; %tibia length[m] 0.283
L3 = 0.442*L; %foot length[m] 0.442
clc;

%% load data
load('x3y3phical.mat');

%% inverse kinematics
x2 = 0; 
y2 = 0;
theta1 = 0; 
theta2 = 0;
theta3 = 0;
for i = 1:32 
    x2(i) = x3(i) - L3*cos(phi(i));
    y2(i) = y3(i) - L3*sin(phi(i));
    r = sqrt(x2(i)^2 + y2(i)^2);
    theta1(i) = atan2(y2(i),x2(i)) - acos((L1^2 + r^2 - L2^2)/(2*L1*r));
    disp(i);
    disp(theta1(i));
    disp(acos((L1^2 + r^2 - L2^2)/(2*L1*r)));
    theta2(i) = pi - acos((L1^2 + L2^2 - r^2)/(2*L1*L2));
    disp(theta2(i))
    theta3(i) = phi(i) - theta1(i) - theta2(i);
end

theta1 = theta1';
theta2 = theta2';
theta3 = theta3';

%% input
time = linspace(0,10,32);
th1 = theta1; %pelvis angle[rad]
th2 = theta2; %knee angle[rad]
th3 = theta3; %ankle angle[rad]

%% simulation
sim('kinematic.slx');

%% coupler curve
figure('Name','Coupler Curve','NumberTitle','off');
posx = coupler_curve.Data(:,1);
posz = coupler_curve.Data(:,2);
t = coupler_curve.Time;
hold on;
% plot(t,posx);
% plot(t,posz);
plot(posx,posz);