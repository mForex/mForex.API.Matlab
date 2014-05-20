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
        
        function Logout(obj)
            try 
                obj.client.Logout();
                fprintf('Logout has been Succesful\n');
            catch e
                fprintf(2,'Error while loging out!\n');
                fprintf(2, [e.message, '\n']);  
            end    
        end           
        function res = Login(obj, login, password, serverType)
            if ~isa(serverType, 'mForex.API.ServerType')
                error('ServerType is not a mForex.Api.ServerType!');
            end   
            
            if ~isa(login, 'double')
                error('Login is not a number!');
            end   
            
            if ~isa(password, 'char')
                error('Password in not a string!');
            end   
            
            try                
                task = obj.client.Login(login, password, serverType);
                task.Wait();
                res = obj.EvaluateIfHandled('LoginHandler', task);                                                                
            catch e
                fprintf(2, 'Error while loging in. Please try again.\n');
                fprintf(2, [e.message, '\n']);                            
            end                                      
        end
        
        function res = RegisterTicks(obj, symbol, action)
            if nargin < 3
                action = mForex.API.RegistrationAction.Register;
            end
                        
            if ~isa(action, 'mForex.API.RegistrationAction')
                error('Action is not of mForex.API.RegistrationAction.Register type!');
            end
            
            if ~isa(symbol, 'char')
                error('Symbol in not a string!');
            end
            
            res = obj.SafeRequest('RequestTickRegistration', 'RegistrationHandler', ...
                                  'Error while registering for ticks out!', ...
                                  symbol, action);                
        end        
        function res = RequestCandles(obj, symbol, period, from, to)
            
            if ~isa(symbol, 'char')
                error('Symbol is not a string!');              
            end
            
            if ~isa(period, 'mForex.API.CandlePeriod')
                errror('Period is not of mForex.API.CandlePeriod type!');
            end
            
            if ~isa(from, 'System.DateTime') || ~isa(to, 'System.DateTime') 
                errror('Form or To is not of System.DateTime format');
            end
            
            res = obj.SafeRequest('RequestCandles', 'CandleHandler', ...
                                  'Error while requesting candles!', ...
                                   symbol, period, from, to);
        end 
        function res = RequestSessions(obj, symbol)
            
            if ~isa(symbol, 'char')
                error('Symbol is not a string!');              
            end
            
            res = obj.SafeRequest('RequestSessions', 'SessionHandler', ...
                                  'Error while requesting trading sessions!', ...
                                  symbol);            
        end
        function res = RequestTradesHistory(obj, from, to)
            
            if ~isa(from, 'System.DateTime') || ~isa(to, 'System.DateTime') 
                errror('Form or To is not of System.DateTime format');
            end
            
            res = obj.SafeRequest('RequestTradesHistory', 'HistoryHandler', ...
                                  'Error while requesting history', ...
                                  from, to);
        end
        function res = RequestInstrumentSettings(obj)
            
            res = obj.SafeRequest('RequestInstrumentSettings', 'InstrumentSettingsHandler', ...
                                  'Error while requesting instrument settings');
        end
        function res = RequestAccountSettings(obj)
            
            res = obj.SafeRequest('RequestAccountSettings', 'AccountSettingsHandler', ...
                                  'Error while requesting account settings');
        end
        function res = RequestMarginLevel(obj)
            
            res = obj.SafeRequest('RequestMarginLevel', 'MarginLevelHandler', ...
                                  'Error while requesting margin level');
        end        
        function res = RequestOpenTrades(obj)
            
            res = obj.SafeRequest('RequestOpenTrades', 'OpenTradesHandler', ...
                                  'Error while requesting open trades');
        end
        
        function res = CloseOrder(obj, orderId, varargin)
            
            if ~((isa(orderId, 'double') && rem(orderId, 1) == 0) || isa(orderId,'integer'))
                error('OrderId is not an integer!');
            end                 
            
            if nargin < 3                 
                volume = 100;
            else                
                if ~isa(varargin{3}, 'double')
                    error('Volume is not a number!');
                end
                volume = varargin{3};
            end  
                        
            res = obj.SafeRequest('CloseOrder', 'TradeTransResponseHandler', ...
                                 ['Error while closing an order:',int2str(orderId), '!'], ...
                                  orderId, volume);             
        end
        function res = DeleteOrder(obj, orderId)
            
            if ~isa(orderId, 'double') || ~(rem(orderId, 1) == 0)
                error('OrderId is not an integer!');
            end
            
            res = obj.SafeRequest('DeleteOrder', 'TradeTransResponseHandler', ...
                                 ['Error while deleting an order:',int2str(orderId), '!'], ...
                                  orderId);             
        end
        function res = ModifyOrder(obj, orderId, newPrice, newStopLoss, newTakeProfit, newVolume, newExpiration)
            
            if ~isa(orderId, 'double') || ~(rem(orderId, 1) == 0)
                error('OrderId is not an integer!');
            end 
            
            if ~isa(newPrice, 'double')
                error('Price is not a number!');
            end 
            
            if ~isa(newStopLoss, 'double')
                error('Stop loss is not a number!');
            end 
            
            if ~isa(newTakeProfit, 'double')
                error('Take profit is not a number!');
            end 
            
            if ~isa(newVolume, 'double')
                error('Volume is not a number!');
            end 
            
            if ~isa(newExpiration, 'System.DateTime')
                error('New expiration is not in valid date type!');
            end             
            
            res = obj.SafeRequest('ModifyOrder', 'TradeTransResponseHandler', ...
                      'Error while modifying pending order!', ...
                      orderId, newPrice, newStopLoss, newTakeProfit, newVolume, newExpiration);    
        end
        function res = OpenOrder(obj, symbol, tradeCommand, volume, varargin)
                        
            if ~isa(symbol, 'char')
                error('Order symbol is not a string!');              
            end
            
            if ~isa(tradeCommand, 'mForex.API.TradeCommand')
                error('Trade command is not of mForex.API.TradeCommand type!');
            end
            
            if ~isa(volume, 'double')
                error('Order volume is not a number!');
            end                        
            
            comment = 'matlab API';
            
            switch(tradeCommand)
                case mForex.API.TradeCommand.Balance
                    error('mForex.API.TradeCommand.Balance trade command is not available.');
                
                case mForex.API.TradeCommand.Credit
                    error('mForex.API.TradeCommand.Credit trade command is not available.');
                
                case mForex.API.TradeCommand.Buy
                    res = obj.OpenMarket(symbol, tradeCommand, volume, comment);
                
                case mForex.API.TradeCommand.Sell
                    res = obj.OpenMarket(symbol, tradeCommand, volume, comment);
                
                otherwise
                    res = obj.OpenPending(symbol, tradeCommand, volume, comment, varargin{:});
            end             
        end
    end    
    
    methods (Access=private)
        
        function res = OpenMarket(obj, symbol, tradeCommand, volume, comment)
            res = obj.SafeRequest('OpenOrder', 'TradeTransResponseHandler', ...
                      'Error while opening a market order!', ...
                      symbol, tradeCommand, 0, 0, 0, volume, comment);     
        end        
        function res = OpenPending(obj, symbol, tradeCommand, volume, comment, varargin)                                                

            [price, stopLoss, takeProfit] = SetDefaultIfMissing(varargin{:});
            
            res = obj.SafeRequest('OpenOrder', 'TradeTransResponseHandler', ...
                                  'Error while opening a pending order!', ...
                                  symbol, tradeCommand, price, stopLoss, takeProfit, volume, comment);        
                              
            % Validate arguments passed to Open Pending function
            function [price, takeProfit, stopLoss] = SetDefaultIfMissing(varargin)                                                              
                switch nargin
                    case 0
                        error('Pending price is missing!');
                    
                    case 1                                  % Only price is given
                        price = varargin{1};                % get price passed to function
                        stopLoss = 0;                       % set default values to SL
                        takeProfit = 0;                     % set default values to TP
                
                    case 2                                  % Only price and stopLoss is given
                        price = varargin{1};                % get price passed to function
                        stopLoss = varargin{2};             % get SL passed to function
                        takeProfit = 0;                     % set default values to Tp
                        
                    case 3                                  % Only price and stopLoss is given
                        price = varargin{1};                % get price passed to function
                        stopLoss = varargin{2};             % get SL passed to function
                        takeProfit = varargin{3};           % get TP passed to function
                end 
            end
        end
        
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
        
        function res = SafeRequest(obj, request, handler, errorMessage, varargin)
            try                 
                task = feval(str2func(request), obj.client,varargin{:});
                res = obj.EvaluateIfHandled(handler, task);
            catch e
                fprintf(2, [errorMessage, '\n']);
                fprintf(2, [e.message, '\n']);                  
            end
        end                
        function res = EvaluateIfHandled(obj, handlerName, task)
             if ~ismethod(obj, handlerName)                    
                res =  obj.GenericHandler(task);
             else                   
                res = feval(str2func(handlerName),obj, task);
            end 
        end         
    end
    
    events 
        Ticks
        Margin
        Disconnected
        TradeUpdate
    end
end
