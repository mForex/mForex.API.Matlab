LoadDll

import mForex.API.*;
import mForex.API.Matlab.*;
import Samples.Candles.*

% Get login and password from file or let the usere input data
[login, password, serverType] = GetLoginData;

% Create API Client and Login
client = ApiClient;
client.Login(login, password, serverType.toDotNet);

% Setup list of available instrumentes
assets = {'AIG.US'; 'AMAZON.US'; 'AT&T.US'; 'APPLE.US'; 'BOEING.US';...
          'CHEVRON.US'; 'CISCO.US'; 'CITI.US'; 'COCACOLA.US'; 'EBAY.US'; ...
          'EXXONM.US';'FACEBOOK.US';'GE.US';'GMOTORS.US';'GOLDMAN.US'; ...
          'GOOGLE.US';'IBM.US';'INTEL.US';'J&J.US';'JPMORGAN.US';'3M.US';...
          'LINKEDIN.US';'MCDONALD.US';'MICROSFT.US';'PFIZER.US';'P&G.US';...
          'STBUCKS.US';'UPS.US';'WALMART.US';'YAHOO.US'};
      
% Set parameters data range and candle period
period = CandlePeriod.D1;
from = System.DateTime.MinValue;
to = System.DateTime.Now;

prices = GetPrices(assets, period, from, to, client);