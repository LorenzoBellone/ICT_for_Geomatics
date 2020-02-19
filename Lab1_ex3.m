%% Third Task:
% In this script we compute the standard deviation of the position error over 
% time n = 0, 1, ... N, comparing the quality of the obtained solutions for
% different datasets and constellations.

clc;clear;close all;

data = load("data\DataSet\RealisticUERE\dataset_2_20180329T160900.mat");
satellite = data.RHO.GPS;
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

[~, best_satellite] = nanmin(std_satellites);