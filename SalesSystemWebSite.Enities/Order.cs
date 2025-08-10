using System;
using System.Collections.Generic;

namespace SalesSystemWebSite.Entities
{
    public class Order: OrderResult
    {
        public List<OrderItem> orderItems { get; set; }
    }
}