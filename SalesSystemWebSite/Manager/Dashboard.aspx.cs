using SalesSystemWebSite.BLL;
using SalesSystemWebSite.Entities;
using SalesSystemWebSite.Interfaces;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace SalesSystemWebSite.Manager
{
    public partial class Dashboard : Page, IManagerPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            OrderService orderService = new OrderService();
            Date.Text = DateTime.Now.ToString("dd/MM/yyyy");
            List<OrderSearch> orders = orderService.GetByIdOrDateOrStatus(null, DateTime.Now, 0);
            NewOrders.Text = orders.Count.ToString();
            int items = 0;
            foreach (OrderSearch order in orders)
            {
                List<OrderItem> orderItems = orderService.GetOrderItemsByOrderId(order.Id);
                items += orderItems.Count;
            }
            Items.Text = items.ToString();
            ToSearch.NavigateUrl = $"./Orders/Search.aspx?date={DateTime.Now.ToString("dd/MM/yyyy")}&status=0";
        }
    }
}