using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace RecruiterManagement
{
    public class DBConn
    {
        private static string connectionString = ConfigurationManager.ConnectionStrings["MySqlConn"].ConnectionString;

        public static MySqlConnection GetConnection()
        {
            MySqlConnection conn = new MySqlConnection(connectionString);   
            conn.Open();
            return conn;
        }
    }
}