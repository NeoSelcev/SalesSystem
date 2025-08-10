namespace SalesSystemWebSite.Entities
{
    public class Customer
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int DealerId { get; set; }
        public string DealerName { get; set; }
        public int Status { get; set; }
        public int CityCode { get; set; }
        public string CityName { get; set; }
        public string Street { get; set; }
        public string Zip { get; set; }

        public int? Contact1Id { get; set; }
        public string Contact1FirstName { get; set; }
        public string Contact1LastName { get; set; }
        public string Contact1Job { get; set; }
        public string Contact1OfficePhone { get; set; }
        public string Contact1CellPhone { get; set; }
        public string Contact1Email { get; set; }

        public int? Contact2Id { get; set; }
        public string Contact2FirstName { get; set; }
        public string Contact2LastName { get; set; }
        public string Contact2Job { get; set; }
        public string Contact2OfficePhone { get; set; }
        public string Contact2CellPhone { get; set; }
        public string Contact2Email { get; set; }

        public string Bank { get; set; }
        public string Branch { get; set; }
        public string Account { get; set; }
        public int Credit { get; set; }
        public int CreditLeft { get; set; }
    }
}