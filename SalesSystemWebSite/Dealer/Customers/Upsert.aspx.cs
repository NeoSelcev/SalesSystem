using SalesSystemWebSite.BLL;
using SalesSystemWebSite.Entities;
using SalesSystemWebSite.Interfaces;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesSystemWebSite.Dealer.Customers
{
    public partial class Upsert : Page, IDealerPage
    {
        CustomerService customerService;
        protected void Page_Load(object sender, EventArgs e)
        {
            customerService = new CustomerService();

            if (!IsPostBack)
            {
                LoadCities();
                LoadCustomerInfo();
            }            
        }

        private void LoadCities()
        {
            List<Entities.City> cities = customerService.GetCities();
            List<ListItem> dataSource = new List<ListItem>();
            dataSource.Add(new ListItem("עיר"));
            foreach (Entities.City city in cities)
            {
                dataSource.Add(new ListItem(city.Name, city.Code.ToString()));
            }
            City.DataSource = dataSource;
            City.DataBind();
        }

        private void LoadCustomerInfo()
        {
            string idString = HttpUtility.ParseQueryString(Request.Url.Query).Get("id");
            int id = -1;
            if (int.TryParse(idString, out id))
            {
                Entities.Customer customer = customerService.GetById(id);
                if (customer != null)
                {
                    Id.Text = customer.Id.ToString();
                    Name.Text = customer.Name;
                    DealerIdHidden.Value = customer.DealerId.ToString();
                    DealerName.Text = customer.DealerName;
                    Status.SelectedValue = customer.Status.ToString();
                    CityHidden.Value = customer.CityCode.ToString();
                    City.SelectedValue = customer.CityCode.ToString();
                    Street.Text = customer.Street;
                    Zip.Text = customer.Zip;

                    Contact1IdHidden.Value = customer.Contact1Id.ToString();
                    Contact1FirstName.Text = customer.Contact1FirstName;
                    Contact1LastName.Text = customer.Contact1LastName;
                    Contact1Job.Text = customer.Contact1Job;
                    Contact1OfficePhone.Text = customer.Contact1OfficePhone;
                    Contact1CellPhone.Text = customer.Contact1CellPhone;
                    Contact1Email.Text = customer.Contact1Email;

                    if (customer.Contact2Id != null)
                    {
                        Contact2IdHidden.Value = customer.Contact2Id.ToString();
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
            if (!bool.Parse(ConfigurationManager.AppSettings["allowAnonymousAtAllPages"]))
            {
                UserInfo userInfo = (UserInfo)HttpContext.Current.Session["UserInfo"];
                DealerName.Text = userInfo.FullName;
                DealerIdHidden.Value = userInfo.Id.ToString();
            }
            IdWraper.Visible = false;
        }

        protected void MainBtn_Click(object sender, EventArgs e)
        {
            int? id = String.IsNullOrEmpty(Id.Text) ? (int?)null : int.Parse(Id.Text);
            int? contact1Id = String.IsNullOrEmpty(Contact1IdHidden.Value) ? (int?)null : int.Parse(Contact1IdHidden.Value);
            int? contact2Id = String.IsNullOrEmpty(Contact2IdHidden.Value) ? (int?)null : int.Parse(Contact2IdHidden.Value);
            int customerId = customerService.Upsert(id, Name.Text, int.Parse(DealerIdHidden.Value), int.Parse(Status.SelectedValue), int.Parse(City.SelectedValue), Street.Text, int.Parse(Zip.Text),
                                            contact1Id, Contact1FirstName.Text, Contact1LastName.Text, Contact1Job.Text, Contact1OfficePhone.Text, Contact1CellPhone.Text, Contact1Email.Text,
                                            contact2Id, Contact2FirstName.Text, Contact2LastName.Text, Contact2Job.Text, Contact2OfficePhone.Text, Contact2CellPhone.Text, Contact2Email.Text,
                                            Bank.Text, Branch.Text, Account.Text, int.Parse(CreditLeft.Text));
            Response.Redirect($"./Customer.aspx?id={customerId}");
        }
    }
}