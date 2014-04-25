function prices = GetPrices(assets, period, from, to, apiClient)

    if ~isa(assets, cell)
        error('Asset list is in invalid format');
    end 
    
    if ~isa(period, 'mForex.API.CandlePeriod')
        error('Candle period is in invalid format');
    end 

    prices = cell(1,length(assets));

    for i = 1:length(assets)    
        res = apiClient.RequestCandles(assets{i}, period, from, to);
        candles = res.Candles;

        data_CLOSE_PRICE = zeros(candles.Length, 1);
        data_TIME = zeros(candles.Length, 1);        

        for j = 1:candles.Length
            data_CLOSE_PRICE(j) = candles(j).Close;
            data_TIME(j) = datenum(char(candles(j).Time.ToString), 'yyyy-mm-dd HH:MM:SS');           
        end
        if i==0 
            dates = data_TIME;
        else
            dates = intersect(dates,data_TIME);     
       end

        prices{1,i} = timeseries(data_CLOSE_PRICE,data_TIME, 'name', assets{i});
    end

    for i = 1:length(assets)
         prices{1,i} = resample(prices{1,i}, dates);
    end 
end

