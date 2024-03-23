clear;
close all;
addpath(genpath("."))
labels = ["Pyramid of Visibility", "FovVideoVDP", "StelaCSF", "Visibility Model"];

t_freq_t = linspace(0, 66 + 2/3, 5);
s_freq_t = linspace(0, 15, 50);
t_freq_s = linspace(0, 66 + 2/3, 50);
s_freq_s = linspace(0, 15, 5);
lum = 120;

real_dots_t = [0 1 2 3 4 6 8 12 16 24 33 0;
               0.5 1 2 4 8 16 32 0 0 0 0 0;
               2^-4 2^-3 2^-2 0.5 1 1.3 2 2.8 4 8 16 32;
               66.6667 52.6316 47.6190 43.4783 40.0000 37.0370 33.3333 25.0000 20.0000 13.3333 4.0000 2.0000];
real_dots_s = [0 1 2 3 4 6 8 12 16 24 33 0;
               0.5 1 2 4 8 16 32 0 0 0 0 0;
               2^-4 2^-3 2^-2 0.5 1 1.3 2 2.8 4 8 16 32;
               15.0000 7.5000 3.7500 1.8750 0.9375 0.4688 0.2344 0 0 0 0 0];

[st, tt, llt] = meshgrid(s_freq_t, t_freq_t, lum);
[ss, ts, lls] = meshgrid(s_freq_s, t_freq_s, lum);

colors = [255,174,81;
          255,77,178;
          180,29,226;
          0,0,0] ./ 255;

% colors = rgb2gray(colors)

markers = ['+', 'x', '*', 'o'];

%% Watson Model
S_watson = @(s, t, l) 2 - 0.06 .* s - 0.05 .* t + 0.5 .* l;
%% FVVDP Model
S_fvvdp = @(s, t, l) CSF_st_fov().sensitivity( s(:), t(:), l(:), 0, 1, 0.4058 );
%% StelaCSF
S_stela = @(s, t, l) CSF_stelaCSF().sensitivity(struct(...
    's_frequency', s(:), ...
    't_frequency', t(:), ...
    'luminance', l(:), ...
    'orientation', 0, 'area', 1, 'eccentricity', 0));
%% Visibility Model
S_vismod = @(s, t, l) S_vismod_(s, t, l);
%%
S_t = zeros(4, 5, 50);
S_s = zeros(4, 50, 5);
S_t(1, :, :) = S_watson(st, tt, llt/90);
S_s(1, :, :) = S_watson(ss, ts, lls/90);
% do_plot("Watson", s_freq_t, t_freq_t, s_freq_s, t_freq_s, S_wt, S_ws);

S_t(2, :, :) = log10(reshape(S_fvvdp(st, tt, llt), size(st)));
S_s(2, :, :) = log10(reshape(S_fvvdp(ss, ts, lls), size(ss)));
% do_plot("FVVDP", s_freq_t, t_freq_t, s_freq_s, t_freq_s, S_ft, S_fs);

S_t(3, :, :) = log10(reshape(S_stela(st, tt, llt), size(st)));
S_s(3, :, :) = log10(reshape(S_stela(ss, ts, lls), size(ss)));
% do_plot("StelaCSF", s_freq_t, t_freq_t, s_freq_s, t_freq_s, S_st, S_ss);

S_t(4, :, :) = S_vismod(st, tt, llt);
S_s(4, :, :) = S_vismod(ss, ts, lls);

% do_plot("VisMod", s_freq_t, t_freq_t, s_freq_s, t_freq_s, S_vt, S_vs);

yl = [-1 2.5; -2.5 3];
c = [0 0; 0 0];


names = "5-"+[33, 11, 23, 12]+"_2.png";

for idx = 2:3
figure(Position=[100, 100, 800, 800])
hold on;
S_t(4, idx, :) = normalize(S_t(4, idx, :), "range", [-0.25, 1.4])+c(1, idx-1);
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
%saveas(gcf, "fig78/"+names(idx-1))
end
for idx = 2:3
figure(Position=[100, 100, 800, 800])
hold on;
S_s(4, :, idx) = normalize(S_s(4, :, idx), "range", [min(S_s(2, :, idx))-0.2, max(S_s(1, :, idx))])+c(2, idx-1);
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
%saveas(gcf, "fig78/"+names(idx+1))
end

function S = S_vismod_(s, t, l)
load("theta_log10.mat")
s = s ./ max(s, [], "all");
t = t ./ max(t, [], "all");
l = l ./ 255;
X = createArgMatrix(s(:), t(:), l(:));
S = reshape(X * theta_log10, size(s));
end