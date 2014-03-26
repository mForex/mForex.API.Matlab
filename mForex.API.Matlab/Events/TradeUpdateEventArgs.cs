using System;
using mForex.API;
using mForex.API.Packets;

namespace mForex.API.Matlab
{
    public class TradeUpdateEventArgs : EventArgs
    {
        public TradeUpdatePacket[] Ticks { get; private set; }
    }

    public delegate void TradeUpdateEventHandler(object sender, TradeUpdateEventArgs e);
}
