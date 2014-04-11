using System;
using mForex.API;
using mForex.API.Packets;

namespace mForex.API.Matlab
{
    public delegate void TradeUpdateEventHandler(object sender, TradeUpdateEventArgs e);

    public class TradeUpdateEventArgs : EventArgs
    {
        public TradeUpdatePacket TradeUpdatePacket { get; private set; }
        public TradeUpdateEventArgs(TradeUpdatePacket tradeUpdatepacket)
        {
            TradeUpdatePacket = tradeUpdatepacket;
        }
    }
}
