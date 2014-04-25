if ~IsAssemblyAdded('mForex.API')
    asmAPI = LoadAssembly('mForex.API'); 
end

if ~IsAssemblyAdded('mForex.API.Matlab')
    asmMatlab = LoadAssembly('mForex.API.Matlab');
end

