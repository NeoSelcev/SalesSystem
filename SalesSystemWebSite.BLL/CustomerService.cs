using SalesSystemWebSite.DAL;
using SalesSystemWebSite.Entities;
using System.Collections.Generic;

namespace SalesSystemWebSite.BLL
{
    public class CustomerService
    {
        public List<City> GetCities()
        {
            string storedProcedureName = "Customer_GetCities";
            List<City> city = DataBase.ExecuteStoredProcedureList<List<City>, City>(storedProcedureName);
            return city;
        }

        public Customer GetById(int id)
        {
            string storedProcedureName = "Customer_FindById";
            Dictionary<string, object> parameters = new Dictionary<string, object>()
            {
                { "id", id }
            };
            Customer customer = DataBase.ExecuteStoredProcedureSingle<Customer>(storedProcedureName, parameters);
            return customer;
        }

        public List<CustomerSearch> GetByIdOrName(int? id, string name)
        {
            string storedProcedureName = "Customer_FindByIdOrName";
            Dictionary<string, object> parameters = new Dictionary<string, object>()
            {
                { "id", id },
                { "name", name }
            };
            List<CustomerSearch> customer = DataBase.ExecuteStoredProcedureList<List<CustomerSearch>, CustomerSearch>(storedProcedureName, parameters);
            return customer;
        }

        public int Upsert(int? id, string name, int dealerId, int status, int cityCode, string street, int zip,
                                int? contact1Id, string contact1FirstName, string contact1LastName, string contact1Job, string contact1OfficePhone, string contact1CellPhone, string contact1Email,
                                int? contact2Id, string contact2FirstName, string contact2LastName, string contact2Job, string contact2OfficePhone, string contact2CellPhone, string contact2Email,
                                string bank, string branch, string account, int credit)
        {
            string storedProcedureName = "Customer_Upsert";
            Dictionary<string, object> parameters = new Dictionary<string, object>()
            {
                {"id", id},
                {"name", name},
                {"dealerId", dealerId},
                {"status", status},
                {"cityCode", cityCode},
                {"street", street},
                {"zip", zip},
                {"contact1Id", contact1Id},
                {"contact1FirstName", contact1FirstName},
                {"contact1LastName", contact1LastName},
                {"contact1Job", contact1Job},
                {"contact1OfficePhone", contact1OfficePhone},
                {"contact1CellPhone", contact1CellPhone},
                {"contact1Email", contact1Email},
                {"contact2Id", contact2Id},
                {"contact2FirstName", contact2FirstName},
                {"contact2LastName", contact2LastName},
                {"contact2Job", contact2Job},
                {"contact2OfficePhone", contact2OfficePhone},
                {"contact2CellPhone", contact2CellPhone},
                {"contact2Email", contact2Email},
                {"bank", bank},
                {"branch", branch},
                {"account", account},
                {"credit", credit}
            };
            CustomerInsert insertCustomer = DataBase.ExecuteStoredProcedureSingle<CustomerInsert>(storedProcedureName, parameters);
            return insertCustomer.Id;
        }
    }
}
