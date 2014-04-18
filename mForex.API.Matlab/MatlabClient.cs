using System;
using System.Threading;
using System.Threading.Tasks;
using mForex.API;
using mForex.API.Packets;

namespace mForex.API.Matlab
{
    public class MatlabClient : ITradeProvider, IDisposable
    {

        private APIClient apiClient;
        private bool isConnected;

        /// <summary>
        /// Occurs when new ticks are received from the server.
        /// </summary>
        public event TickEventHandler Ticks;

        /// <summary>
        /// Occurs when margin level is updated. 
        /// However, this cannot occur more often than once per second.
        /// </summary>
        /// <remarks>This event is fired only when packet with id 514 is received. 
        /// If margin level was requested explicitly, this even will not be fired.
        /// </remarks>
        public event MarinLevelEventHandler Margin;

        /// <summary>
        /// Occurs when client is disconnected from server with exception.
        /// </summary>
        public event ExceptionEventHandler Disconnected;

        /// <summary>
        /// Occurs when trade is updated.
        /// <remarks>
        /// Trade is marked as updated if it has been opened, closed or modified.
        /// </remarks>
        /// </summary>
        public event TradeUpdateEventHandler TradeUpdate;

        public MatlabClient()
        {
            isConnected = false;
        }

        public Task<LoginResponsePacket> Login(int login, string password, ServerType serverType)
        {
            if (isConnected)
                Logout();

            apiClient = new APIClient(new APIConnection(serverType));
            InitializeEventHadlers();

            apiClient.Connect().Wait();
            isConnected = true;

            return apiClient.Login(login, password);
        }
        public void Logout()
        {
            if (isConnected)
            {
                try
                {
                    apiClient.Disconnect();
                }
                finally
                {
                    isConnected = false;
                }
            }
        }
        public Task<TickRegistrationResponsePacket> RequestTickRegistration(string symbol, RegistrationAction action)
        {
            return apiClient.RequestTickRegistration(symbol, action);
        }
        public Task<CandleResponsePacket> RequestCandles(string symbol, CandlePeriod period, DateTime from, DateTime to)
        {
            return apiClient.RequestCandles(symbol, period, from, to);
        }
        public Task<SessionScheduleResponsePacket> RequestSessions(string symbol)
        {
            return apiClient.RequestSessions(symbol);
        }
        public Task<ClosedTradesResponsePacket> RequestTradesHistory(DateTime from, DateTime to)
        {
            return apiClient.RequestTradesHistory(from, to);
        }
        public Task<InstrumentSettingsResponsePacket> RequestInstrumentSettings()
        {
            return apiClient.RequestInstrumentSettings();
        }
        public Task<AccountSettingsResponsePacket> RequestAccountSettings()
        {
            return apiClient.RequestAccountSettings();
        }
        public Task<MarginLevelResponsePacket> RequestMarginLevel()
        {
            return apiClient.RequestMarginLevel();
        }
        public Task<TradesInfoResponsePacket> RequestOpenTrades()
        {
            return apiClient.RequestOpenTrades();
        }

        #region ITradeProvider
        public Task<TradeTransResponsePacket> CloseOrder(int orderId, double volume)
        {
            throw new NotImplementedException();
        }
        public Task<TradeTransResponsePacket> DeleteOrder(int orderId)
        {
            throw new NotImplementedException();
        }
        public Task<TradeTransResponsePacket> ModifyOrder(int orderId, double newPrice, double newStopLoss, double newTakeProfit, double newVolume, DateTime newExpiration)
        {
            throw new NotImplementedException();
        }
        public Task<TradeTransResponsePacket> OpenOrder(string symbol, TradeCommand tradeCommand, double price, double stopLoss, double takeProfit, double volume, string comment)
        {
            throw new NotImplementedException();
        }
        public Task<TradeTransResponsePacket> OpenOrder(string symbol, TradeCommand tradeCommand, double price, double stopLoss, double takeProfit, double volume)
        {
            throw new NotImplementedException();
        }
        #endregion

        #region IDisposable
        public void Dispose()
        {
            if (apiClient != null)
            {
                if (isConnected)
                    apiClient.Disconnect();

                apiClient = null;
            }
        }
        #endregion IDisposable

        #region Events
        protected void OnTicks(TickEventArgs e)
        {
            var h = Ticks;
            if (h != null)
                EventHandler.RiseSafely(() => h(this, e));
        }
        private void OnMargin(MarinLevelEventArgs ml)
        {
            var h = Margin;
            if (h != null)
                EventHandler.RiseSafely(() => h(this, ml));
        }
        private void OnTradeUpdate(TradeUpdateEventArgs tup)
        {
            var h = TradeUpdate;
            if (TradeUpdate != null)
                EventHandler.RiseSafely(() => h(this, tup));
        }
        private void OnDisconnected(ExceptionEventArgs exc)
        {
            isConnected = false;
            var h = Disconnected;
            if (h != null)
                EventHandler.RiseSafely(() => h(this, exc));
        }
        #endregion

        private void InitializeEventHadlers()
        {
            apiClient.Ticks += (t) => OnTicks(new TickEventArgs(t));
            apiClient.TradeUpdate += (tup) => OnTradeUpdate(new TradeUpdateEventArgs(tup));
            apiClient.Disconnected += (exc) => OnDisconnected(new ExceptionEventArgs(exc));
            apiClient.Margin += (mp) => OnMargin(new MarinLevelEventArgs(mp));
        }
    }
}
