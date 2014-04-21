function res = LoginHandler(obj, task)
%   LOGINHANDLER
%   Handles login
    if ~task.IsFaulted
        fprintf('"Login response: %d - %s"\n', task.Result.Login, char(task.Result.LoginStatus.ToString()));
        res = task.Result;
    else
        fprintf('Ups! Something went wrong!\n');              
        res = task.Exception;
    end
end

