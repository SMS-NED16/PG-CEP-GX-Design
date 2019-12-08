clear all; close all; clc;
max_kw = [];
file_names = {'hospital', 'large-hotel', ...
    'large-office', 'primary-school', 'midrise-apartment', 'warehouse',...
    'supermarket', 'quick-service-restaurant', 'outpatient-department',...
    'strip-mall', 'secondary-school', 'retail-standalone', 'full-service-restaurant'};

for i = 1:length(file_names)
    [timestamps, kWs] = getLoadProfileData(file_names{i}, 'comm', 50, 74, 5);
    plotLoadProfile(timestamps, kWs, file_names{i}, true);
    max_kw = [max_kw, max(kWs)];
end

figure();
bar(max_kw);
set(gca, 'XTickLabel', file_names);
set(gca, 'XTickLabelRotation', 45);