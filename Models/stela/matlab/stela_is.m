clear;
csf_model = CSF_stelaCSF();

% 3D plot - as the function of spatial and temporal frequency
figure(2)
clf;

t_freq = linspace( 0.05, 60, 50 );
s_freq = linspace( 1/16, 50, 50 );
lum = logspace(log10(0.001), log10(10000), 50 );
[ss, tt] = meshgrid(s_freq, t_freq);
lum = [40 80 120 160 200];
hold on;
for i = 1:5
    clf;
    csf_pars = struct( 's_frequency', ss(:), 't_frequency', tt(:), ...
        'luminance', lum(i), 'orientation', 0, ...
        'area', 1, 'eccentricity', 0 );          
    S = csf_model.sensitivity( csf_pars );
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
    
    p = mesh(sss_, ttt_, S);
    % p = patch(IS);
    axis square
    pause(1/2)
    
end
% set(p, "FaceColor", "White")
% set(p, "EdgeColor", "Blue")
% set(p, "EdgeAlpha", 0.3)

% set(gca, "View", [-30, 30])
% % set( gca, 'ZScale', 'log' );
% xlim([-50, 50])
% ylim([-75, 75])
% % zlim( [0.001 1000] );
% zticklabels(["0.001", "0.01", "0.1", "1", "10", "100", "1000"])
% zticks([0.001, 0.01, 0.1, 1, 10, 100, 1000])
% xlabel( 'Spatial frequency [cpd]','VerticalAlignment','bottom',...
%     'HorizontalAlignment','center',...
%     'Rotation',15, Position=[10,-89.1782,325340])
% ylabel( 'Temporal frequency [Hz]','VerticalAlignment','bottom',...
%     'HorizontalAlignment','right',...
%     'Rotation',-45, Position=[-55.5,-40,4435435])
% zlabel( 'Sensitivity', VerticalAlignment='top')
% title( 'stelaCSF');
% % set(gca, 'Zdir', 'reverse')
% axis square