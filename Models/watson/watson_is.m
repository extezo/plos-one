clear;
t_freq = linspace( 0.05, 75, 50 );
s_freq = linspace( 0, 50, 50 );
lum = logspace(log10(0.001), log10(1000), 50 );
[s, t] = meshgrid([flip(-s_freq) s_freq], ...
                           [flip(-t_freq) t_freq]);
lum = 10.^(((abs(s)+0.667*abs(t))-30)/50*6);
sizeLum = size(lum);
lum(abs(t) > 64) = NaN;
lum(lum < 0.1) = NaN;
lum = reshape(lum, sizeLum);
% F = scatteredInterpolant(s(:), t(:), lum(:));
p = mesh(s, t, lum);
set(p, "FaceColor", "White")
set(p, "EdgeColor", "Blue")
set(p, "EdgeAlpha", 0.3)
set(gca, "View", [-30, 30])
set( gca, 'ZScale', 'log' );
xlim([-50, 50])
ylim([-75, 75])
% zlim( [0.001 1000] );
zticklabels(["0.001", "0.01", "0.1", "1", "10", "100", "1000"])
zticks([0.001, 0.01, 0.1, 1, 10, 100, 1000])
xlabel( 'Spatial frequency [cpd]','VerticalAlignment','bottom',...
    'HorizontalAlignment','center',...
    'Rotation',15, Position=[10,-89.1782,325340])
ylabel( 'Temporal frequency [Hz]','VerticalAlignment','bottom',...
    'HorizontalAlignment','right',...
    'Rotation',-45, Position=[-55.5,-40,4435435])
zlabel( 'Sensitivity', VerticalAlignment='top')
title( 'stelaCSF');
set(gca, 'Zdir', 'reverse')
axis square