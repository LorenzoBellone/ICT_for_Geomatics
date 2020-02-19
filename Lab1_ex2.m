%% Second Task:
% In this script we choose a dataset and a constellation developing a Least
% mean Square positioning algorithm and estimating the the user position at
% each time instant.

clc;clear;close all;

data = load("data\DataSet\RealisticUERE\dataset_1_20180329T160947.mat");
satellite = data.RHO.GAL;
earth_fixed_pos = data.SAT_POS_ECEF.GAL;
col = size(satellite,2);
row = size(satellite,1);
time_instant = zeros(1,col);
std_plots = zeros(row, (col-2));

for i = 1:row
    std_plots(i, :) = diff(satellite(i, :), 2);
end

std_satellites = zeros(row, 1);
for i = 1:row
    std_satellites(i, 1) = nanstd(std_plots(i, :));
end

K =10;
array=zeros(col,4);
std_pos_time = zeros(1, col);
std_pos_time_bis = zeros(1, col);

%epoc
for i = 1:col 
    index = find(not(isnan(satellite(:,i))));
    x_hat = zeros(1, 4);
    rho_hat = zeros(1,length(index));
    rho = satellite(index,i);
    H = zeros(length(index),4);
    H(:,4) = 1;
    R = zeros(length(index), length(index));
    
    for k = 1:K
        for j = 1:length(index)%visible satellite
            xyz = earth_fixed_pos(index(j)).pos(i,:);
            rho_hat(j)=sqrt((xyz(1)-x_hat(1))^2 + (xyz(2)-x_hat(2))^2+(xyz(3)-x_hat(3))^2);
            H(j,1) = (xyz(1)-x_hat(1))/ rho_hat(j);
            H(j,2) = (xyz(2)-x_hat(2))/ rho_hat(j);
            H(j,3) = (xyz(3)-x_hat(3))/ rho_hat(j);   
            R(j, j) = (std_satellites(index(j)))^2;
        end
        d_rho = rho_hat' - rho;
        d_x = (inv(H.'*H)*H.')*d_rho;
        x_hat = x_hat + d_x';
    end
    uere = mean(sqrt(diag(R)));
    G = inv(H.'*H);
    std_pos_time_bis(1, i) = sqrt(trace(G)-G(4, 4))*uere;
    Cov_x = inv(H.'*H)*H.'*R*H*inv(H.'*H);
    std_pos_time(1, i) = sqrt(trace(Cov_x) - Cov_x(4, 4));
    array(i,:) = x_hat;
end
exp_position = mean(array);
SigmaX_xyz = std(array); 
Real_SigmaX_mean = sqrt(SigmaX_xyz(1)^2 + SigmaX_xyz(2)^2 + SigmaX_xyz(3)^2); 
vec = ones(1, col)*Real_SigmaX_mean;
figure(1);
plot(std_pos_time_bis, 'r', 'LineWidth', 2);
xlabel('time (s)');
ylabel('Position Error (m)');
title('RealisticUERE - Dataset6 - BeiDou - LMS');
hold on;
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
writeKML_GoogleEarth('file_un',lla(:,1),lla(:,2),lla(:,3));
%refMap(lla(1), lla(2), "Here I am!");
 