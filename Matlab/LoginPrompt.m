function [login, password, serverType] = loginPrompt()
    % Promt for password
    [login, password, serverType] = basicPrompt();

    if isempty(login) || isempty(password) || isempty(serverType)
        login = []; password =[]; serverType = [];
    end    
end

function [login, password, serverType] = basicPrompt()
  login = input('Login: ',  's');
  password = input('Password: ', 's');  
  serverType = serverPrompt();
end

function serverType = serverPrompt()     
    srv = input(sprintf('Available servers:\n\t1)Demo \n\t2)Real \nPlease select server type:'),'s');    
    if srv == '1'         
       serverType = mForex.API.ServerType.Demo;
    elseif srv == '2'         
       serverType = mForex.API.ServerType.Real;
    else
        fprintf('Wrong server type: %s. Please try again.\n', srv);
        serverType = serverPrompt();
    end
end

% function [login, password, serverType] = quickLogin(login,password, serverType)
%   disp(['You are currently logged in as ' login '.']);
%   cont_token = input('Is this you? (y/n - type n to reenter password)','s');
%   if(isempty(cont_token) || cont_token(1)=='Y'||cont_token(1)=='y')
%     return;
%   else
%     [login, password, serverType] = loginPrompt();
%   end
% end
% 
% function [login, password, serverType] = getLoginData()
%     if ~exist('login_data.mat','file')
%         [login, password, serverType] = loginPrompt();
%         save('login_data.mat','login','password', 'serverType');
%     else  
%         load('login_data.mat');
%         [login, password, serverType] = quickLogin(login, password, serverType);
%         save('login_data.mat','login','password');
%     end    
% end