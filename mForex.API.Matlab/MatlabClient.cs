using System;
using mForex.API;

namespace mForex.API.Matlab 
{
    public class MatlabClient : ITradeProvider
    {

        private APIClient apiClient;

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
        
        }
        
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
                EventHandler.RiseSafely(() => h(this,tup));
        }
        
        private void OnDisconnected(ExceptionEventArgs exc)
        {
            var h = Disconnected;
            if (h != null)
                EventHandler.RiseSafely(() => h(this, exc));
        }
        #endregion

        #region ITradeProvider
        public System.Threading.Tasks.Task<Packets.TradeTransResponsePacket> CloseOrder(int orderId, double volume)
        {
            throw new NotImplementedException();
        }

        public System.Threading.Tasks.Task<Packets.TradeTransResponsePacket> DeleteOrder(int orderId)
        {
            throw new NotImplementedException();
        }

        public System.Threading.Tasks.Task<Packets.TradeTransResponsePacket> ModifyOrder(int orderId, double newPrice, double newStopLoss, double newTakeProfit, double newVolume, DateTime newExpiration)
        {
            throw new NotImplementedException();
        }

        public System.Threading.Tasks.Task<Packets.TradeTransResponsePacket> OpenOrder(string symbol, TradeCommand tradeCommand, double price, double stopLoss, double takeProfit, double volume, string comment)
        {
            throw new NotImplementedException();
        }

        public System.Threading.Tasks.Task<Packets.TradeTransResponsePacket> OpenOrder(string symbol, TradeCommand tradeCommand, double price, double stopLoss, double takeProfit, double volume)
        {
            throw new NotImplementedException();
        }
        #endregion
    }
}
