using SalesSystemWebSite.Entities;
using SalesSystemWebSite.Interfaces;
using System;
using System.Configuration;
using System.Web;
using System.Web.UI;

namespace SalesSystemWebSite.MasterPages
{
    public partial class AuthenticatedMasterPage : MasterPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            if (!bool.Parse(ConfigurationManager.AppSettings["allowAnonymousAtAllPages"]))
            {
                UserInfo userInfo = (UserInfo)HttpContext.Current.Session["UserInfo"];
                if (userInfo == null)
                {
                    HttpContext.Current.Response.Redirect("~/Login.aspx");
                }

                if (userInfo.Role.UserRole == UserRole.Dealer && !(this.Page is IDealerPage))
                {
                    HttpContext.Current.Response.Redirect("~/Dealer/DashBoard.aspx");
                }

                if (userInfo.Role.UserRole == UserRole.Manager && !(this.Page is IManagerPage))
                {
                    HttpContext.Current.Response.Redirect("~/Manager/DashBoard.aspx");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
    }
}