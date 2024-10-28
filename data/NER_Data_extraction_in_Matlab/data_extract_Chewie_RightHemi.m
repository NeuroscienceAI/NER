% extract the save and used for cebra
% NeurIPS2024 @ 2024-04-28
clear; clc
load('Chewie_CO_20150630_44M1_178trial.mat')
export_file_name = 'Chewie_20150630_neural_con_dis_index.mat';
%%% Parameters for the Gaussian Kernel
sd = 1.5 ; % bin size is 30ms, so the sd=1.5*30=45ms
kernel_size = 6 * sd;  % 6 times the sd, rounded to the nearest integer
% kernel_size = kernel_size + 1;  % Ensure kernel size is odd
%%%% Create the Gaussian Kernel
range = -(kernel_size-1)/2:(kernel_size-1)/2;
gaussian_kernel = exp(-range.^2 / (2 * sd^2));
gaussian_kernel = gaussian_kernel / sum(gaussian_kernel);  % Normalize the kernel

numTrials = numel(trial_data);  % Number of trials
t_dur = 40 ; % median bin between idx_endTime-idx_goCueTime
n_neuron_M1 = size(trial_data(1).M1_spikes,2); 
vel = {trial_data.vel};
idx_goCueTime = [trial_data.idx_goCueTime];
M1_spikes = {trial_data.M1_spikes};
tgtDir = [trial_data.tgtDir];
tgtDir = round(rad2deg(tgtDir));     % direction in angles
neural_M1_3d = zeros(t_dur, numTrials, n_neuron_M1);
continuous_index_3d = zeros(t_dur, numTrials, 2); % 2=XY velocity
discrete_index_2d = zeros(t_dur, numTrials); % 1=angle
excluded_short_trial = 0;
excluded_index = [];
for t = 1 : numTrials
    t_spikes_M1_raw=M1_spikes{t};
    t_spikes_M1 = zeros(size(t_spikes_M1_raw));
    for i = 1:size(t_spikes_M1_raw, 2)  % Loop over each neuron
        t_spikes_M1(:, i) = conv(t_spikes_M1_raw(:, i), gaussian_kernel, 'same');
    end
    
    t_vel=vel{t};
    t_start = idx_goCueTime(t);
    t_end = t_start+t_dur-1;
    if t_end<=size(t_spikes_M1,1) 
        neural_M1_3d(:, t, :) = t_spikes_M1(t_start:t_end, :);
        
        continuous_index_3d(:, t, :) = t_vel(t_start:t_end, :);
        discrete_index_2d(:, t) = tgtDir(t)*ones(t_dur, 1);
    elseif t_end>size(t_spikes_M1,1)  
        excluded_index=[excluded_index t];
        excluded_short_trial = excluded_short_trial + 1;
        disp('Long extraction')
    end    
end    
disp(['Dur=', num2str(t_dur), 'bin  excluded_short_trial=', num2str(excluded_short_trial), ...
    '  saved_trial=', num2str(numTrials-excluded_short_trial)])

discrete_index_2d(:, excluded_index)=[];
continuous_index_3d(:, excluded_index, :)=[];
neural_M1_3d(:, excluded_index, :)=[];
%%
saved_bin_num = t_dur*(numTrials-excluded_short_trial);
discrete_index = reshape(discrete_index_2d, saved_bin_num, 1);
continuous_index = reshape(continuous_index_3d, [saved_bin_num, 2]);
neural_M1 = reshape(neural_M1_3d, [saved_bin_num, n_neuron_M1]);
%
save(export_file_name,'neural_M1','continuous_index','discrete_index');



