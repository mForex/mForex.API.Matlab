function PrintTicks(src,eventData)    
    ticks = eventData.Ticks;       
    for i=1:ticks.Length
        t = ticks(i);
        fprintf('New tick: %s - %s/%s [%s]\n',char(t.Symbol), sprintf('%0.5f',t.Bid), sprintf('%0.5f',t.Ask), char(t.Time.ToString));
    end      
end