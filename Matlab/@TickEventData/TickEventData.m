classdef TickEventData < event.EventData
    %TICKEVENTDATA Class object used to store informaction about new ticks
    %   Detailed explanation goes here
    
    properties
        Ticks       % mForex.API.Ticks[] 
    end
    
    methods
        function obj = TickEventData(ticks)
            obj.Ticks = ticks;
        end
    end
    
end

