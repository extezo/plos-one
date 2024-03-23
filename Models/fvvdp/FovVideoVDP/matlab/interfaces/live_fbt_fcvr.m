close all;
clear variables;

addpath(genpath('..'));


VIDEO_FOLDER='C:\LIVE-FBT-FCVR';
CURRENT_VIDEO_FOLDER='2D';

NAME = 'Coco_2d';
REFERENCE_NAME=strcat(NAME, '_0.yuv');
DISTORTED_NAME=strcat(NAME, '_51.yuv');

DATA_NAME='video_info_2D.mat';
MOS_NAME='MOS_2D.mat';

folder = fullfile(VIDEO_FOLDER, CURRENT_VIDEO_FOLDER);
load(fullfile(VIDEO_FOLDER, DATA_NAME))

vid_fps = 30;
Nframes = 300;
WIDTH = Width;
HEIGHT = Height;

fid_r = fopen(fullfile(folder, REFERENCE_NAME), 'r');
fid = fopen(fullfile(folder, DISTORTED_NAME), 'r');

%--------
FVVDP = zeros(1, Nframes);
for idx = 1:Nframes
    time = tic;
    [y, u, v] = yuvReadFrame(fid, WIDTH, HEIGHT, idx, false);
    rgb = uint8(yuv2rgb(y, u, v));
    [yr, ur, vr] = yuvReadFrame(fid_r, WIDTH, HEIGHT, idx, false);
    rgb_r = uint8(yuv2rgb(yr, ur, vr));
    [FVVDP(idx), ~] = fvvdp(rgb, rgb_r, 'display_name', 'oculus_quest_2', 'foveated', true, 'quiet', true);
    fprintf('Frame:%u (%u%%), Elapsed Time(s): %f, FVVDP=%f\n', ...
        idx, floor(idx * 100 / Nframes), toc(time), FVVDP(idx));
end
save(strcat('..\..\..\!results\LIVE-FBT-FCVR\FVVDP\', DISTORTED_NAME, '_fvvdp.mat'), 'FVVDP'); 
%--------