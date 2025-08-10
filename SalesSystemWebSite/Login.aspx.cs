using SalesSystemWebSite.BLL;
using SalesSystemWebSite.Entities;
using System;
using System.Web;
using System.Web.UI;

namespace SalesSystemWebSite
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpContext.Current.Session.Clear();
                HttpContext.Current.Session.Abandon();
            }
        }

        protected void MainBtn_ServerClick(object sender, EventArgs e)
        {
            UserService userService = new UserService();
            UserInfo userInfo = userService.Login(inputUserName.Text, inputPassword.Text);
            if (userInfo == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "LoginScript", "showError()", true);
                return;
            }
            HttpContext.Current.Session["UserInfo"] = userInfo;
            switch (userInfo.Role.UserRole)
            {
                case UserRole.Dealer:
                    Response.Redirect("/Dealer/Dashboard.aspx");
                    break;
                case UserRole.Manager:
                    Response.Redirect("/Manager/Dashboard.aspx");
                    break;
                default:
                    Response.Redirect("/404.aspx");
                    break;
            }
        }
    }
}