clear variables;
close all;

FONT_SIZE = 14;
LABEL_TEMP = 'Temporal Frequency (Hz)';
LABEL_SPATIAL = 'Spatial Frequency (cycles/degree)';
Y_LABEL = 'Contrast Threshold, log(s)';

load("Results/mean_results_fig8.mat")
LIGHT_IDX = 3;
k_tests = k_tests(:, :, :, LIGHT_IDX);
k_test_s = mean(k_tests, 3);
figure('name', 'Mean', Position=[100, 100, 600, 500]);
k = log10(k_test_s);
k = [k; k(end:-1:1,:)];
tf_test = [-tf_test; tf_test(end:-1:1,:)];
sf_test = [sf_test; sf_test(end:-1:1,:)];
k = [k k(:, end:-1:1)];
tf_test = [tf_test tf_test(:,end:-1:1)];
sf_test = [-sf_test sf_test(:,end:-1:1)];
surf(sf_test, tf_test, k);
set(gca,'FontSize', FONT_SIZE);
xlabel(LABEL_SPATIAL, Position=[0.787845091225336,-116.390349955358,-3.296301053840679], Rotation=16);
ylabel(LABEL_TEMP, Position=[-35.9417723547333,1.926110922446242,-3.273551097084557], Rotation=-27);
zlabel(Y_LABEL, Position=[-35.63231495432023,114.4061437455402,-1.499998932588539]);
zlim([-3, 0])
