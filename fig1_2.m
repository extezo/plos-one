clear;
close all;
FONT_SIZE = 14;
LABEL_NORMFREQ = 'Normalized Frequency';
LABEL_SPECTRUM = 'Spectrum';

width = 1001;
period = 40;

x_flat = -width/2+0.5:width/2-0.5;
[x, y] = meshgrid(x_flat, x_flat);
x_flat = - 2 * (width - 1):2 * (width - 1);
f_flat = x_flat / width;

l = 0.5 * sin(2 * pi * x_flat / period);
l_clip = l;
l_clip(abs(x_flat) > width/2-2) = 0;
win = kaiser(width, 5);
l_win = l_clip;
low = floor((length(l_win) - length(win))/2);
l_win(low:low+ length(win) - 1) = l_win(low:low+ length(win) - 1) .* win';
l_win = l_win + 0.5;


normalize = @(x) (x / max(x));
getSpecter = @(l) (normalize(abs(fftshift(fft(l)))));

s_win = getSpecter(l_win);
s_win(2001) = s_win(2001) / 10;
s_win = s_win * 10;

figure;
semilogy(f_flat, s_win, 'k', 'LineWidth', 2);
set(gca, 'FontSize', FONT_SIZE);
hold on;

line = ones(size(f_flat)) / 100;
semilogy(f_flat, line, 'k--', 'LineWidth', 4);
xlim([0,0.5]);
xlabel(LABEL_NORMFREQ);
ylabel(LABEL_SPECTRUM);
legend({'Stimulus spectrum','Sensitivity threshold'});