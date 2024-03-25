clear variables;
close all;

FONT_SIZE = 14;
LABEL_TEMP = 'Temporal Frequency (Hz)';
LABEL_SPATIAL = 'Spatial Frequency (cycles/degree)';
Y_LABEL = 'Contrast Threshold, log(s)';

load("Results/mean_and_std_fig8.mat")

surf(mean_x, mean_y, mean_z);
hold on;
quiver3(std_x, std_y, std_z, std_u, std_v, std_w,'ShowArrowHead','off','AutoScale','off', Color=[0 0 0])
hold off;
set(gca,'FontSize', FONT_SIZE);
xlabel(LABEL_SPATIAL, Position=[0.787845091225336,-116.390349955358,-3.296301053840679], Rotation=16);
ylabel(LABEL_TEMP, Position=[-35.9417723547333,1.926110922446242,-3.273551097084557], Rotation=-27);
zlabel(Y_LABEL, Position=[-35.63231495432023,114.4061437455402,-1.499998932588539]);
zlim([-3, 0])
