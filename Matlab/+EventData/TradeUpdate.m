classdef TradeUpdate < event.EventData
    % Class object used to store informaction about new ticks
    % Detailed explanation goes here
    
    properties
        Action            % mForex.API.TradeAction
        TradeRecord       % mForex.API.TradeRecord
    end
    
    methods
        function obj = TradeUpdate(action, trade)
            obj.Action = action;
            obj.TradeRecord = trade;
        end
    end
    
end

