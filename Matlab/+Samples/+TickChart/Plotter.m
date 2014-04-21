classdef Plotter < handle
    %PLOTTER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (GetAccess = private)
        lineBid
        lineAsk
        lineTime
        hPlot
        lag
    end
    
    methods
        function obj = Plotter(lag)
            obj.lag = lag;
            obj.lineBid = [zeros(1,obj.lag)];
            obj.lineAsk = [zeros(1,obj.lag)];
            obj.hPlot = plot([obj.lineAsk;obj.lineBid]');
            xlabel('Tick number');       %  add axis labels and plot title
            ylabel('Price');
            title('Tick plot');
            legend('Bid','Ask');            
        end
                
        function Refresh(obj, src, eventData)
            ticks = eventData.Ticks;       
            for i=1:ticks.Length                
                t = ticks(i);                
                obj.lineBid = [obj.lineBid(2:obj.lag) t.Bid];
                obj.lineAsk = [obj.lineAsk(2:obj.lag) t.Ask];       
                
                % create new data
                newYdata = [obj.lineBid; obj.lineAsk]';
                newYcell = mat2cell(newYdata,obj.lag,ones(1,2));
                % update chart
                set(obj.hPlot,{'YData'},newYcell(:));            
            end   
        end 
    end
    
end

