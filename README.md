---------------
#mForex Matlab API

The goal of mForex.Matlab API is to provide flexible, asynchronous programming model for 
Matlab based on **mForex API** for forex trading.

We are currently conducting beta tests, so our API is only available on demand for demo accounts only. If you would like to participate, please contact us on api@mforex.pl.

---------------
# Quick Start
In an effort to use Matlab API Client one have to import appropriate namespaces:

```matlab
asmAPI = LoadAssembly('mForex.API');
asmMatlab = LoadAssembly('mForex.API.Matlab');
```


## Logging in 
Once you have your account ready, you can log in to our server using following code:

```matlab
% read data from command line
[login, password, serverType] = GetLoginData;

% create API Client and Login
client = ApiClient;
client.Login(login, password, serverType.toDotNet);
```

## Requesting for quotes
Once connection has been established, all relevant data have been setup and are ready to be registered for. ```ApiClient``` provides events which can be subscribed to. However, tick data has to be registered using ```.RegisterTicks()``` method.

For example, to receive and plot every incoming tick of **EURUSD** one could:

```matlab
% create plotter 
p = Plotter(10);

% create listener
event.listener(client,'Ticks',@(src, evnt) p.Refresh(src, evnt));

% register for ticks
lh = client.RegisterTicks('GBPUSD');
```
## Trading
```ApiClient``` provides convenient order placing mechanism:

```matlab
% Open sample order
res = client.OpenOrder('EURUSD', mForex.API.TradeCommand.Buy, 1);

% Close sample order
res = client.CloseOrder(res.Order);
```
<!--
[TOC]
-->

----------
> **NOTE:** You can find more information:
>
> - about **mForex** services and products [here][1],
> - about **mForex API** [here][2],
> - about **mForex API for F#** [here][3],
> - about **mForex API for TypeScript** [here][4],


[1]: http://www.mforex.pl/
[2]: https://github.com/mForex/mForex.API
[3]: https://github.com/mForex/mForex.API.FSharp
[4]: https://github.com/mForex/mForex.API.TypeScript
