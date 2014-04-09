classdef ApiClient < handle
    %APICLIENT Summary of this class goes here
    %   Detailed explanation goes here    
    
    properties (GetAccess=private)
        client   % mForex.API.Matlab.MatlabClient
    end
                
    % Class methods
    methods
        function obj = ApiClient()
            obj.client = mForex.API.Matlab.MatlabClient;
        end
        
        function Login(obj, login, password, serverType)
            if ~isa(serverType, 'mForex.API.ServerType')
                error('ServerType is not a mForex.Api.ServerType!');
            end   
            
            if ~isa(login, 'double')
                error('Login is not an integer!');
            end   
            
            if ~isa(password, 'char')
                error('Password in not a string!');
            end   
            
            obj.client.Login(login, password, serverType).ContinueWith(@(t) fprintf('"Login response [AF] : %d - %d"\n', Task.Response.Login, Task.Response.Result.LoggedIn));                  
            
        end 
        
        function Logout(obj)
           obj.Logout();
        end
    end
    
end