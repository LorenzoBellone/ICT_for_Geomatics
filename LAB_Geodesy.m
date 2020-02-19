clc; clear all; close all;
format long g;
%% Part 1: Evaluation of the parameters for different types of ellipsoids: alfa, e^2 and e'^2
X = [6376985, 1/308.6; 
    6377276, 1/300.8; 
    6377397, 1/299.1528128; 
    6378338, 1/288.5; 
    6378249, 1/293.5; 
    6378140, 1/298.3; 
    6378388, 1/297.0; 
    6378245, 1/298.3; 
    6378137, 1/298.257223563];
R = zeros(9, 3);
for i = 1:size(X, 1)
    R(i, 1) = X(i, 1)*(1-X(i, 2));
    R(i, 2) = (X(i, 1)^2-R(i, 1)^2)/(X(i, 1)^2);
    R(i, 3) = R(i, 2)/(1 - R(i, 2));
end
%% Part 2: Conversion from geographical to cartesian according to 2 models of ellipsoids, WGS 84 and Heyford
p1 = [deg2rad(44.75029), deg2rad(7.408112), 322.4909];
p2 = [deg2rad(44.78636), deg2rad(7.507372), 305.7367];
pos1_1 = zeros(3, 1);
W = sqrt(1-R(9, 2)*(sin(p1(1)))^2); %WGS84
pos1_1(1, 1) = (X(9, 1)/W+p1(3))*cos(p1(1))*cos(p1(2));
pos1_1(2, 1) = (X(9, 1)/W+p1(3))*cos(p1(1))*sin(p1(2));
pos1_1(3, 1) = ((X(9, 1)/W)*(1-R(9, 2))+p1(3))*sin(p1(1));    

W2 = sqrt(1-R(7, 2)*(sin(p1(1)))^2); %Hayford
pos1_2 = zeros(3, 1);
pos1_2(1, 1) = (X(7, 1)/W2+p1(3))*cos(p1(1))*cos(p1(2));
pos1_2(2, 1) = (X(7, 1)/W2+p1(3))*cos(p1(1))*sin(p1(2));
pos1_2(3, 1) = ((X(7, 1)/W2)*(1-R(7, 2))+p1(3))*sin(p1(1));   

diff = pos1_1 - pos1_2;

p1_h = [deg2rad(44.75029), deg2rad(7.408112), 2322.4909];
pos1_h = zeros(3, 1);
W = sqrt(1-R(9, 2)*(sin(p1_h(1)))^2); %WGS84
pos1_h(1, 1) = (X(9, 1)/W+p1_h(3))*cos(p1_h(1))*cos(p1_h(2));
pos1_h(2, 1) = (X(9, 1)/W+p1_h(3))*cos(p1_h(1))*sin(p1_h(2));
pos1_h(3, 1) = ((X(9, 1)/W)*(1-R(9, 2))+p1_h(3))*sin(p1_h(1));    
newdiff = pos1_h - pos1_1;

pos2_1 = zeros(3, 1);
W = sqrt(1-R(9, 2)*(sin(p2(1)))^2); %WGS84
pos2_1(1, 1) = (X(9, 1)/W+p2(3))*cos(p2(1))*cos(p2(2));
pos2_1(2, 1) = (X(9, 1)/W+p2(3))*cos(p2(1))*sin(p2(2));
pos2_1(3, 1) = ((X(9, 1)/W)*(1-R(9, 2))+p2(3))*sin(p2(1));    

W2 = sqrt(1-R(7, 2)*(sin(p2(1)))^2); %Hayford
pos2_2 = zeros(3, 1);
pos2_2(1, 1) = (X(7, 1)/W2+p2(3))*cos(p2(1))*cos(p2(2));
pos2_2(2, 1) = (X(7, 1)/W2+p2(3))*cos(p2(1))*sin(p2(2));
pos2_2(3, 1) = ((X(7, 1)/W2)*(1-R(7, 2))+p2(3))*sin(p2(1)); 

diff2 = pos2_1 - pos2_2;