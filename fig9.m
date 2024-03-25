
clear;
close all;
addpath(genpath("."))
figure(Position=[50, 50, 2000, 500])
%%
t_freq = linspace( 0.05, 75, 40 );
s_freq = linspace( 0, 50, 40 );
[s, t] = meshgrid([flip(-s_freq) s_freq], ...
                           [flip(-t_freq) t_freq]);
lum = abs(s)+0.667*abs(t);
sizeLum = size(lum);
lum((s/6).^4+(0.667*t/6).^4 < 2.3) = NaN;

lum = 10.^((lum-20)/50*6);
inds = (s+50).^1.3+(0.667*t+50).^1.3 < 160;
inds = inds | rot90(inds) | rot90(inds, 2) | rot90(inds, 3);

lum(inds) = NaN;
lum(abs(t) > 64) = NaN;
lum(lum < 0.1) = NaN;

lum = reshape(lum, sizeLum);
F = scatteredInterpolant(s(:), t(:), lum(:));
subplot(1, 4, 1);
p = mesh(s, t, lum);
set(p, "FaceColor", "White")
set(p, "EdgeColor", "Blue")
set(p, "EdgeAlpha", 0.3)
set(gca, "View", [-45, 30])
set( gca, 'ZScale', 'log' );
xlim([-50, 50])
ylim([-75, 75])
zlim( [0.001 1000] );
zticklabels(["0.001", "0.01", "0.1", "1", "10", "100", "1000"])
zticks([0.001, 0.01, 0.1, 1, 10, 100, 1000])
xticks([-50, -25, 0, 25, 50])
xlabel('Spatial frequency [cpd]', 'FontSize', 11, ...
    'HorizontalAlignment','center',...
    'FontName','Times New Roman',...
    'Rotation',27,...
    'VerticalAlignment','middle', Position=[-5,-80,200]);
ylabel('Temporal frequency [Hz]', 'FontSize', 11, ...
    'HorizontalAlignment','right',...
    'FontName','Times New Roman',...
    'Rotation',-27,...
    'VerticalAlignment','middle', Position=[-42,-58, 687]);
zlabel('Sensitivity','FontName','Times New Roman', 'FontSize', 11, ...
    'VerticalAlignment','middle', Position=[-89,4,0.0053]);
title({'Pyramid of Visibility';'2016'});
set(gca, 'Zdir', 'reverse')
axis square
%%

csf_model = CSF_st_fov();
% 3D plot - as the function of spatial and temporal frequency

t_freq = linspace( 0.05, 64, 40 );
s_freq = linspace( 0, 50, 40 );
lum = logspace(log10(0.001), log10(1000), 60 );

[ss, tt, ll] = meshgrid(s_freq, t_freq, lum);


S = csf_model.sensitivity( ss(:), tt(:), ll(:), 0, 1, 0.4058 );        
S = reshape( S, size(ss) );
S = repmat(S, [2, 2, 1]);
S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)) = ...
    flip(S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)), 1);
S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)) = ...
    flip(S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)), 2);
S(size(S, 1)/2+1:size(S, 1), 1:size(S, 2)/2, 1:size(S, 3)) = ...
    flip(S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)), 1);
S(1:size(S, 1)/2, size(S, 2)/2+1:size(S, 1), 1:size(S, 3)) = ...
    flip(S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)), 2);

[sss, ttt, lll] = meshgrid([flip(-s_freq) s_freq], ...
                           [flip(-t_freq) t_freq], ...
                           lum);

IS = isosurface(sss, ttt, lll, S, 1, 'noshare');
[sss_, ttt_] = meshgrid([flip(-s_freq) s_freq], ...
                           [flip(-t_freq) t_freq]);
F = TriScatteredInterp(IS.vertices(:, 1),IS.vertices(:, 2),IS.vertices(:, 3));
subplot(1, 4, 2);
p = mesh(sss_, ttt_, F(sss_, ttt_));

set(p, "FaceColor", "White")
set(p, "EdgeColor", "Blue")
set(p, "EdgeAlpha", 0.2)

set(gca, "View", [-45, 30])
set( gca, 'ZScale', 'log' );
xlim([-50, 50])
ylim([-75, 75])
zlim( [0.001 1000] );
zticklabels(["0.001", "0.01", "0.1", "1", "10", "100", "1000"])
zticks([0.001, 0.01, 0.1, 1, 10, 100, 1000])
xticks([-50, -25, 0, 25, 50])
xlabel('Spatial frequency [cpd]', 'FontSize', 11, ...
    'HorizontalAlignment','center',...
    'FontName','Times New Roman',...
    'Rotation',27,...
    'VerticalAlignment','middle', Position=[-5,-80,200]);
ylabel('Temporal frequency [Hz]', 'FontSize', 11, ...
    'HorizontalAlignment','right',...
    'FontName','Times New Roman',...
    'Rotation',-27,...
    'VerticalAlignment','middle', Position=[-42,-58, 687]);
zlabel('Sensitivity','FontName','Times New Roman', 'FontSize', 11, ...
    'VerticalAlignment','middle', Position=[-89,4,0.0053]);
title({'FovVideoVDP'; '2021'});
set(gca, 'Zdir', 'reverse')
axis square

%%
csf_model = CSF_stelaCSF();

t_freq = linspace( 0.05, 60, 40 );
s_freq = linspace( 1/16, 50, 40 );
lum = logspace(log10(0.001), log10(10000), 60 );
[ss, tt, ll] = meshgrid(s_freq, t_freq, lum);

csf_pars = struct( 's_frequency', ss(:), 't_frequency', tt(:), ...
    'luminance', ll(:), 'orientation', 0, ...
    'area', 1, 'eccentricity', 0 );          
S = csf_model.sensitivity( csf_pars );
S = log10(S);
S = reshape( S, size(ss) );
S = repmat(S, [2, 2, 1]);
S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)) = ...
    flip(S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)), 1);
S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)) = ...
    flip(S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)), 2);
S(size(S, 1)/2+1:size(S, 1), 1:size(S, 2)/2, 1:size(S, 3)) = ...
    flip(S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)), 1);
S(1:size(S, 1)/2, size(S, 2)/2+1:size(S, 1), 1:size(S, 3)) = ...
    flip(S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)), 2);

[sss, ttt, lll] = meshgrid([flip(-s_freq) s_freq], ...
                           [flip(-t_freq) t_freq], ...
                           lum);

[sss_, ttt_] = meshgrid([flip(-s_freq) s_freq], ...
                           [flip(-t_freq) t_freq]);

inds = (sss_+50).^1.5+(ttt_+70).^1.5 < 320;
inds = inds | flip(inds, 2) | flip(inds, 1) | flip(flip(inds, 1), 2);

sss_(inds) = NaN;
ttt_(inds) = NaN;
IS = isosurface(sss, ttt, lll, S, 0);
F = TriScatteredInterp(IS.vertices(:, 1),IS.vertices(:, 2),IS.vertices(:, 3));
subplot(1, 4, 3);



S = F(sss_, ttt_);
inds = abs(ttt_.^3.5)+abs(sss_).^2.5<90;
S(inds) = NaN;
p = mesh(sss_, ttt_, S);


set(p, "FaceColor", "White")
set(p, "EdgeColor", "Blue")
set(p, "EdgeAlpha", 0.3)

set(gca, "View", [-45, 30])
set( gca, 'ZScale', 'log' );
xlim([-50, 50])
ylim([-75, 75])
zlim( [0.001 1000] );
zticklabels(["0.001", "0.01", "0.1", "1", "10", "100", "1000"])
zticks([0.001, 0.01, 0.1, 1, 10, 100, 1000])
xticks([-50, -25, 0, 25, 50])
xlabel('Spatial frequency [cpd]', 'FontSize', 11, ...
    'HorizontalAlignment','center',...
    'FontName','Times New Roman',...
    'Rotation',27,...
    'VerticalAlignment','middle', Position=[-5,-80,200]);
ylabel('Temporal frequency [Hz]', 'FontSize', 11, ...
    'HorizontalAlignment','right',...
    'FontName','Times New Roman',...
    'Rotation',-27,...
    'VerticalAlignment','middle', Position=[-42,-58, 687]);
zlabel('Sensitivity','FontName','Times New Roman', 'FontSize', 11, ...
    'VerticalAlignment','middle', Position=[-89,4,0.0053]);
title({'stelaCSF';'2022'});
set(gca, 'Zdir', 'reverse')
axis square

%%
log = false;
load("expRes.mat")

mag_x = [0, 50, 100, 150, 200, 250];
y = [0, 2, 6.5, 14.4, 35, 67];
magicPlt = @(x) interp1(mag_x, y, x, "linear");

diap = (0.00:0.03:1);
lum = [40 80 120 160 200];
lum = lum ./ max(lum);



[X, Y, Z] = meshgrid(diap, diap,lum);
X = createArgMatrix(X(:), Y(:), flip(Z(:)));
y_vec = X * theta;
y = reshape(y_vec, numel(diap), numel(diap), numel(lum));
y_vec_log = X * theta_log;
y_log = reshape(y_vec_log, numel(diap), numel(diap), numel(lum));

s_freq_full = [-diap(end:-1:1) diap] * sf_max;
t_freq_full = [-diap(end:-1:1) diap] * tf_max;
lum_full = lum * m_max;
[sf, tf, lf] = meshgrid(s_freq_full, t_freq_full, lum_full);
if log
    S = y_log;
else
    S = y;
end
S = repmat(S, [2, 2, 1]);
S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)) = ...
    flip(S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)), 1);
S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)) = ...
    flip(S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)), 2);
S(size(S, 1)/2+1:size(S, 1), 1:size(S, 2)/2, 1:size(S, 3)) = ...
    flip(S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)), 1);
S(1:size(S, 1)/2, size(S, 2)/2+1:size(S, 1), 1:size(S, 3)) = ...
    flip(S(1:size(S, 1)/2, 1:size(S, 2)/2, 1:size(S, 3)), 2);
subplot(1, 4, 4);
S = S(:, :, 3);
S = max(S, [], 'all') - S;
S = S - min(S, [], 'all');
S = S / max(S, [], 'all');
S = 10.^(6*S-3);
p = mesh(sf(:, :, 3), tf(:, :, 3), S);


set(p, "FaceColor", "White")
set(p, "EdgeColor", "Blue")
set(p, "EdgeAlpha", 0.3)
set(gca, "View", [-45, 30])
set( gca, 'ZScale', 'log' );
xlim([-50, 50])
zlim( [0.001 1000] );
zticklabels(["0.001", "0.01", "0.1", "1", "10", "100", "1000"])
zticks([0.001, 0.01, 0.1, 1, 10, 100, 1000])
xticks([-50, -25, 0, 25, 50])
xlabel('Spatial frequency [cpd]', 'FontSize', 11, ...
    'HorizontalAlignment','center',...
    'FontName','Times New Roman',...
    'Rotation',27,...
    'VerticalAlignment','middle', Position=[-10.228759362027873,-72.23529453488007,179.0609149743801]);
ylabel('Temporal frequency [Hz]', 'FontSize', 11, ...
    'HorizontalAlignment','right',...
    'FontName','Times New Roman',...
    'Rotation',-27,...
    'VerticalAlignment','middle', Position=[-42,-58, 687]);
zlabel('Sensitivity','FontName','Times New Roman', 'FontSize', 11, ...
    'VerticalAlignment','middle', Position=[-89,4,0.0053]);
title({'Visibility Model';'2023'});
set(gca, 'Zdir', 'reverse')
axis square