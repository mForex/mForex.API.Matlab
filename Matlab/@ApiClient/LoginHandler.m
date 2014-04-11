function LoginHandler(obj, task)
%LOGINHANDLER Summary of this function goes here
%   Handles login
    if ~task.IsFaulted
        fprintf('"Login response: %d - %s"\n', task.Result.Login, char(task.Result.LoginStatus.ToString()));
    else
        fprintf('Ups! Something went wrong!\n');              
    end
end

