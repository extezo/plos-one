close all;
clear variables;

WIDTH = 1920;
HEIGHT = 1080;
folder = fullfile('C:\NFLX-II\');

for N = 1:15
    NAME=string(N);
    REFERENCE_NAME=strcat('VideoEncodes\ref_yuv\', NAME, '.yuv');
    DISTORTED_NAME=strcat('VideoEncodes\dis_mp4\', NAME, '.mp4');
    DATA_NAME=strcat('Dataset_Information\Mat_Files\', NAME, '.mat');

    load(fullfile(folder, DATA_NAME), 'N_total_frames', 'frame_rate');
    Nframes = N_total_frames;
    fid = VideoReader(fullfile(folder, DISTORTED_NAME));
    fid_r = fopen(fullfile(folder, REFERENCE_NAME), 'r');
    FVVDP = zeros(Nframes, 1, 'double');
    t = tic;
    for idx = 1:Nframes
        fprintf("Sequence: %d, Frame: %d \n", N, idx);
        [yr, ur, vr] = yuvRead(fid_r, WIDTH, HEIGHT);
        [FVVDP(idx), ~] = fvvdp(readFrame(fid), yuv2rgb(yr, ur, vr), 'display_name', 'standard_fhd');
    end 
    t = toc(t);
    fprintf("Sequence: %d, Elapsed time: %f\n", N, t);
    save(strcat('C:\Users\vowma\OneDrive\Универ\Научка\Статья Австралия\PSNR-M\LIVE_NFLX_PublicData_Release\roi_results\', NAME, '_fvvdp.mat'), 'FVVDP');
end
