classdef MarginLevel < event.EventData
    %   Class object used to store informaction about margin level
    %   Detailed explanation goes here
    
    properties
        Margin       % mForex.API.MarginLevel[] 
    end
    
    methods
        function obj = MarginLevel(ml)
            obj.Margin = ml;
        end
    end
    
end

