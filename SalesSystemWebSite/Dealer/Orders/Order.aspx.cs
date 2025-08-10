using SalesSystemWebSite.BLL;
using SalesSystemWebSite.Entities;
using SalesSystemWebSite.Interfaces;
using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesSystemWebSite.Dealer.Orders
{
    public partial class Order : Page, IDealerPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string idString = HttpUtility.ParseQueryString(Request.Url.Query).Get("Id");
            int id = -1;
            if (int.TryParse(idString, out id))
            {
                OrderService orderService = new OrderService();
                Entities.Order order = orderService.GetById(id);
                if (order != null)
                {
                    OrderId.Text = order.Id.ToString();
                    CustomerId.NavigateUrl = $"~/Dealer/Customers/Customer.aspx?id={order.CustomerId}";
                    CustomerId.Text = order.CustomerId.ToString();
                    CustomerName.Text = order.CustomerName;
                    Status.Text = GetStatus(order.Status);
                    OrderItemsRpt.DataSource = order.orderItems;
                    OrderItemsRpt.DataBind();
                    OrderPrice.Text = order.orderItems.Sum(o => o.Price * o.Amount).ToString();
                    Discount.Text = order.Discount.ToString();
                    FinalOrderPrice.Text = (order.orderItems.Sum(o => o.Price * o.Amount) * (decimal)((100 - (decimal)order.Discount) / 100)).ToString();
                    Upsert.NavigateUrl = $"./Upsert.aspx?orderId={idString}";
                    return;
                }
            }
            Response.Redirect($"./Search.aspx");
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

        protected void OrderItemsRpt_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                OrderItem orderItem = (OrderItem)e.Item.DataItem;

                Label sku = (Label)e.Item.FindControl("Sku");
                sku.Text = orderItem.Sku.ToString();

                Label name = (Label)e.Item.FindControl("Name");
                name.Text = orderItem.Name;

                Image image = (Image)e.Item.FindControl("Image");
                image.ImageUrl = orderItem.ImageUrl;

                Label price = (Label)e.Item.FindControl("Price");
                price.Text = orderItem.Price.ToString();

                Label available = (Label)e.Item.FindControl("Available");
                available.Text = orderItem.Available.ToString();

                Label amount = (Label)e.Item.FindControl("Amount");
                amount.Text = orderItem.Amount.ToString();

                Label totalPrice = (Label)e.Item.FindControl("TotalPrice");
                totalPrice.Text = (orderItem.Price * 5).ToString();

            }
        }
    }
}