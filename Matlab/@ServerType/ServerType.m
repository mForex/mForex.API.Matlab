classdef ServerType
   % Available server types
   enumeration
      Demo, Real
   end
   
   methods
       % Conversion to .Net enums used in mForex.API
       function mForexST = toDotNet(obj)
            switch(obj)
                case ServerType.Demo
                    mForexST = mForex.API.ServerType.Demo;
                case ServerType.Real
                    mForexST = mForex.API.ServerType.Real;
            end
       end 
   end   
end