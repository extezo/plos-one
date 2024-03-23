close all;
clear variables;
addpath(genpath('..'));

WIDTH = 1920;
HEIGHT = 1080;
folder = fullfile('Z:\Study\NFLX\');

for C = 4:6
    REFERENCE_NAME=strcat('VideoEncodes\ref_yuv\cont_', num2str(C), '.yuv');
    for S = [0 3:7]
        DISTORTED_NAME=strcat('VideoEncodes\dis_yuv\cont_', num2str(C), '_seq_', num2str(S), '.yuv');
        DATA_NAME=strcat('LIVE_NFLX_PublicData_Release\content_', num2str(C), '_seq_', num2str(S),  '.mat');

        load(fullfile(folder, DATA_NAME), 'PSNR_vec')
        Nframes = numel(PSNR_vec);
        fid = fopen(fullfile(folder, DISTORTED_NAME), 'r');
        fid_r = fopen(fullfile(folder, REFERENCE_NAME), 'r');
        FVVDP = zeros(Nframes, 1, 'double');
        t = tic;
        for idx = 1:Nframes
            fprintf("Content %d, Sequence: %d, Frame:%u (%u%%)\n", C, S,...
                idx, floor(idx / Nframes * 100));
            [y, u, v] = yuvRead(fid, WIDTH, HEIGHT);
            [yr, ur, vr] = yuvRead(fid_r, WIDTH, HEIGHT);
            [FVVDP(idx), ~] = fvvdp(yuv2rgb(y, u, v), yuv2rgb(yr, ur, vr), 'display_name', 'standard_fhd', 'options', {'use_gpu', false}, 'quiet', true);
        end 
        t = toc(t);
        fprintf("Content %d, Sequence: %d, Elapsed time: %f\n", C, S, t);
        save(strcat('C:\Users\vowma\YandexDisk\Универ\Научка\Статьи\Статья FRUCT (Фильтр)\VQA\!results\NFLX-I\FovVideoVDP\cont_', num2str(C), '_seq_', num2str(S), '_fvvdp.mat'), 'FVVDP'); 
    end
end
