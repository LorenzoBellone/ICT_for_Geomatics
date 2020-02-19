clc; clear all; close all;  
P = [4499525.4271, 585034.1293, 4467910.3596; 
     4495694.2695, 592457.8605, 4470744.7781; 
     4503484.7172, 578160.7507, 4465024.3002; 
     4498329.3715, 562840.7651, 4472537.6125];
th = 10^(-8);
long = zeros(size(P, 1), 1);
Geog = zeros(size(P));
for i = 1:size(P, 1)
    long(i, 1) = atan(P(i, 2)/P(i, 1));
    r = sqrt(P(i, 1)^2 + P(i, 2)^2);
    lat = atan(P(i, 3)/r);
    fin = 0;
    e = 0.00669437999014132;
    idx = 1;
    h_plot = [];
    lat_plot = [];
    while fin == 0
        W = sqrt(1-e*(sin(lat)^2));
        N = 6378137/W;
        hnew = P(i, 1)/(cos(lat)*cos(long(i, 1)))-N;
        latnew = atan(P(i, 3)/(r*(1-e*N/(N+hnew))));
        if (abs(latnew - lat) < th) && (abs(hnew - h) < th)
            fin = 1;
        end
        lat = latnew;
        h = hnew;
        h_plot(idx) = h;
        lat_plot(idx) = lat;
        idx = idx +1;
    end
    figure(i);
    subplot(2, 1, 1);
    plot(h_plot, "LineWidth", 2);
    xlabel("Iteration");
    ylabel("h (m)");
    title1 = "Altitude vs Iterations, Point " + int2str(i);
    title(title1);
    subplot(2, 1, 2);
    plot(lat_plot, "LineWidth", 2);
    xlabel("Iteration");
    ylabel("Latitude (rad)");
    title2 = "Latitude vs Iterations, Point " + int2str(i);
    title(title2);
    Geog(i, 1) = rad2deg(lat);
    Geog(i, 2) = rad2deg(long(i, 1));
    Geog(i, 3) = h;
end
% saveas(figure(1), "Plots1.jpeg");
% saveas(figure(2), "Plots2.jpeg");
% saveas(figure(3), "Plots3.jpeg");
% saveas(figure(4), "Plots4.jpeg");