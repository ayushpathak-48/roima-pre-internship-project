using MySql.Data.MySqlClient;
using RecruiterManagement.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement.Reviewers
{
    public partial class Add : System.Web.UI.Page
    {
        public List<Role> RolesList = new List<Role>();
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string name = txtName.Text;
                using (MySqlConnection conn = DBConn.GetConnection())
                {
                    string query = "INSERT INTO skills (`name`) VALUES (@Name)";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Name", name);
                    int rows = cmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        lblSuccess.Text = "Skill Created Successfully";
                        Response.Redirect("/Skills?success=true&action=addskill");
                    }
                    else
                    {
                        lblError.Text = "Failed to create skill! Please try again.";
                    }
                }

            }
        }

        
    }
}