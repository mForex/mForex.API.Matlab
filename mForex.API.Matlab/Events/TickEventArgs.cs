using System;
using mForex.API;
using mForex.API.Packets;

namespace mForex.API.Matlab
{
    public delegate void TickEventHandler(object sender, TickEventArgs e);
    
    public class TickEventArgs : EventArgs
    {
        public Tick[] Ticks { get; private set; }
        public TickEventArgs(Tick[] ticks)
        {
            Ticks = ticks;
        }
    }
}
