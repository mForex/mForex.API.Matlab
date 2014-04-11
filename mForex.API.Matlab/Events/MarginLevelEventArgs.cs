using System;
using mForex.API;
using mForex.API.Packets;

namespace mForex.API.Matlab
{
    public delegate void MarinLevelEventHandler(object sender, MarinLevelEventArgs e);
    
    public class MarinLevelEventArgs : EventArgs
    {        
        public MarginLevel MarginLevel { get; private set; }
        public MarinLevelEventArgs(MarginLevel marginLevel)
        {            
            MarginLevel = marginLevel;
        }
    }    
}
