using System;

namespace SalesSystemWebSite.Entities
{
    public class OrderResult
    {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public string CustomerName { get; set; }
        public int Status { get; set; }
        public int Discount { get; set; }
    }
}