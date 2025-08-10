using SalesSystemWebSite.BLL;
using SalesSystemWebSite.Entities;
using SalesSystemWebSite.Interfaces;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesSystemWebSite.Manager.Orders
{
    public partial class Search : Page, IManagerPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string dateString = HttpUtility.ParseQueryString(Request.Url.Query).Get("date");
            string statusString = HttpUtility.ParseQueryString(Request.Url.Query).Get("status");
            DateTime date = default(DateTime);
            int status = -1;
            if (DateTime.TryParse(dateString, out date) && int.TryParse(statusString, out status))
            {
                Date.Text = date.ToString("dd/MM/yyyy");
                Status.SelectedValue = status.ToString();
                OrderService orderService = new OrderService();
                List<OrderSearch> orders = orderService.GetByIdOrDateOrStatus(null, date, status);
                HandleSearchResults(orders);
            }
        }

        protected void SearchBtn_Click(object sender, EventArgs e)
        {
            OrderService orderService = new OrderService();
            int? id = String.IsNullOrEmpty(Id.Text) ? (int?)null : int.Parse(Id.Text);
            DateTime? date = String.IsNullOrEmpty(Date.Text) ? (DateTime?)null : DateTime.Parse(Date.Text);
            int i = 0;
            int? status = int.TryParse(Status.SelectedValue, out i) ? int.Parse(Status.SelectedValue) : (int?)null;
            List<OrderSearch> orders = orderService.GetByIdOrDateOrStatus(id, date, status);
            HandleSearchResults(orders);
        }

        private void HandleSearchResults(List<OrderSearch> orders)
        {
            if (orders.Count > 0)
            {
                SearchResult.Visible = true;
                OrdersSearchRpt.DataSource = orders;
                OrdersSearchRpt.DataBind();
            }
            else
            {
                SearchResult.Visible = false;
            }
        }

        protected void OrdersSearchRpt_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                OrderSearch order = (OrderSearch)e.Item.DataItem;

                HyperLink orderLink = (HyperLink)e.Item.FindControl("OrderLink");
                orderLink.NavigateUrl = $"./Order.aspx?id={order.Id}";
                orderLink.Text = order.Id.ToString();

                Label dateCreated = (Label)e.Item.FindControl("DateCreated");
                dateCreated.Text = order.DateCreated.ToLocalTime().ToString();

                Label shipmentDate = (Label)e.Item.FindControl("ShipmentDate");
                shipmentDate.Text = order.ShipmentDate.ToLocalTime().ToString();

                Label status = (Label)e.Item.FindControl("Status");
                status.Text = GetStatus(order.Status);

                Label totalPrice = (Label)e.Item.FindControl("TotalPrice");
                totalPrice.Text = order.TotalPrice.ToString();
            }
        }

        private string GetStatus(int status)
        {
            switch (status)
            {
                case 0:
                    return "הזמנה חדשה";
                case 1:
                    return "ממתין לליקוט";
                case 2:
                    return "הזמנה לוקטה";
                case 3:
                    return "הזמנה הסתיימה";
                default:
                    throw new Exception("invalid order status");
            }
        }
    }
}