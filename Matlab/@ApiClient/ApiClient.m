classdef ApiClient < handle
    %APICLIENT Matlab client for mForex API
    %   Write moar stuff here    
    
    properties (GetAccess=private)
        client                  % mForex.API.Matlab.MatlabClient       
        tickListener            % listener for client's Tick event 
        marginListener          % listener for client's Margin event 
        disconnectionListener   % listener for client's Disconnected event 
        tradeListener           % listener for client's TradeUpdate event 
    end    
                    
    methods
        function obj = ApiClient()            
            obj.client = mForex.API.Matlab.MatlabClient;            
            obj.tickListener = addlistener(obj.client,'Ticks', @(src,evnt)TickEvHandler(obj, src, evnt)); 
            obj.marginListener = addlistener(obj.client, 'Margin', @(src, evnt)MarginLevelEvHandler(obj, src, evnt));
            obj.disconnectionListener = addlistener(obj.client, 'Disconnected', @(src, evnt)DisconnectedEvHandler(obj, src, evnt));
            obj.tradeListener = addlistener(obj.client, 'TradeUpdate', @(src, evnt)TradeUpdateEvHandler(obj, src, evnt));
        end     
        function delete(obj)
            delete(obj.tickListener);
            delete(obj.marginListener);
            delete(obj.disconnectionListener);
            delete(obj.tradeListener);
            obj.client.Dispose();
            delete(obj.client);                        
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
            
            try
                Task = obj.client.Login(login, password, serverType);
                Task.ContinueWith(@(t) obj.LoginHandler(t));
                Task.Wait();                
            catch e
                fprintf(2, 'Error while loging in. Please try again.\n');
                fprintf(2, [e.message, '\n']);                            
            end                                      
        end         
        function Logout(obj)
            try 
                obj.client.Logout();
                fprintf('Logout has been Succesful\n');
            catch e
                fprintf(2,'Error while loging out!\n');
                fprintf(2, [e.message, '\n']);  
            end    
        end           
        function RegisterTicks(obj, symbol, action)            
            if nargin < 3
                action = mForex.API.RegistrationAction.Register;
            end
                        
            if ~isa(action, 'mForex.API.RegistrationAction')
                error('Action is not a mForex.API.RegistrationAction.Register!');
            end
            
            if ~isa(symbol, 'char')
                error('Symbol in not a string!');
            end   
           
            try
                obj.client.RequestTickRegistration(symbol, action).ContinueWith(@(t) obj.GenericHandler(t));
            catch e
                fprintf(2,'Error while loging out!\n');
                fprintf(2, [e.message, '\n']);  
            end      
        end
    end    
    
    methods (Access=private)
        function TickEvHandler(obj, src, eventData)           
            notify(obj,'Ticks', EventData.Tick(eventData.Ticks))
        end        
        
        function MarginLevelEvHandler(obj, src, eventData)           
            notify(obj,'Margin', EventData.MarginLevel(eventData.MarginLevel))
        end
                
        function DisconnectedEvHandler(obj, src, eventData)           
            notify(obj,'Disconnected', EventData.Disconnected(eventData.Exception))
        end
        
        function TradeUpdateEvHandler(obj, src, eventData)           
            notify(obj,'TradeUpdate', EventData.TradeUpdate(eventData.TradeUpdatePacket.Action, ...
                                                            eventData.TradeUpdatePacket.Trade))
        end
        
    end
    
    events 
        Ticks
        Margin
        Disconnected
        TradeUpdate
    end
end