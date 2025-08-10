using SalesSystemWebSite.BLL;
using SalesSystemWebSite.Entities;
using SalesSystemWebSite.Interfaces;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesSystemWebSite.Manager.Items
{
    public partial class Search : Page, IManagerPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SearchBtn_Click(object sender, EventArgs e)
        {
            ItemService itemService = new ItemService();
            List<ItemSearch> items = itemService.GetBySkuOrName(String.IsNullOrEmpty(SkuText.Text) ? (int?)null : int.Parse(SkuText.Text), NameText.Text);
            if (items.Count > 0)
            {
                SearchResult.Visible = true;
                ItemSearchRpt.DataSource = items;
                ItemSearchRpt.DataBind();
            }
            else
            {
                SearchResult.Visible = false;
            }
        }

        protected void ItemSearchRpt_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                ItemSearch item = (ItemSearch)e.Item.DataItem;

                HyperLink skuLink = (HyperLink)e.Item.FindControl("Sku");
                skuLink.Text = item.Sku.ToString();
                skuLink.NavigateUrl = $"./Item.aspx?sku={item.Sku}";

                Label name = (Label)e.Item.FindControl("Name");
                name.Text = item.Name;

                Image image = (Image)e.Item.FindControl("Image");
                image.ImageUrl = item.ImageUrl;

                Label available = (Label)e.Item.FindControl("Available");
                available.Text = item.Available.ToString();
            }
        }
    }
}