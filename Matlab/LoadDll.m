if ~IsAssemblyAdded('mForex.API.Matlab')
    asmAPI = NET.addAssembly([pwd,'\Dll\mForex.API.dll']);               
    asmMatlab = NET.addAssembly([pwd,'\Dll\mForex.API.Matlab.dll']);                   
    import mForex.API.*;
    import mForex.API.Matlab.*;
end

