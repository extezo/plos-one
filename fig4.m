clear;
close all;
FONT_SIZE = 14;
LABEL_PIXVAL = 'Brightness Value';
LABEL_LUMINOUS = 'Luminous Flux (mlm)';
LABEL_LUMINANCE = 'Luminance (cd/m^2)';

Lg = [0 128 255];
Em = [0 10 68];

plot(0:255, interp1(Lg, Em,0:255, 'PCHIP'), 'LineWidth', 2);
set(gca,'FontSize',FONT_SIZE);
xlim([0 255]);
ylim([0 100]);
grid on;
xlabel(LABEL_PIXVAL);
ylabel(LABEL_LUMINANCE);