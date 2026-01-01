using MySql.Data.MySqlClient;
using RecruiterManagement.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement.Jobs
{
    public partial class AssignReviewer : System.Web.UI.Page
    {
        public List<User> ReviewersList = new List<User>();
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadReviewers();
        }

        private void LoadReviewers()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query = "SELECT * FROM users WHERE role_id=5";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                MySqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    User user = new User
                    {
                        Id = Convert.ToInt32(reader["id"]),
                        Name = reader["name"].ToString(),
                        Email = reader["email"].ToString(),
                    };
                    ReviewersList.Add(user);
                }
            }
        }

        protected void btnAssign_Command(object sender, EventArgs e)
        {

        }
    }
}