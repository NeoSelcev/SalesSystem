using SalesSystemWebSite.BLL;
using SalesSystemWebSite.Entities;
using SalesSystemWebSite.Interfaces;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesSystemWebSite.Dealer.Orders
{
    public partial class Upsert : Page, IDealerPage
    {
        OrderService orderService;
        CustomerService customerService;
        ItemService itemService;

        public List<OrderItem> OrderItems
        {
            get => (List<OrderItem>)ViewState["orderItemsSku"];
            set => ViewState["orderItemsSku"] = value;

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            orderService = new OrderService();
            customerService = new CustomerService();
            itemService = new ItemService();

            if (!IsPostBack)
            {
                bool orderExists = LoadOrderDetails();
                OrderIdWrap.Visible = orderExists;
                if (orderExists)
                {
                    LoadOrderItems();
                }
                else if (!bool.Parse(ConfigurationManager.AppSettings["allowAnonymousAtAllPages"]))
                {
                    LoadCustomerDetails();
                }
            }
        }

        private bool LoadOrderDetails()
        {
            string orderIdString = HttpUtility.ParseQueryString(Request.Url.Query).Get("orderId");
            int orderId = -1;
            if (int.TryParse(orderIdString, out orderId))
            {
                Entities.Order order = orderService.GetById(orderId);
                if (order != null)
                {
                    OrderItems = new List<OrderItem>();
                    OrderId.Text = order.Id.ToString();
                    OrderIdHidden.Value = order.Id.ToString();
                    Customer.Text = GetCustomerName(order.CustomerId);
                    CustomerIdHidden.Value = order.CustomerId.ToString();
                    Status.Text = GetStatus(order.Status);
                    StatusHidden.Value = order.Status.ToString();
                    OrderItems = order.orderItems;
                    OrderPrice.Text = order.orderItems.Sum(o => o.Price * o.Amount).ToString();
                    Discount.Text = order.Discount.ToString();
                    FinalOrderPrice.Text = (order.orderItems.Sum(o => o.Price * o.Amount) * (decimal)((100 - (decimal)order.Discount) / 100)).ToString();
                    return true;
                }
            }
            return false;
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

        private string GetCustomerName(int customerId)
        {
            Customer customer = customerService.GetById(customerId);
            return customer.Name;
        }

        private void LoadCustomerDetails()
        {
            string customerIdString = HttpUtility.ParseQueryString(Request.Url.Query).Get("customerId");
            int customerId = -1;
            if (int.TryParse(customerIdString, out customerId))
            {
                Customer customer = customerService.GetById(customerId);
                if (customer != null)
                {
                    Customer.Text = customer.Name;
                    CustomerIdHidden.Value = customer.Id.ToString();
                    return;
                }
            }
            Response.Redirect($"./Search.aspx");
        }

        private void LoadOrderItems()
        {
            if (OrderItems != null && OrderItems.Count > 0)
            {
                OrderItemsRpt.DataSource = OrderItems;
                OrderPrice.Text = OrderItems.Sum(o => o.Price * o.Amount).ToString();
                FinalOrderPrice.Text = (OrderItems.Sum(o => o.Price * o.Amount) * (decimal)((100 - decimal.Parse(Discount.Text)) / 100)).ToString();
            }
            else if (OrderItemsRpt.Items.Count > 0)
            {
                OrderItemsRpt.Dispose();
            }
            OrderItemsRpt.DataBind();
        }

        protected void SearchBtn_Click(object sender, EventArgs e)
        {
            List<ItemSearch> searchItems = itemService.GetBySkuOrName(String.IsNullOrEmpty(SearchSku.Text) ? (int?)null : int.Parse(SearchSku.Text), SearchName.Text);
            if (searchItems != null && searchItems.Count > 0)
            {
                SearchResult.Visible = true;
                SearchItemsRpt.DataSource = searchItems;
                SearchItemsRpt.DataBind();
            }
            else
            {
                SearchResult.Visible = false;
            }
            ClientScript.RegisterStartupScript(this.GetType(), "SearchScript", "showSearchResult()", true);
        }

        protected void SearchItemsRpt_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                ItemSearch itemSearch = (ItemSearch)e.Item.DataItem;

                Label sku = (Label)e.Item.FindControl("Sku");
                sku.Text = itemSearch.Sku.ToString();

                Label name = (Label)e.Item.FindControl("Name");
                name.Text = itemSearch.Name;

                Image image = (Image)e.Item.FindControl("Image");
                image.ImageUrl = itemSearch.ImageUrl;

                Label price = (Label)e.Item.FindControl("Price");
                price.Text = itemSearch.Price.ToString();

                Label available = (Label)e.Item.FindControl("Available");
                available.Text = itemSearch.Available.ToString();
            }
        }

        protected void AddItems_Click(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in SearchItemsRpt.Items)
            {
                CheckBox addChB = (CheckBox)item.FindControl("AddChB");
                if (addChB.Checked)
                {
                    Label sku = (Label)item.FindControl("Sku");
                    Label name = (Label)item.FindControl("Name");
                    Image image = (Image)item.FindControl("Image");
                    Label price = (Label)item.FindControl("Price");
                    Label available = (Label)item.FindControl("Available");
                    OrderItem orderItem = new OrderItem()
                    {
                        Sku = int.Parse(sku.Text),
                        Name = name.Text,
                        ImageUrl = image.ImageUrl,
                        Price = int.Parse(price.Text),
                        Available = int.Parse(available.Text),
                        ActualAmount = 0,
                        Amount = 1
                    };
                    if (OrderItems == null)
                    {
                        OrderItems = new List<OrderItem>();
                    }
                    OrderItems.Add(orderItem);
                }
            }
            if (OrderItems != null && OrderItems.Count > 0)
            {
                LoadOrderItems();
            }
            ResetSearch();
        }

        protected void CancelSearch_Click(object sender, EventArgs e)
        {
            ResetSearch();
        }

        private void ResetSearch()
        {
            SearchSku.Text = String.Empty;
            SearchName.Text = String.Empty;
            if (SearchItemsRpt.Items.Count > 0)
            {
                SearchItemsRpt.Dispose();
            }
            SearchItemsRpt.DataBind();
            SearchResult.Visible = false;
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

                TextBox amount = (TextBox)e.Item.FindControl("Amount");
                amount.Text = orderItem.Amount.ToString();

                Label totalPrice = (Label)e.Item.FindControl("TotalPrice");
                totalPrice.Text = (orderItem.Price * 5).ToString();

                LinkButton deleteOrderItemBtn = (LinkButton)e.Item.FindControl("DeleteOrderItemBtn");
                deleteOrderItemBtn.Attributes.Add("index", e.Item.ItemIndex.ToString());

            }
        }

        protected void DeleteOrderItemBtn_Click(object sender, EventArgs e)
        {
            LinkButton deleteOrderItemBtn = (LinkButton)sender;
            int index = int.Parse(deleteOrderItemBtn.Attributes["index"]);
            OrderItems.RemoveAt(index);
            if (OrderItems != null && OrderItems.Count > 0)
            {
                LoadOrderItems();
            }
        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {
            for(int i = 0; i < OrderItems.Count; i++)
            {
                TextBox amonut = (TextBox)OrderItemsRpt.Items[i].FindControl("Amount");
                OrderItems[i].Amount = int.Parse(amonut.Text);
            }

            int orderId = orderService.Upsert(String.IsNullOrEmpty(OrderIdHidden.Value) ? (int?)null : int.Parse(OrderIdHidden.Value), 
                int.Parse(CustomerIdHidden.Value), 0, int.Parse(Discount.Text), OrderItems);

            Response.Redirect($"./Order.aspx?id={orderId}");
        }
    }
}