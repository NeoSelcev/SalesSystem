using SalesSystemWebSite.BLL;
using SalesSystemWebSite.Entities;
using SalesSystemWebSite.Interfaces;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesSystemWebSite.Dealer.Customers
{
    public partial class Customer : Page, IDealerPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string idString = HttpUtility.ParseQueryString(Request.Url.Query).Get("id");
            int id = -1;
            if (int.TryParse(idString, out id))
            {
                CustomerService customerService = new CustomerService();
                Entities.Customer customer = customerService.GetById(id);
                if (customer != null)
                {
                    tabPrivateDetails.NavigateUrl = $"~/Dealer/Customers/Customer.aspx?id={idString}&mode=privateDetails";
                    tabOrders.NavigateUrl = $"~/Dealer/Customers/Customer.aspx?id={idString}&mode=orders";
                    NewOrderBtn.NavigateUrl = $"~/Dealer/Orders/Upsert.aspx?customerId={idString}";
                    UpsertBtn.NavigateUrl = $"~/Dealer/Customers/Upsert.aspx?id={idString}";
                    string mode = HttpUtility.ParseQueryString(Request.Url.Query).Get("mode");
                    switch (mode)
                    {
                        case "orders":
                            tabPrivateDetails.CssClass = "nav-link";
                            tabOrders.CssClass = "nav-link active";                            
                            customerMltv.SetActiveView(viewOrders);
                            OrderService orderService = new OrderService();
                            List<OrderSearch> orders = orderService.GetByCustomerId(id);
                            if (orders.Count > 0)
                            {
                                OrdersResult.Visible = true;
                                CustomerOrdersRpt.DataSource = orders;
                                CustomerOrdersRpt.DataBind();
                            }
                            else
                            {
                                OrdersResult.Visible = false;
                            }
                            return;
                        case "privateDetails":
                        default:
                            tabPrivateDetails.CssClass = "nav-link active";
                            tabOrders.CssClass = "nav-link";
                            customerMltv.SetActiveView(viewPrivateDetails);

                            IdSbj.Text = Id.Text = customer.Id.ToString();
                            NameSbj.Text = Name.Text = customer.Name;
                            DealerName.Text = customer.DealerName;
                            Status.Text = customer.Status == 0 ? "פעיל" : "לא פעיל";
                            City.Text = customer.CityName.ToString();
                            Street.Text = customer.Street;
                            Zip.Text = customer.Zip;

                            Contact1FirstName.Text = customer.Contact1FirstName;
                            Contact1LastName.Text = customer.Contact1LastName;
                            Contact1Job.Text = customer.Contact1Job;
                            Contact1OfficePhone.Text = customer.Contact1OfficePhone;
                            Contact1CellPhone.Text = customer.Contact1CellPhone;
                            Contact1Email.Text = customer.Contact1Email;

                            if (customer.Contact2Id != null)
                            {
                                Contact2FirstName.Text = customer.Contact2FirstName;
                                Contact2LastName.Text = customer.Contact2LastName;
                                Contact2Job.Text = customer.Contact2Job;
                                Contact2OfficePhone.Text = customer.Contact2OfficePhone;
                                Contact2CellPhone.Text = customer.Contact2CellPhone;
                                Contact2Email.Text = customer.Contact2Email;
                            }


                            Bank.Text = customer.Bank;
                            Branch.Text = customer.Branch;
                            Account.Text = customer.Account;
                            Credit.Text = customer.Credit.ToString();
                            CreditLeft.Text = customer.CreditLeft.ToString();
                            return;
                    }
                }
            }
            Response.Redirect($"./Search.aspx");
        }

        protected void CustomerOrdersRpt_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                OrderSearch order = (OrderSearch)e.Item.DataItem;

                HyperLink orderLink = (HyperLink)e.Item.FindControl("OrderLink");
                orderLink.NavigateUrl = $"~/Dealer/Orders/Order.aspx?id={order.Id}";
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