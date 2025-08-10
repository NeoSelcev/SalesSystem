namespace SalesSystemWebSite.Entities
{
    public class Item
    {
        public int Sku { get; set; }
        public int CategoryId { get; set; }
        public string CategoryName { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int Price { get; set; }
        public int ColorId { get; set; }
        public string ColorName { get; set; }
        public string Height { get; set; }
        public string Width { get; set; }
        public string Length { get; set; }
        public string Weight { get; set; }
        public int Available { get; set; }
        public string WarehousePlace { get; set; }
        public string ImageUrl { get; set; }
    }
}