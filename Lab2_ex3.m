clc; clear all; close all;

lat = deg2rad(45.06333);
long = deg2rad(7.661389);
f = 1/298.257223;
e = 2*f - f^2;
a = 6378137;
W = sqrt(1-e*sin(lat)^2);
Xrec = a*cos(lat)*cos(long)/W;
Yrec = a*cos(lat)*sin(long)/W;
Zrec = a*(1-e)*sin(lat)/W;
Pos = [22504974.806 13900127.123 -2557240.727 ; -3760396.280 -17947593.853 19494169.070 ; 9355256.428 -12616043.006 21189549.365; 23959436.524 5078878.903 -10562274.680; 10228692.060 -19322124.315 14550804.347 ; 23867142.480 -3892848.382 10941892.224 ; 21493427.163 -15051899.636 3348924.156 ; 14198354.868 13792955.212 17579451.054 ; 18493109.722 4172695.812 18776775.463 ; -8106932.299 12484531.565 22195338.169; 8363810.808 21755378.568 13378858.106];
ro = zeros(11, 1);
D = zeros(size(ro, 1), 4);
for i=1:size(ro, 1)
    ro(i, 1) = sqrt((Pos(i, 1)-Xrec)^2+(Pos(i, 2)-Yrec)^2+(Pos(i, 3)-Zrec)^2);
    D(i, 1) = (Pos(i, 1)-Xrec)/ro(i, 1);
    D(i, 2) = (Pos(i, 2)-Yrec)/ro(i, 1);
    D(i, 3) = (Pos(i, 3)-Zrec)/ro(i, 1);
    D(i, 4) = -1;
end
Qxx = inv(D.'*D);
Qsub = Qxx(1:3, 1:3);
R = [-sin(long), cos(long), 0; -sin(lat)*cos(long), -sin(lat)*sin(long), cos(lat); cos(lat)*cos(long), cos(lat)*sin(long), sin(lat)];
Quu = R*Qsub*R.';

HDOP = sqrt(Quu(1, 1)+Quu(2, 2));
PDOP = sqrt(Quu(1, 1)+Quu(2, 2)+ Quu(3, 3));
GDOP = sqrt(Quu(1, 1)+Quu(2, 2)+ Quu(3, 3)+ Qxx(4, 4));
