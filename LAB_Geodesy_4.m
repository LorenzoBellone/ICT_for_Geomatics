clc; clear all; close all;
format short;
P = load("points_helmert.TXT")/10^6;

A = zeros(36,7);
j = 1;
for i=1:size(P,1)
    A(j,:) =[1 0 0 P(i,1) 0 -P(i,3) P(i,2)];
    A(j+1, :) = [0 1 0 P(i,2) -P(i,3) 0 -P(i,1)];
    A(j+2, :) = [0 0 1 P(i,3) P(i,2) P(i,1) 0];
    j = j + 3;
end

l0 = zeros(size(A, 1), 1);
j = 1;
for i = 1:size(P, 1)
   l0(j) = (P(i, 4) - P(i , 1));
   l0(j+1) = (P(i, 5) - P(i , 2));
   l0(j+2) = (P(i, 6) - P(i , 3));
   j = j + 3;
end

x = inv(A'*A)*(A'*l0);
residuals = (A*x-l0)*10^6;
x(1:3) = x(1:3)*10^6;
% R = [x(4), x(7), -x(6); -x(7), x(4), x(5); x(6), -x(5), x(4)];
% p1_b = P(2, 1:3).'*10^6 + x(1:3) + R*P(2, 1:3).'*10^6;
error = [];
j=1;
for i = 1:size(P, 1)
    gen_error = sqrt(residuals(j)^2+residuals(j+1)^2 + residuals(j+2)^2);
    error(i) = gen_error;
    j = j+3;
end
mean_error = mean(error);
x(5:7) = 206264.8062471*x(5:7);
x(4) = 10^6 * x(4);

