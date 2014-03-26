using System;
using mForex.API;
using mForex.API.Packets;

namespace mForex.API.Matlab
{   
    public class MarinLevelEventArgs : EventArgs
    {
        public MarginLevel[] Ticks { get; private set; }
    }

    public delegate void MarinLevelEventHandler(object sender, MarinLevelEventArgs e);
}
