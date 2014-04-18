LoadDll

[login, password, serverType] = GetLoginData;

% create plotter 
p = Plotter(10);

%create API Client and Login
client = ApiClient;
client.Login(login, password, serverType.toDotNet);

%create listener
event.listener(client,'Ticks',@(src, evnt) p.Refresh(src, evnt));

%register for ticks
client.RegisterTicks('GBPUSD');

%unregister
client.RegisterTicks('GBPUSD', RegistrationAction.Unregister);
