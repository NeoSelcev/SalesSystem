namespace SalesSystemWebSite.Entities
{
    public class Role
	{
        public Role(int id, string roleName, string description)
        {
            Id = id;
            RoleName = roleName;
            Description = description;
        }
        public int Id { get; set; }
		public string RoleName { get; set; }
		public string Description { get; set; }

        public UserRole UserRole
        {
            get
            {
                return (UserRole)Id;
            }
        }
    }
}