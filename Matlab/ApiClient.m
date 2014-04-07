classdef apiClient
    %APICLIENT Summary of this class goes here
    %   Detailed explanation goes here    
    
    properties
        ServerType % Type of srver apiClient is connecting to  
        Login      % Login used for authentication  
    end
    
    properties (GetAccess=private)            
        LoggedIn   % Aauthentication status
    end
    
    methods
    end
    
end

