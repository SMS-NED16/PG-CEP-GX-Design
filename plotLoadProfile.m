function plotLoadProfile(timestamps, kWs, profile_name, saveFig)
    figure();
    
    % Programmatically display full screen image
    set(gcf, 'Position', get(0, 'ScreenSize'));
    
    % Area under load profile coloured - helps visualize LF/PF
    area(kWs, 'FaceAlpha', 0.3);
    
    % Annotate the plot
    ylabel('Load (kW)'); xlabel('Time (HH)');
    title(sprintf('Load Profile - %s', profile_name)); 
    grid();
    
    % XTickLabels
    xticks_time = timestamps.Hour;
    xticks_time(isnan(xticks_time)) = 24;
    set(gca, 'XTick', 1:1:24);
    set(gca, 'XTickLabels', xticks_time);
    
    if (saveFig)
        figure_file_name = sprintf('./images/load_profiles/%s.png', profile_name);
        saveas(gcf, figure_file_name);
    end
end