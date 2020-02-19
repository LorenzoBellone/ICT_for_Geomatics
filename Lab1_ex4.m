%% Fourth Task:

clc;clear;close all;

data = load("data\DataSet\RealisticUERE\dataset_1_20180329T160947.mat");
satellite = data.RHO.GAL;
earth_fixed_pos = data.SAT_POS_ECEF.GAL;
time_instant = size(satellite,2);
n_satellites = size(satellite,1);
std_plots = zeros(n_satellites, (time_instant-2));

for i = 1:n_satellites
    std_plots(i, :) = diff(satellite(i, :), 2);
end

std_satellites = zeros(n_satellites, 1);
for i = 1:n_satellites
    std_satellites(i, 1) = nanstd(std_plots(i, :));
end


rng('default')
K =10;
array=zeros(time_instant,4);
std_pos_time = zeros(1, time_instant);
%epoc
for i = 1:time_instant 
    index = find(not(isnan(satellite(:,i))));
    x_hat = zeros(1, 4);
    rho_hat = zeros(1,length(index));
    rho = satellite(index,i);
    R = zeros(length(index), length(index));
    H = zeros(length(index),4);
    H(:,4) = 1;
    for k = 1:K
        for j = 1:length(index)%visible satellite
            xyz = earth_fixed_pos(index(j)).pos(i,:);
            rho_hat(j)=sqrt((xyz(1)-x_hat(1))^2 + (xyz(2)-x_hat(2))^2+(xyz(3)-x_hat(3))^2);
            H(j,1) = (xyz(1)-x_hat(1))/ rho_hat(j);
            H(j,2) = (xyz(2)-x_hat(2))/ rho_hat(j);
            H(j,3) = (xyz(3)-x_hat(3))/ rho_hat(j);    
            R(j, j) = (std_satellites(index(j)))^2;
        end
        W = inv(R);
        H_new = inv((H')*W*H)*(H')*W;
        d_rho = rho_hat' - rho;
        d_x = H_new*d_rho;
        x_hat = x_hat + d_x';
    end
    Cov_x = inv(H.'*W*H)*H.'*W*R*W.'*H*inv(H.'*W*H);
    std_pos_time(1, i) = sqrt(trace(Cov_x)-Cov_x(4, 4));
    array(i,:) = x_hat;
end
figure(1)
plot(std_pos_time, 'r', 'LineWidth', 2)
xlabel('time (s)')
ylabel('Position Error (m)')
title('RealisticUERE - Dataset6 - GPS - WLMS')
hold on;
exp_position = mean(array);
SigmaX_xyz = std(array); 
Real_SigmaX_mean = sqrt(SigmaX_xyz(1)^2 + SigmaX_xyz(2)^2 + SigmaX_xyz(3)^2); 
vec = ones(1, time_instant)*Real_SigmaX_mean;
plot(vec, 'b', 'LineWidth', 2);
% figure(2);
% scatter(array(:, 1), array(:, 2));
% hold on;
% %%Plot the circle identifing the standard deviation
% radius = Real_SigmaX_mean;
% xc = exp_position(1);
% yc = exp_position(2);
% theta = linspace(0,2*pi);
% x = radius*cos(theta) + xc;
% y = radius*sin(theta) + yc;
% plot(x,y, 'r');
lla = ecef2lla(array(:, 1:3));
writeKML_GoogleEarth('file_uncorr',lla(:,1),lla(:,2),lla(:,3));