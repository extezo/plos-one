clear;
close all;
w = 1000;
h = 1000;
d = 500;
[x, y] = meshgrid(1:w, 1:h);
x0 = x - w/2;
y0 = y - h/2;
r = 1/d * sqrt(x0 .^ 2 + y0 .^ 2);
beta = 1;
sf = 2;
T = 60/sf;

figure;
M = mira_f(beta, r, y0, T);
imshow(M)

function M = mira_f(beta, r, y0, T)
M = 1/2 * (besseli(1, beta * sqrt(1-r.^2) / besseli(1, beta)) .* sin(2*pi*y0/T) + 1);
M(r >= 1) = 1/2;
end