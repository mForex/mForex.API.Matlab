classdef ApiClient < handle
    %APICLIENT Summary of this class goes here
    %   Detailed explanation goes here    
    
    properties (GetAccess=private)
        apiConnection   % mForex.API.ApiConnection
    end
    
    properties (SetAccess=private)
        ServerType      % Type of srver apiClient is connecting to  
    end 
    
    properties
        Login           % Login used for authentication  
    end
    
    properties (GetAccess=private)            
        LoggedIn        % Aauthentication status
    end
    
    % Class methods
    methods
        function obj = ApiClient(serverType)
            if ~isa(serverType, 'mForex.API.ServerType')
                error('Not a mForex.Api.ServerType!');
            end                    
            obj.ServerType = serverType
            apiConnection = mForex.API.APIConnection(serverType);
        end
        
        function Connect()
            
        end 
        
        function Disconnect()
           apiConnection.Disconnect() 
        end
    end
    
end

