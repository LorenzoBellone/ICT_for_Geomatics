clc; clear all; close all;

Cases = [30, 37, 45, 60];
ml = zeros(size(Cases, 2), 7);
x = 0:0.5:3;
figure(1);
for i = 1:size(Cases, 2)
   k = 1;
   for j = 0:0.5:3
       ml(i, k) = 0.9996*(1 + (deg2rad(j)^2/2)*(cos(deg2rad(Cases(1, i))))^2);
       k = k+1;
   end
    plot(x, ml(i, :), '-o');
    hold on;
end
plot(x, ones(size(x, 2)), 'r')
xlabel("Longitude (deg)");
ylabel("Linear Deformation");
title("Linear Deformation vs longitude");
legend("Lat = 30", "Lat = 37", "Lat = 45", "Lat = 60");
ax = gca;
ax.YGrid = 'on';  
saveas(figure(1), "Ex5_2.jpeg"); 