classdef Disconnected < event.EventData
    %   Class object used to store informaction about disconnection
    %   Detailed explanation goes here
    
    properties
        Exception    % System.Exception
    end
    
    methods
        function obj = Disconnected(exc)
            obj.Exception = exc;
        end
    end
    
end

