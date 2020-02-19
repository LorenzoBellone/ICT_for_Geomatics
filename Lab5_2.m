clc; clear all; close all;
%% Transformation from geographic coordinates to cartographic coordinates
P1 = [45.56825, 7+47/60+26.292/3600];
P2 = [38+32/60+34.649/3600, 16+60/60+6.493/3600];
%WGS84 parameters:
a = 6378137;
c = 6356752.31424518;
e_sq = 0.00669437999014132;
e_sq_prime = 0.00673949674227643;
Rp = a^2/c;
%First point
%General parameters for Hirvonen's formula:
v1 = sqrt(1 + e_sq_prime*cos(deg2rad(P1(1)))^2);
lat_prime = deg2rad(P1(2)-9);
psi = atan(tan(deg2rad(P1(1)))/cos(v1*lat_prime));
v = sqrt(1 + e_sq_prime*cos(psi)^2);
A1 = 1 - e_sq/4-3*e_sq^2/64-5*e_sq^3/256;
A2 = 3*e_sq/8+3*e_sq^2/32+45*e_sq^3/1024;
A4 = 15*e_sq^2/256+45*e_sq^3/1024;
A6 = 35*e_sq^3/3072;
x1 = Rp*asinh(cos(psi)*tan(lat_prime)/v);
y1 = a*(A1*psi-A2*sin(2*psi)+A4*sin(4*psi)-A6*sin(6*psi));
East1 = x1*0.9996+500000;
North1 = y1*0.9996;
%Second Point
%General parameters for Hirvonen's formula:
v1 = sqrt(1 + e_sq_prime*cos(deg2rad(P2(1)))^2);
lat_prime = deg2rad(P2(2)-15);
psi = atan(tan(deg2rad(P2(1)))/cos(v1*lat_prime));
v = sqrt(1 + e_sq_prime*cos(psi)^2);
x2 = Rp*asinh(cos(psi)*tan(lat_prime)/v);
y2 = a*(A1*psi-A2*sin(2*psi)+A4*sin(4*psi)-A6*sin(6*psi));
East2 = x2*0.9996+500000;
North2 = y2*0.9996;