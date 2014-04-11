function PlotTicks(src,eventData)        
    if ~exist('plotData', 'var') && ~exist('hTickPlot', 'var')
        plotData = []
        hTickPlot = plot(plotData)
    end
    
    length(plotData)    
    if length(plotData) < 10
        plotData = [plotData t.Bid]
    else
        plotData = [plotData(2:(10)) t.Bid];  
    end
    set(hTickPlot,'YData',plotData);  %# Update the y data of the line
    drawnow                           %# Force the graphics to update immediately
    %plot(plotData);    
end