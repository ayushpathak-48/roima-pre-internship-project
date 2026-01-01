using MySql.Data.MySqlClient;
using RecruiterManagement.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace RecruiterManagement.Skills
{
    public partial class Update : System.Web.UI.Page
    {

        public List<Role> RolesList = new List<Role>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string userId = Request.Params.Get("id");
                if (string.IsNullOrEmpty(userId))
                {
                    Response.Redirect("/Users?action=update&success=false");
                    return;
                }

                using (MySqlConnection conn = DBConn.GetConnection())
                {
                    string queryToFetchUser = "select * from skills where id=" + userId;
                    MySqlCommand cmd = new MySqlCommand(queryToFetchUser, conn);
                    MySqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtName.Text = reader["name"].ToString();
                    }
                    else
                    {
                        Response.Redirect("/Skills?action=update&success=false");
                        return;
                    }
                }
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string id = Request.Params.Get("id");
                if (string.IsNullOrEmpty(id))
                {
                    Response.Redirect("/Skills?action=update&success=false");
                    return;
                }

                string name = txtName.Text;
                using (MySqlConnection conn = DBConn.GetConnection())
                {

                    MySqlCommand isEmailExistsCmd = new MySqlCommand("SELECT name from skills where name=@Name and id != @Id", conn);
                    isEmailExistsCmd.Parameters.AddWithValue("@Id", id);
                    isEmailExistsCmd.Parameters.AddWithValue("@Name", name);
                    MySqlDataReader reader = isEmailExistsCmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        lblError.Text = "Role with this name already exists";
                        return;
                    }
                    lblError.Text = "";
                    reader.Close();

                    string query = "Update skills SET name=@Name where id=@Id";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.Parameters.AddWithValue("@Name", name);
                    int rows = cmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        Response.Redirect("/Skills?success=true&action=update");
                    }
                    else
                    {
                        lblError.Text = "Failed to create user! Please try again.";
                    }
                }

            }
        }
    }
}