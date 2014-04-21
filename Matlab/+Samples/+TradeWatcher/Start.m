LoadDll

import mForex.API.*;
import mForex.API.Matlab.*;
import Samples.TradeWatcher.*

[login, password, serverType] = GetLoginData;

%create API Client and Login
client = ApiClient;
client.Login(login, password, serverType.toDotNet);

%create listener
% TODO: create GUI for trade monitoring
lh = event.listener(client,'TradeUpdate',@(src, evnt) Samples.TradeWatcher.DisplayTrade(evnt));