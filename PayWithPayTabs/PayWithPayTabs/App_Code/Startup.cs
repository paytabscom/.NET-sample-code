using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(PayWithPayTabs.Startup))]
namespace PayWithPayTabs
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
