function DisplayTrade(tradeEvent)
%DISPLAYTRADE 
%   Implement your own trade displaying routine
    trade = tradeEvent.TradeRecord;
    fprintf('"Trade: %d - %s" [%s]\n',trade.Order, char(tradeEvent.Action.ToString()), char(trade.Symbol));
end

