using System;
using mForex.API;
using mForex.API.Packets;

namespace mForex.API.Matlab
{
    public class ExceptionEventArgs : EventArgs
    {
        public Exception Exception { get; private set; }
    }

    public delegate void ExceptionEventHandler(object sender, ExceptionEventArgs e);
}
