using SalesSystemWebSite.DAL;
using SalesSystemWebSite.Entities;
using System.Collections.Generic;

namespace SalesSystemWebSite.BLL
{
    public class UserService
    {        
        public UserInfo Login(string username, string password)
        {
            UserInfo userInfo = null;
            string storedProcedureName = "User_Authenticate";
            Dictionary<string, object> parameters = new Dictionary<string, object>() 
            { 
                { "email", username }, 
                { "password", password } 
            };
            UserInfoResult userInfoResult = DataBase.ExecuteStoredProcedureSingle<UserInfoResult>(storedProcedureName, parameters);
            if(userInfoResult != null)
            {
                userInfo = new UserInfo(userInfoResult);
            }            
            return userInfo;
        }
    }
}
