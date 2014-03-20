using System;

namespace mForex.API.Matlab
{
    public class MatlabClient
    {
        public event TickEventHandler Ticks;

        public MatlabClient()
        { 
        
        }

        protected void OnTicks(TickEventArgs e)
        {
            var h = Ticks;
            if (h != null)
                EventHandler.RiseSafely(() => h(this, e));
        }
    }
}
