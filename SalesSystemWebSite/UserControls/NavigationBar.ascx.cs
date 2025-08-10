using SalesSystemWebSite.Entities;
using System;
using System.Configuration;
using System.Web;
using System.Web.UI;

namespace SalesSystemWebSite.UserControls
{
    public partial class NavigationBar : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!bool.Parse(ConfigurationManager.AppSettings["allowAnonymousAtAllPages"]))
            {
                UserInfo userInfo = (UserInfo)HttpContext.Current.Session["UserInfo"];
                userName.Text = userInfo.FullName;
                userRole.Text = userInfo.Role.Description;
                switch (userInfo.Role.UserRole)
                {
                    case UserRole.Dealer:
                        HomeLink.NavigateUrl = "~/Dealer/Dashboard.aspx";
                        navMltv.SetActiveView(dealerView);
                        break;
                    case UserRole.Manager:
                        HomeLink.NavigateUrl = "~/Manager/Dashboard.aspx";
                        navMltv.SetActiveView(managerView);
                        break;
                }
            }
        }
    }
}