clear variables;
close all;
clc;

load("Results/mean_results_table1.mat")

sf_max = max(sf_vec);
tf_max = max(tf_vec);
m_max = max(m_vec);
X = createArgMatrix(sf_vec / sf_max, tf_vec / tf_max, m_vec/ m_max);
lambda = 0.001;
L = eye(size(X,2))* lambda;
L(1) = 0;
theta_log = pinv(X'* X + L) * X' * mean_r_log;

fprintf("%.5f, ", theta_log)