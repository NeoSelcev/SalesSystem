using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Collections.Generic;
using System.Reflection;
using System.Linq;

namespace SalesSystemWebSite.DAL
{
    public static class DataBase
    {
        private static string connectionString
        {
            get
            {
                string connectionStringName = ConfigurationManager.AppSettings["connectionStringName"];
                string connectionStringTamplate = ConfigurationManager.ConnectionStrings[connectionStringName].ConnectionString;

                string machineNamePlaceHolder = ConfigurationManager.AppSettings["machineNamePlaceHolder"];
                return connectionStringTamplate.Replace(machineNamePlaceHolder, Environment.MachineName);
            }
        }

        public static void ExecuteStoredProcedure(string storedProcedureName)
        {
            ExecuteStoredProcedure(storedProcedureName, null);
        }

        public static void ExecuteStoredProcedure(string storedProcedureName, Dictionary<string, object> parameters)
        {
            ExecuteSP(storedProcedureName, parameters);
        }

        public static T ExecuteStoredProcedureSingle<T>(string storedProcedureName)
        {
            return ExecuteStoredProcedureSingle<T>(storedProcedureName, null);
        }

        public static T ExecuteStoredProcedureSingle<T>(string storedProcedureName, Dictionary<string, object> parameters)
        {
            DataTable dataTable = ExecuteSP(storedProcedureName, parameters);
            return GetObject<T>(dataTable);
        }

        public static T ExecuteStoredProcedureList<T, Y>(string storedProcedureName)
        {
            return ExecuteStoredProcedureList<T, Y>(storedProcedureName, null);
        }

        public static T ExecuteStoredProcedureList<T, Y>(string storedProcedureName, Dictionary<string, object> parameters)
        {
            DataTable dataTable = ExecuteSP(storedProcedureName, parameters);
            return GetObjects<T, Y>(dataTable);
        }

        

        private static DataTable ExecuteSP(string storedProcedureName, Dictionary<string, object> parameters)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand();
                command.Connection = connection;
                command.CommandText = storedProcedureName;
                command.CommandType = CommandType.StoredProcedure;
                if (parameters != null && parameters.Count > 0)
                {
                    foreach (KeyValuePair<string, object> parameter in parameters)
                    {
                        command.Parameters.AddWithValue($"@{parameter.Key}", parameter.Value);
                    }
                }
                try
                {
                    connection.Open();
                    return GetDataTable(command);
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message, ex.InnerException);
                }
            }
        }

        private static DataTable GetDataTable(SqlCommand command)
        {
            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            sqlDataAdapter.Fill(dataTable);
            dataTable.AcceptChanges();
            return dataTable;
        }

        private static T GetObjects<T, Y>(DataTable dataTable)
        {
            Type type = typeof(T);
            Type itemType = typeof(Y);

            object listObj = Activator.CreateInstance(type);
            if (dataTable.Rows.Count > 0)
            {
                for (int i = 0; i < dataTable.Rows.Count; i++)
                {
                    object singleObj = Activator.CreateInstance(itemType);
                    PropertyInfo[] properties = itemType.GetProperties();
                    foreach (var property in properties)
                    {
                        object propertyValue = null;
                        if (dataTable.Rows[i][property.Name] != DBNull.Value)
                        {
                            propertyValue = dataTable.Rows[i][property.Name];
                        }
                        if (property.PropertyType.IsEnum)
                        {
                            propertyValue = int.Parse(dataTable.Rows[i][property.Name].ToString());
                        }
                        property.SetValue(singleObj, propertyValue);
                    }
                    (listObj as List<Y>).Add((Y)singleObj);
                }

            }
            return (T)listObj;
        }

        private static T GetObject<T>(DataTable dataTable)
        {
            object obj = default(T);
            if (dataTable.Rows.Count > 0)
            {
                DataRow dataRow = dataTable.Rows[0];
                obj = TransformObject<T>(dataRow);
            }
            return (T)obj;
        }

        private static T TransformObject<T>(DataRow dataRow)
        {
            Type type = typeof(T);
            object obj = Activator.CreateInstance(type);

            PropertyInfo[] properties = type.GetProperties();
            foreach (var property in properties)
            {
                object propertyValue = null;
                if (dataRow[property.Name] != DBNull.Value)
                {
                    propertyValue = dataRow[property.Name];
                }
                if (property.PropertyType.IsEnum)
                {
                    propertyValue = int.Parse(dataRow[property.Name].ToString());
                }
                property.SetValue(obj, propertyValue);
            }

            return (T)obj;
        }
    }
}
