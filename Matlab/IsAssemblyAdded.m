function flag = IsAssemblyAdded(assemblyName)
% ISASSEMBLYADDED check if user has arleady added package or class to
% current import list
    
    domain = System.AppDomain.CurrentDomain;
    assemblies = domain.GetAssemblies;
    flag = false;

    for i= 1:assemblies.Length
        asm = assemblies.Get(i-1);            
        if regexp(char(asm.FullName),['^', assemblyName, ','],'once');
            flag = true;
            break;
        end
    end
end