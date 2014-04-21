function res = CandleHandler(obj, task)
%   CANDLEHANDLER handles requestCandles response
%   Enter your candles handling routine here
    disp('Evaluating custom CandleHandler');    
    res = obj.GenericHandler(task);
end

