%%  downsampleLoadProfiles.m - Saad Siddiqui, 15/12/2019
%   Uses 1-D interpolation to map variable-length arrays of digitzed
%   timestamps and kWs consumed to timestamps at 30 minute intervals
%   between 00:00 and 24:00

%%  Resetting workspace and environment
clear all; close all; clc;

%%  Creating linearly spaced timestamps to map values to 
t_start = duration(0, 0, 0);
t_end = duration(24, 0, 0);
timestamps = t_start : minutes(30) : t_end;
num_samples = length(timestamps);

%%  Loading Profiles 
filepath_dir = './load-profiles/original/';
file_prefix = 'profile';
extension = 'xlsx';
file_names = {};
profiles_to_read = 8;

%%  Generate file name, read data, downsample, and save plot
for i = 1:profiles_to_read
    %   Programmatically generate file path
    file_str = sprintf('%s%s-%d.%s', filepath_dir, file_prefix, i, extension);
    
    %   Read the data from the specified file into an array
    profile_i = xlsread(file_str);
    
    %   Downsample profile with interpolation
    original_samples = length(profile_i);
    profile_i = interp1(1:original_samples, profile_i, linspace(1, ...
        original_samples, num_samples));
    
    %   Generate plot with timestamps on the x-axis
    figure();
    plot(timestamps, profile_i(:, 2));
    grid(); xlabel('Time (\it{t/(HH:MM)})');
    ylabel('Load in kiloWatts(\it{P/kW})'); 
    title_str = sprintf('Load Profile No. %d - %s', i, 'Some Text');
    title(title_str);
    
    %   Write the load profile to Excel for easier reading in future
%     write_file_str = sprintf('load-profile-%d.xlsx', i);
%     xlswrite(write_file_str, profile_i(:, 2));
end