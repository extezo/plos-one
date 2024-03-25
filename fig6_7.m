clear;
close all;

load("Results\fig6-7.mat")
labels = ["Pyramid of Visibility", "FovVideoVDP", "StelaCSF", "Visibility Model"];
colors = [255,174,81;
          255,77,178;
          180,29,226;
          0,0,0] ./ 255;

markers = ['+', 'x', '*', 'o'];

names = "5-"+[33, 11, 23, 12]+"_2.png";
yl = [-1 2.5; -2.5 3];
for idx = 2:3
figure(Position=[100, 100, 800, 800])
hold on;

for j = 1:4
    markerInds = zeros(size(real_dots_s(j, :)));
    for k = 1:length(markerInds)
        [~, markerInds(k)] = min(abs(real_dots_s(j, k) - s_freq_t));
    end
    markerInds(real_dots_s(j, :) > max(s_freq_t)) = 1;
    plot(s_freq_t, squeeze(S_t(j, idx, :)), Color=colors(j,:), ...
         Marker=markers(j), MarkerIndices=markerInds);
end
hold off;
titles = split(sprintf("f = %2.2f Hz,", t_freq_t), ",");
xlabel("Spatial Frequency (cycles/degree)")
ylabel("Contrast Threshold, log(s)")
title(sprintf("Temporal frequency f = %2.2f Hz", t_freq_t(idx)))
legend(labels)
grid(gca)
set(gca,'FontSize', 16);
set(gca,'FontName', "Times New Roman");
ylim(yl(1,:));
end
for idx = 2:3
figure(Position=[100, 100, 800, 800])
hold on;
for j = 1:4
    markerInds = zeros(size(real_dots_s(j, :)));
    for k = 1:length(markerInds)
        [~, markerInds(k)] = min(abs(real_dots_t(j, k) - t_freq_s));
    end
    markerInds(real_dots_t(j, :) > max(t_freq_s)) = 1;
    plot(t_freq_s, squeeze(S_s(j, :, idx)), Color=colors(j,:), ...
         Marker=markers(j), MarkerIndices=markerInds);
end
hold off;
xlabel("Temporal Frequency (Hz)")
ylabel("Contrast Threshold, log(s)")
title(sprintf("Spatial frequency k = %2.2f c/deg", s_freq_s(idx)))
legend(labels)
grid(gca)
set(gca,'FontSize', 16);
set(gca,'FontName', "Times New Roman");
ylim(yl(2,:));
xlim([0 66.6667]);
end