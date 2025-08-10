namespace SalesSystemWebSite.Entities
{
    public class UserInfo
    {
        public UserInfo(UserInfoResult userInfoResult)
        {
            Id = userInfoResult.Id;
            Email = userInfoResult.Email;
            FirstName = userInfoResult.FirstName;
            LastName = userInfoResult.LastName;
            CellPhone = userInfoResult.CellPhone;
            Phone = userInfoResult.Phone;
            Role = new Role(userInfoResult.RoleId, userInfoResult.RoleName, userInfoResult.RoleDescription);
        }

        public int Id { get; set; }
		public string Email { get; set; }
		public string FirstName { get; set; }
		public string LastName { get; set; }
		public string CellPhone { get; set; }
		public string Phone { get; set; }
		public Role Role { get; set; }

		public string FullName
        {
			get
            {
                return $"{FirstName} {LastName}";
            }
        }
    }
}