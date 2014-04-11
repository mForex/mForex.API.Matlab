using System;
using mForex.API;
using mForex.API.Packets;

namespace mForex.API.Matlab
{
    public delegate void ExceptionEventHandler(object sender, ExceptionEventArgs e);

    public class ExceptionEventArgs : EventArgs
    {

        public Exception Exception { get; private set; }
        public ExceptionEventArgs(Exception exc)
        {
            Exception = exc;
        }
    }
}
