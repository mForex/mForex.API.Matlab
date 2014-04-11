function GenericHandler(obj, task)
    %   GENERICHANDLER is used to handle generic Task<APINetworkPacket>
    %   Detailed explanation goes here
    if ~task.IsFaulted && ~isa(task, 'Task<mForex*API*Packets*LoginResponsePacket>')     
        fprintf('"Task<%s> response: %s"\n', char(task.Result.Type), char(task.Result.ErrorCode));
    else
        fprintf('Ups! Something went wrong!\n');              
    end
end

