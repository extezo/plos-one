close all;
clear variables;

addpath(genpath('..'));

width = 1920;
height = 1080;
VIDEO_FOLDER='Z:\Учёба\MCL-V\';

load(fullfile(VIDEO_FOLDER, 'opinion_scores\mean_opinion_score.mat'))
NAMES = mean_point_score(:,1);
fps = [25, 30, 30, 25, 25, 30, 30, 22, 25, 25, 25, 20];

for v = 2:numel(NAMES)
    if mod(v - 1, 8) > 1
		continue
    end
    REF_NAME = split(NAMES{v}, '_');
    REF_NAME = REF_NAME{1};
    REF_NAME = sprintf('%s_%dfps', REF_NAME, fps(ceil(v/8)));
    REFERENCE_NAME=strcat('reference_YUV_sequences\', REF_NAME, '.yuv');
    DIS_NAME = split(NAMES{v}, '.');
    DIS_NAME = DIS_NAME{1};
    DISTORTED_NAME=strcat('distorted_YUV_sequences\', DIS_NAME, '.yuv');


    vid_fps = fps(ceil(v/8));
    Nframes = vid_fps * 6;

    fid = fullfile(VIDEO_FOLDER, DISTORTED_NAME);
    fid_r = fullfile(VIDEO_FOLDER, REFERENCE_NAME);
    FVVDP = zeros(Nframes, 1, 'double');
    t = tic;
    for idx = 1:Nframes
        fprintf("Sequence: %d, Frame: %d \n", v, idx);
        [y, u, vv] = yuvReadFrame(fid, width, height, idx);
        [yr, ur, vr] = yuvReadFrame(fid_r, width, height, idx);
        [FVVDP(idx), ~] = fvvdp(yuv2rgb(y, u, vv), yuv2rgb(yr, ur, vr), 'display_name', 'standard_fhd', 'quiet', true);
    end 
    t = toc(t);
    fprintf("Sequence: %d, Elapsed time: %f\n", v, t);
    save(strcat(DIS_NAME, '_fvvdp.mat'), 'FVVDP');
end
