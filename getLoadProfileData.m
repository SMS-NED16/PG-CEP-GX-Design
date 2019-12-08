function [timestamps, kWs] = getLoadProfileData(file_name, resComStr, ...
    start_idx, end_idx, roundTo)   
    % Define filepath using name and resComStr for folder
    filepath = strcat('./load_profiles_', resComStr, '_SF_CA/', ...
        file_name, '.csv');

    % Read raw data from specified filepath - readtable faster than xlsread
    raw_data = readtable(filepath);
    
    % Drop all cols except timestamp and kWs for specified rows
    % 1 + necessary because we don't want to read the column names
    load_profile_table = raw_data(1 + start_idx : end_idx, 1:2);    
    
    % Convert data from named table strs to numerical matrices
    timestamps = table2array(load_profile_table(:, 1));
    kWs = table2array(load_profile_table(:, 2));
    
    % Preprocessing timestamp strs into a specific format of datetime strs
    timestamps = datetime(timestamps, 'InputFormat','MM/dd HH:mm:ss', 'Format', ...
        'HH:mm:ss');
    
    % Deal with bug that doesn't read 24:00:00 as a date
    idx_NaT = find(isnat(timestamps));
    [year, month, day] = ymd(timestamps(idx_NaT));
    new_str = datetime(year, month, day, 0, 0, 0);
    timestamps(idx_NaT) = new_str;

    % Round kWs to specified denomination
    kWs = round(kWs * roundTo)/roundTo;
    
    % Drop all unnecessary data
    clear raw_data load_profile_table;
end