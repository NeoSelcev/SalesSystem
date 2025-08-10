using System;

namespace SalesSystemWebSite.Entities
{
    public class OrderSearch
    {
        public int Id { get; set; }        
        public DateTime DateCreated { get; set; }
        public DateTime ShipmentDate { get; set; }
        public int Status { get; set; }
        public int TotalPrice { get; set; }
    }
}