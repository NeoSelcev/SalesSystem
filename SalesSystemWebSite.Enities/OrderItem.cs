using System;

namespace SalesSystemWebSite.Entities
{
    [Serializable]
    public class OrderItem
    {
        public int Id { get; set; }
        public int Sku { get; set; }
        public string Name { get; set; }
        public string ImageUrl { get; set; }
        public int Available { get; set; }
        public int Amount { get; set; }
        public int ActualAmount { get; set; }
        public int Price { get; set; }
        public string WarehousePlace { get; set; }
    }
}