close all;
clear variables;

DATASET_FOLDER='C:\upiq_dataset\';
IMAGE_FOLDER='images';

addpath(genpath('..'));

folder = strcat(DATASET_FOLDER, IMAGE_FOLDER);

sets = dir(folder);

fvvdp_results = cell(808, 4);

idx = 1;

for i = 3:6
    dirs_in_set = dir(strcat(sets(i).folder,'\', sets(i).name));
    for j = 3:numel(dirs_in_set)
        images = dir(strcat(dirs_in_set(j).folder,'\', dirs_in_set(j).name));
        ref_name = images(3).name;
        
        
        if i == 3 || i == 5
            yr = imread(fullfile(images(3).folder, images(3).name))/256;
            yr = rgb2gray(yr);
        else
            yr = rgb2gray(imread(fullfile(images(3).folder, images(3).name)));
        end
        w = size(yr, 2);
        h = size(yr, 1);
        for k = 3:numel(images)
            t = tic;
            if i == 3 || i == 5
                y = imread(fullfile(images(k).folder, images(k).name))/256;
                y = rgb2gray(y);
            else
                y = rgb2gray(imread(fullfile(images(k).folder, images(k).name)));
            end
            %--------
            [FVVDP, ~] = fvvdp(y, yr, 'display_name', 'standard_fhd', 'quiet', true);
            %--------
            
            ref_name = images(3).folder;
            ref_name = ref_name((numel(folder)+2):end);
            ref_name = strcat(ref_name, '\', images(3).name);
            dis_name = images(k).folder;
            dis_name = dis_name((numel(folder)+2):end);
            dis_name = strcat(dis_name, '\', images(k).name);
            fprintf('Ref: %s, Dis: %s, Elapsed Time: %0.3f s, PSNR-M: %.3f\n',...
                ref_name,...
                dis_name,...
                toc(t), FVVDP);
            fvvdp_results(idx, :) = {ref_name, dis_name, toc(t), FVVDP};
            idx = idx + 1;
        end
    end
    save(sprintf('upiq_fvvdp_results_%s.mat', sets(i).name), 'fvvdp_results');
end
