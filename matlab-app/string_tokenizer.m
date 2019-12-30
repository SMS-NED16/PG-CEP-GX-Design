clear all; close all; clc;
data = readtable('./all-load-profiles.xlsx');
profile_names = data.Properties.VariableNames;
test_name = profile_names{3}
split_name = strsplit(test_name, '_');
joint_name = strjoin(split_name, ' ');
replaced_name = strrep(test_name, '_', ' ')

txt = importdata('./Descriptions/Househould_Electricity_Survey.txt');
fclose('all');

link = importdata('./Links/Househould_Electricity_Survey.txt');
fclose('all');
char(link)
web(char(link));