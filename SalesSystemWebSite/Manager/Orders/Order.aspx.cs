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
    public partial class Order : Page, IManagerPage
    {
        OrderService orderService;

        protected void Page_Load(object sender, EventArgs e)
        {
            orderService = new OrderService();
            int id = GetOrderId();
            if (id == -1)
            {
                Response.Redirect($"./Search.aspx");
            }
            if (!IsPostBack)
            {
                ToSearch.NavigateUrl = $"~/Manager/Orders/Search.aspx?date={DateTime.Now.ToString("dd/MM/yyyy")}&status=0";
                LoadOrder(id);
            }
        }

        private int GetOrderId()
        {
            string idString = HttpUtility.ParseQueryString(Request.Url.Query).Get("Id");
            int id = -1;
            return int.TryParse(idString, out id) ? id : -1;
        }

        private void LoadOrder(int id)
        {
            Entities.Order order = orderService.GetById(id);
            if (order != null)
            {
                OrderId.Text = order.Id.ToString();
                CustomerName.Text = order.CustomerName;
                Status.SelectedValue = order.Status.ToString();
                OrderItemsRpt.DataSource = order.orderItems;
                OrderItemsRpt.DataBind();
                return;
            }
        }

        protected void OrderItemsRpt_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                OrderItem orderItem = (OrderItem)e.Item.DataItem;

                HiddenField id = (HiddenField)e.Item.FindControl("Id");
                id.Value = orderItem.Id.ToString();

                Label sku = (Label)e.Item.FindControl("Sku");
                sku.Text = orderItem.Sku.ToString();

                Label name = (Label)e.Item.FindControl("Name");
                name.Text = orderItem.Name;

                Image image = (Image)e.Item.FindControl("Image");
                image.ImageUrl = orderItem.ImageUrl;

                Label warehousePlace = (Label)e.Item.FindControl("WarehousePlace");
                warehousePlace.Text = orderItem.WarehousePlace.ToString();

                Label amount = (Label)e.Item.FindControl("Amount");
                amount.Text = orderItem.Amount.ToString();

                TextBox actualAmount = (TextBox)e.Item.FindControl("ActualAmount");
                actualAmount.Text = orderItem.ActualAmount.ToString();

                Label available = (Label)e.Item.FindControl("Available");
                available.Text = orderItem.Available.ToString();

            }
        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {
            int orderId = GetOrderId();
            int status = int.Parse(Status.SelectedValue);
            Dictionary<int, int> updatedOrderItem = new Dictionary<int, int>();
            foreach (RepeaterItem item in OrderItemsRpt.Items)
            {
                HiddenField orderItemId = (HiddenField)item.FindControl("Id");
                TextBox actualAmount = (TextBox)item.FindControl("ActualAmount");

                updatedOrderItem.Add(int.Parse(orderItemId.Value), int.Parse(actualAmount.Text));
            }
            orderService.UpdateOrderStatusAndActualAmounts(orderId, status, updatedOrderItem);
            int id = GetOrderId();
            LoadOrder(id);
        }
    }
}