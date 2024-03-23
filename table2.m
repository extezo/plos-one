clear;
close all;
clc;

tabl = zeros(7, 9);

metrics = dir("Results\plcc\");
metrics = metrics(3:end);
for i = 1:length(metrics)
    datasets = dir("Results\plcc\"+metrics(i).name+"\");
    datasets = datasets(3:end);
    for j = 1:length(datasets)
        results_obj = dir("Results\plcc\"+metrics(i).name+"\"+datasets(j).name+"\");
        results_obj = results_obj(3:end);
        plcc_l_u = zeros(length(results_obj), 3);
        for k = 1:length(results_obj)
            load(results_obj(k).folder + "\" + results_obj(k).name, "R", "RU", "RL");
            plcc_l_u(k, :) = [RU(2) R(2) RL(2)]; 
        end
        if j == 2
            tabl(i, (j-1)*3+1:j*3) = mean(plcc_l_u);
        else
            tabl(i, (j-1)*3+1:j*3) = plcc_l_u;
        end
    end
end

tabl = tabl([4 7 5 6 3 1 2], :);
tabl = tabl(:, [4:6 7:9 1:3]);
datasets = datasets([2 3 1]);
metrics = metrics([4 7 5 6 3 1 2]);

fprintf("%30s | ", "Metric")
fprintf("%20s  | ", datasets.name); fprintf("\n"); 
fprintf("%30s | ", " ")
fprintf("%5s | ", repmat(["Upper", "PLCC", "Lower"], [1 3])); fprintf("\n");
% tabl(isnan(tabl))=0;
for i = 1:length(metrics)
    fprintf("%30s |", metrics(i).name)
    for j = 1:3*length(datasets)
        if tabl(i, j) >= 0
            fprintf(" %.3f |", tabl(i, j))
        else
            fprintf("%.3f |", tabl(i, j))
        end
    end
    fprintf("\n")
end