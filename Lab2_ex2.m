clc; close all; clear all;

xsat = 15487292.829;
ysat = 6543538.932;
zsat = 20727274.429;
lat = deg2rad(45.06336);
long = deg2rad(7.661279);
f = 1/298.257223;
e = 2*f - f^2;
a = 6378137;
W = sqrt(1-e*sin(lat)^2);
X = a*cos(lat)*cos(long)/W;
Y = a*cos(lat)*sin(long)/W;
Z = a*(1-e)*sin(lat)/W;
M = [-sin(long), cos(long), 0; -sin(lat)*cos(long), -sin(lat)*sin(long), cos(lat); cos(lat)*cos(long), cos(lat)*sin(long), sin(lat)];
diff = [xsat-X; ysat-Y; zsat-Z];
local = M*diff;
azi = rad2deg(atan(local(3)/(sqrt(local(2)^2+local(1)^2))));
elev = rad2deg(atan(local(1)/local(2)));