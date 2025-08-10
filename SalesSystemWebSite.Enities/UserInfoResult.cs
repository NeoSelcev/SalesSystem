namespace SalesSystemWebSite.Entities
{
    public class UserInfoResult
    {
        public int Id { get; set; }
		public string Email { get; set; }
		public string FirstName { get; set; }
		public string LastName { get; set; }
		public string CellPhone { get; set; }
		public string Phone { get; set; }
        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public string RoleDescription { get; set; }
    }
}