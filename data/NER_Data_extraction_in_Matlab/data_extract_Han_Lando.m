% extract the save and used for cebra
% Lando_CO_20170917_15S1_465trial>>>has one NaN trial due to NaN target angle
% No NaN for other 2 Lando and all 3 Han
% All 3 Lando and 3 Han don't have any zero-firing neurons
% Lando only has 4 directions(0/2/4/6) instead of normal 8 directions
% NeurIPS2024 @ 2024-04-29
clear; clc
load('Han_CO_20171207_72S1_245trial.mat')
export_file_name = 'Lando_20170917_neural_con_dis_index.mat';
%%% Parameters for the Gaussian Kernel
sd = 1.5 ; % bin size is 30ms, so the sd=1.5*30=45ms
kernel_size = 6 * sd;  % 6 times the sd, rounded to the nearest integer
%%%% Create the Gaussian Kernel
range = -(kernel_size-1)/2:(kernel_size-1)/2;
gaussian_kernel = exp(-range.^2 / (2 * sd^2));
gaussian_kernel = gaussian_kernel / sum(gaussian_kernel);  % Normalize the kernel

numTrials = numel(trial_data);  % Number of trials
t_dur = 35 ; % median bin between idx_endTime-idx_goCueTime
n_neuron_S1 = size(trial_data(1).LeftS1Area2_spikes,2); 
vel = {trial_data.vel};
idx_goCueTime = [trial_data.idx_goCueTime];
S1_spikes = {trial_data.LeftS1Area2_spikes};
tgtDir = [trial_data.tgtDir];
tgtDir = tgtDir/45;     % already provide angles from 0 to 315
neural_S1_3d = zeros(t_dur, numTrials, n_neuron_S1);
continuous_index_3d = zeros(t_dur, numTrials, 2); % 2=XY velocity
discrete_index_2d = zeros(t_dur, numTrials); % 1=angle
excluded_short_trial = 0;
excluded_index = [];
for t = 1 : numTrials
    t_spikes_S1_raw=S1_spikes{t};
    t_spikes_S1 = zeros(size(t_spikes_S1_raw));
    for i = 1:size(t_spikes_S1_raw, 2)  % Loop over each neuron
        t_spikes_S1(:, i) = conv(t_spikes_S1_raw(:, i), gaussian_kernel, 'same');
    end
    
    t_vel=vel{t};
    t_start = idx_goCueTime(t);
    t_end = t_start+t_dur-1;
    if t_end<=size(t_spikes_S1,1) 
        neural_S1_3d(:, t, :) = t_spikes_S1(t_start:t_end, :);
        continuous_index_3d(:, t, :) = t_vel(t_start:t_end, :);
        discrete_index_2d(:, t) = tgtDir(t)*ones(t_dur, 1);
        if isnan(tgtDir(t)) || isnan(sum(t_vel(:)))
            excluded_index=[excluded_index t];
            excluded_short_trial = excluded_short_trial + 1;
            disp(['Nan values pop-out=',num2str(t)])
        end    
    elseif t_end>size(t_spikes_S1,1)  
        excluded_index=[excluded_index t];
        excluded_short_trial = excluded_short_trial + 1;
        disp(['Long extraction trial=',num2str(t),' miss=',num2str(t_end-size(t_spikes_S1,1))])
    end    
end   
disp(['Dur=', num2str(t_dur), 'bin  excluded_short_trial=', num2str(excluded_short_trial), ...
    '  saved_trial=', num2str(numTrials-excluded_short_trial)])
%
discrete_index_2d(:, excluded_index)=[];
continuous_index_3d(:, excluded_index, :)=[];
neural_S1_3d(:, excluded_index, :)=[];

%%
saved_bin_num = t_dur*(numTrials-excluded_short_trial);
discrete_index = reshape(discrete_index_2d, saved_bin_num, 1);
continuous_index = reshape(continuous_index_3d, [saved_bin_num, 2]);
neural_S1 = reshape(neural_S1_3d, [saved_bin_num, n_neuron_S1]);
%%
figure;
plot(mean(neural_S1))
xlabel('neuron #')
ylabel('mean firing rate')
zero_firing = find(mean(neural_S1)<0.000001);
disp(['Zero firing neurons=',num2str(zero_firing)])
title(['Zero firing neurons=',num2str(numel(zero_firing))])
% save(export_file_name,'t_dur','neural_S1','continuous_index','discrete_index');



