function asm = LoadAssembly(assemblyName)
%LOADASSEMBLY Load and import assembly
%            
    try
        asm = NET.addAssembly([pwd,'\Dll\',assemblyName,'.dll']);               
    catch e 
        error(['Could not find ', assemblyName, '.dll in ', pwd,'\Dll\'])
    end
    name = [assemblyName, '.*'];
    feval(@import, name)    
end

