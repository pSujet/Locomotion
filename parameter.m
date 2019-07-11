clc;
close all;
clear all;

%% initial parameter
L = 7.984803; %leg length[cm]
R = L/200; %cylinder radius[cm]
L1 = 0.275*L; %femur length[cm] 
L2 = 0.283*L; %tibia length[cm] 
L3 = 0.442*L; %foot length[cm] 
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
    theta2(i) = pi - acos((L1^2 + L2^2 - r^2)/(2*L1*L2));
    theta1 = unwrap(theta1);
    theta2 = unwrap(theta2);
    theta3(i) = phi(i) - theta1(i) - theta2(i);
    theta3 = unwrap(theta3);
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
sim('kinematic_test.slx');

%% coupler curve
figure('Name','Coupler Curve','NumberTitle','off');
posx = coupler_curve.Data(:,1);
posz = coupler_curve.Data(:,2);
time_coupler = coupler_curve.Time;
hold on;
% plot(t,posx);
% plot(t,posz);
plot(posx,posz);

%% torque profile
torque_pelvis = torqueout.Data(:,1);
torque_knee = torqueout.Data(:,2);
torque_ankle = torqueout.Data(:,3);
time_torque = torqueout.Time;
torque_pelvis(3250) = 0;
torque_knee(3250) = 0;
torque_ankle(3250) = 0;
figure;
subplot(3,1,1);
plot(time_torque,torque_pelvis);
xlabel('time [s]');
ylabel('torque [N*cm]');
title(sprintf('Torque at pelvis'));
subplot(3,1,2);
plot(time_torque,torque_knee,'r');
xlabel('time [s]');
ylabel('torque [N*cm]');
title(sprintf('Torque at knee'));
subplot(3,1,3);
plot(time_torque,torque_ankle,'g');
xlabel('time [s]');
ylabel('torque [N*cm]');
title(sprintf('Torque at ankle'));
time2 = time_torque';
