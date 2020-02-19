clc;clear;close all;

data = load("data\DataSet\NominalUERE\dataset_4_20180328T121804.mat");
time_instant = size(data.RHO.GPS,2);
satellite1 = data.RHO.GPS;
satellite2 = data.RHO.GAL;
satellite3 = data.RHO.GLO;
satellite4 = data.RHO.BEI;
n_satellites = zeros(4,time_instant);

for i = 1:time_instant
    n_satellites(1, i) = length(find(not(isnan(satellite1(:,i)))));
    n_satellites(2, i) = length(find(not(isnan(satellite2(:,i)))));
    n_satellites(3, i) = length(find(not(isnan(satellite3(:,i)))));
    n_satellites(4, i) = length(find(not(isnan(satellite4(:,i)))));
end

figure(1);
plot(n_satellites(1, :), 'linewidth', 5);
hold on;
plot(n_satellites(2, :), 'linewidth', 5);
hold on;
plot(n_satellites(3, :), 'linewidth', 5);
hold on;
plot(n_satellites(4, :), 'linewidth', 5);
xlabel('time (s)');
ylabel('Number of satellites');
legend('GPS', 'Galileo', 'GLONASS', 'BeiDou');
title('NominalUERE - Dataset4');

figure(2);
subplot(2, 2, 1);
for j = 1:size(satellite1, 1) 
    plot(satellite1(j,:));
    hold on
end
xlabel('time (s)');
ylabel('Pseudoranges (m)');
title('NominalUERE - Dataset4 - GPS');
subplot(2, 2, 2);
for j = 1:size(satellite2, 1) 
    plot(satellite2(j,:));
    hold on
end
xlabel('time (s)');
ylabel('Pseudoranges (m)');
title('NominalUERE - Dataset4 - Galileo');
subplot(2, 2, 3);
for j = 1:size(satellite3, 1) 
    plot(satellite3(j,:));
    hold on
end
xlabel('time (s)');
ylabel('Pseudoranges (m)');
title('NominalUERE - Dataset4 - GLONASS');
subplot(2, 2, 4);

for j = 1:size(satellite4, 1) 
    plot(satellite4(j,:));
    hold on
end
xlabel('time (s)');
ylabel('Pseudoranges (m)');
title('NominalUERE - Dataset4 - BeiDou');




