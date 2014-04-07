function flag = IsAssemblyAdded(assemblyName)

    domain = System.AppDomain.CurrentDomain;
    assemblies = domain.GetAssemblies;
    flag = false;

    for i= 1:assemblies.Length
        asm = assemblies.Get(i-1);            
        if regexp(char(asm.FullName),['^', assemblyName, ','],'once');
            flag = true;
        end
    end
end