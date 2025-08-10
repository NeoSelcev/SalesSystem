using SalesSystemWebSite.BLL;
using SalesSystemWebSite.Interfaces;
using System;
using System.Web;
using System.Web.UI;

namespace SalesSystemWebSite.Manager.Items
{
    public partial class Item : Page, IManagerPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string skuString = HttpUtility.ParseQueryString(Request.Url.Query).Get("sku");
            int sku = -1;
            if (int.TryParse(skuString, out sku))
            {
                ItemService itemService = new ItemService();
                Entities.Item item = itemService.GetBySku(sku);
                if (itemService != null)
                {
                    MainBtn.NavigateUrl = $"./Upsert.aspx?id={skuString}";

                    SkuSbj.Text = item.Sku.ToString();
                    NameSbj.Text = item.Name;
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
            Response.Redirect($"./Search.aspx");
        }
    }
}