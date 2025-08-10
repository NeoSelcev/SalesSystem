using SalesSystemWebSite.BLL;
using SalesSystemWebSite.Entities;
using SalesSystemWebSite.Interfaces;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesSystemWebSite.Manager.Items
{
    public partial class Upsert : Page, IManagerPage
    {
        ItemService itemService;
        protected void Page_Load(object sender, EventArgs e)
        {
            itemService = new ItemService();
            if (!IsPostBack)
            {
                LoadCategories();
                LoadColors();
                LoadItemInfo();
            }
        }

        private void LoadCategories()
        {
            List<Category> categories = itemService.GetCategories();
            List<ListItem> dataSource = new List<ListItem>();
            dataSource.Add(new ListItem("קטגוריה"));
            foreach (Category category in categories)
            {
                dataSource.Add(new ListItem(category.Name, category.Id.ToString()));
            }
            Category.DataSource = dataSource;
            Category.DataBind();
        }

        private void LoadColors()
        {
            List<Color> colors = itemService.GetColors();
            List<ListItem> dataSource = new List<ListItem>();
            dataSource.Add(new ListItem("צבע"));
            foreach (Color color in colors)
            {
                dataSource.Add(new ListItem(color.Name, color.Id.ToString()));
            }
            Color.DataSource = dataSource;
            Color.DataBind();
        }

        private void LoadItemInfo()
        {
            string skuString = HttpUtility.ParseQueryString(Request.Url.Query).Get("sku");
            //string skuString = "1";
            int sku = -1;
            if (int.TryParse(skuString, out sku))
            {
                Entities.Item item = itemService.GetBySku(sku);
                if (item != null)
                {
                    Sku.Text = item.Sku.ToString();
                    Category.Text = item.CategoryName;
                    Name.Text = item.Name;
                    Description.Text = item.Description;
                    Price.Text = item.Price.ToString();
                    Color.Text = item.ColorName;
                    Height.Text = item.Height;
                    Width.Text = item.Width;
                    Length.Text = item.Length;
                    Weight.Text = item.Weight;
                    Available.Text = item.Available.ToString();
                    WarehousePlace.Text = item.WarehousePlace;
                    Image.ImageUrl = item.ImageUrl;
                    return;
                }
            }
            SkuWraper.Visible = false;
        }

        protected void MainBtn_Click(object sender, EventArgs e)
        {
            int? sku = String.IsNullOrEmpty(Sku.Text) ? (int?)null : int.Parse(Sku.Text);
            int customerId = itemService.Upsert(sku, int.Parse(Category.SelectedValue), Name.Text, Description.Text, int.Parse(Price.Text), int.Parse(Color.SelectedValue),
                                                Height.Text, Width.Text, Length.Text, Weight.Text, int.Parse(Available.Text), WarehousePlace.Text, ImageUrl.Text);
            Response.Redirect($"./Item.aspx?sku={customerId}");
        }
    }
}