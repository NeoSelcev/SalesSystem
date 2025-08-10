using SalesSystemWebSite.DAL;
using SalesSystemWebSite.Entities;
using System.Collections.Generic;

namespace SalesSystemWebSite.BLL
{
    public class ItemService
    {
        public List<Category> GetCategories()
        {
            string storedProcedureName = "Item_GetCategoies";
            List<Category> categories = DataBase.ExecuteStoredProcedureList<List<Category>, Category>(storedProcedureName);
            return categories;
        }

        public List<Color> GetColors()
        {
            string storedProcedureName = "Item_GetColors";
            List<Color> colors = DataBase.ExecuteStoredProcedureList<List<Color>, Color>(storedProcedureName);
            return colors;
        }

        public Item GetBySku(int sku)
        {
            string storedProcedureName = "Item_FindBySku";
            Dictionary<string, object> parameters = new Dictionary<string, object>()
            {
                { "sku", sku }
            };
            Item item = DataBase.ExecuteStoredProcedureSingle<Item>(storedProcedureName, parameters);
            return item;
        }

        public List<ItemSearch> GetBySkuOrName(int? sku, string name)
        {
            string storedProcedureName = "Item_FindBySkuOrName";
            Dictionary<string, object> parameters = new Dictionary<string, object>()
            {
                { "sku", sku },
                { "name", name }
            };
            List<ItemSearch> itemSearch = DataBase.ExecuteStoredProcedureList<List<ItemSearch>, ItemSearch>(storedProcedureName, parameters);
            return itemSearch;
        }

        public int Upsert(int? sku, int categoryId, string name, string description, int price, int colorId,
                        string height, string width, string length, string weight,
                        int available, string warehousePlace, string imageUrl)

        {
            string storedProcedureName = "Item_Upsert";
            Dictionary<string, object> parameters = new Dictionary<string, object>()
            {
                { "sku", sku },
                { "categoryId", categoryId },
                { "name", name },
                { "description", description },
                { "price", price },
                { "colorId", colorId },
                { "height", height },
                { "width", width },
                { "length", length },
                { "weight", weight },
                { "available", available },
                { "warehousePlace", warehousePlace },
                { "imageUrl", imageUrl }
            };
            ItemInsert itemInsert = DataBase.ExecuteStoredProcedureSingle<ItemInsert>(storedProcedureName, parameters);
            return itemInsert.Sku;
        }
    }
}
