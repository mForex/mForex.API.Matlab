using System;
using mForex.API;
using mForex.API.Packets;

namespace mForex.API.Matlab
{
    public class TickEventArgs : EventArgs
    {
        public Tick[] Ticks { get; private set; }
    }

    public delegate void TickEventHandler(object sender, TickEventArgs e);
}
