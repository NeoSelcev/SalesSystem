using SalesSystemWebSite.DAL;
using SalesSystemWebSite.Entities;
using System;
using System.Collections.Generic;

namespace SalesSystemWebSite.BLL
{
    public class OrderService
    {
        public Order GetById(int id)
        {
            string storedProcedureName = "Order_FindById";
            Dictionary<string, object> parameters = new Dictionary<string, object>()
            {
                { "id", id }
            };
            OrderResult orderResult = DataBase.ExecuteStoredProcedureSingle<OrderResult>(storedProcedureName, parameters);

            List<OrderItem> orderItems = GetOrderItemsByOrderId(orderResult.Id);

            Order order = new Order()
            {
                Id = orderResult.Id,
                CustomerId = orderResult.CustomerId,
                CustomerName = orderResult.CustomerName,
                Discount = orderResult.Discount,
                Status = orderResult.Status
            };
            order.orderItems = orderItems;

            return order;
        }

        public List<OrderItem> GetOrderItemsByOrderId(int orderId)
        {
            string storedProcedureName = "OrderItem_FindByOrderId";
            Dictionary<string, object> parameters = new Dictionary<string, object>()
            {
                { "orderId", orderId }
            };
            List<OrderItem> orderItems = DataBase.ExecuteStoredProcedureList<List<OrderItem>, OrderItem>(storedProcedureName, parameters);
            return orderItems;
        }

        public List<OrderSearch> GetByIdOrDateOrStatus(int? id, DateTime? date, int? status)
        {
            string storedProcedureName = "Order_FindByIdOrDateOrStatus";
            Dictionary<string, object> parameters = new Dictionary<string, object>()
            {
                { "id", id },
                { "date", date },
                { "status", status }
            };
            List<OrderSearch> orders = DataBase.ExecuteStoredProcedureList<List<OrderSearch>, OrderSearch>(storedProcedureName, parameters);
            return orders;
        }

        public List<OrderSearch> GetByCustomerId(int customerId)
        {
            string storedProcedureName = "Order_FindByCustomerId";
            Dictionary<string, object> parameters = new Dictionary<string, object>()
            {
                { "customerId", customerId }
            };
            List<OrderSearch> orders = DataBase.ExecuteStoredProcedureList<List<OrderSearch>, OrderSearch>(storedProcedureName, parameters);
            return orders;
        }

        public int Upsert(int? Id, int customerId, int status, int discount, List<OrderItem> orderItems)
        {
            string storedProcedureName = "Order_Upsert";
            Dictionary<string, object> parameters = new Dictionary<string, object>()
            {
                { "id", Id },
                { "customerId", customerId },
                { "status", status },
                { "discount", discount }
            };
            OrderInsert orderInsert = DataBase.ExecuteStoredProcedureSingle<OrderInsert>(storedProcedureName, parameters);

            RemoveOrderItems(orderInsert.Id);

            foreach (OrderItem orderItem in orderItems)
            {
                InsertOrderItem(orderInsert.Id, orderItem);
            }
            return orderInsert.Id;
        }

        private void RemoveOrderItems(int orderId)
        {
            string storedProcedureName = "OrderItem_RemoveByOrderId";
            Dictionary<string, object> parameters = new Dictionary<string, object>()
            {
                { "orderId", orderId }
            };
            DataBase.ExecuteStoredProcedure(storedProcedureName, parameters);
        }

        private void InsertOrderItem(int orderId, OrderItem orderItem)
        {
            string storedProcedureName = "OrderItem_Insert";
            Dictionary<string, object> parameters = new Dictionary<string, object>()
            {
                { "orderId", orderId },
                { "sku", orderItem.Sku },
                { "amount", orderItem.Amount }
            };
            DataBase.ExecuteStoredProcedure(storedProcedureName, parameters);
        }

        public void UpdateOrderStatusAndActualAmounts(int orderId, int status, Dictionary<int, int> updatedOrderItem)
        {
            UpdateOrderStatus(orderId, status);
            UpdateOrderItemsActualAmount(updatedOrderItem);
        }

        private void UpdateOrderStatus(int orderId, int status)
        {
            string storedProcedureName = "Order_UpdateStatus";
            Dictionary<string, object> parameters = new Dictionary<string, object>()
            {
                { "id", orderId },
                { "status", status }
            };
            DataBase.ExecuteStoredProcedure(storedProcedureName, parameters);
        }

        private void UpdateOrderItemsActualAmount(Dictionary<int, int> updatedOrderItem)
        {
            foreach (KeyValuePair<int, int> orderItem in updatedOrderItem)
            {
                string storedProcedureName = "OrderItem_UpdateActualAmount";
                Dictionary<string, object> parameters = new Dictionary<string, object>()
                {
                    { "id", orderItem.Key },
                    { "actualAmount", orderItem.Value }
                };
                DataBase.ExecuteStoredProcedure(storedProcedureName, parameters);
            }
        }
    }
}
