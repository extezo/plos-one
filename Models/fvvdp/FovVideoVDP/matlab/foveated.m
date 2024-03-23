close all;
clear variables;

WIDTH = 7680;
HEIGHT = 3840;
folder = fullfile('Z:\Учёба\LIVE-FBT-FCVR\2D');

REFERENCE_NAME='Coco_2d_0.yuv';
DISTORTED_NAME='Coco_2d_51.yuv';
Nframes = 300;
fid = fullfile(folder, DISTORTED_NAME);
fid_r = fullfile(folder, REFERENCE_NAME);
FVVDP = zeros(Nframes, 1, 'double');

gpuDevice([]);

for idx = 1:Nframes
    t = tic;
    fprintf("Frame: %d \n", idx);
    [yr, ur, vr] = yuvReadFrame(fid_r, WIDTH, HEIGHT, idx);
    [y, u, v] = yuvReadFrame(fid, WIDTH, HEIGHT, idx);
    [FVVDP(idx), ~] = fvvdp(yuv2rgb(y, u, v), yuv2rgb(yr, ur, vr), 'display_name', 'oculus_quest_2', 'foveated', true);
    toc(t)
end 
fprintf("Elapsed time: %f\n", t);
save(strcat('C:\Users\vowma\OneDrive\Универ\Научка\Статья Австралия\PSNR-M\LIVE_NFLX_PublicData_Release\roi_results\', NAME, '_fvvdp.mat'), 'FVVDP');

