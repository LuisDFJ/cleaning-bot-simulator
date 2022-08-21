function [f] = create_figure( size )
    f = figure('Position',[100 100 size(1) size(2)],'Color','white');
    axes('Position',[0 0 1 1])
    xlim([1 size(1)]);
    ylim([1 size(2)]);
    axis off
end