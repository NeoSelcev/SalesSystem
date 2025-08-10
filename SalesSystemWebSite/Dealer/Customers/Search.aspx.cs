using SalesSystemWebSite.BLL;
using SalesSystemWebSite.Entities;
using SalesSystemWebSite.Interfaces;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesSystemWebSite.Dealer.Customers
{
    public partial class Search : Page, IDealerPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void SearchBtn_Click(object sender, EventArgs e)
        {
            CustomerService customerService = new CustomerService();
            List<CustomerSearch> customers = customerService.GetByIdOrName(String.IsNullOrEmpty(Id.Text) ? (int?)null : int.Parse(Id.Text), Name.Text);
            if (customers.Count > 0)
            {
                SearchResult.Visible = true;
                CustomerSearchRpt.DataSource = customers;
                CustomerSearchRpt.DataBind();
            }
            else
            {
                SearchResult.Visible = false;
            }
        }

        protected void CustomerSearchRpt_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                CustomerSearch customer = (CustomerSearch)e.Item.DataItem;

                HyperLink customerLink = (HyperLink)e.Item.FindControl("CustomerLink");
                customerLink.Text = customer.Id.ToString();
                customerLink.NavigateUrl = $"./Customer.aspx?id={customer.Id}";

                Label customerName = (Label)e.Item.FindControl("CustomerName");
                customerName.Text = customer.Name;

                Label customerStatus = (Label)e.Item.FindControl("CustomerStatus");
                customerStatus.Text = customer.Status == 0 ? "פעיל" : "לא פעיל";
            }
        }
    }
}