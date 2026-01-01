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

namespace RecruiterManagement.Users
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

                loadRoles();
                using (MySqlConnection conn = DBConn.GetConnection())
                {
                    string queryToFetchUser = "select * from users where id=" + userId;
                    MySqlCommand cmd = new MySqlCommand(queryToFetchUser, conn);
                    MySqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtEmail.Text = reader["email"].ToString();
                        txtName.Text = reader["name"].ToString();
                        RoleDropdown.Text = reader["role_id"].ToString();
                    }
                    else
                    {
                        Response.Redirect("/Users?action=update&success=false");
                        return;
                    }
                }
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string userId = Request.Params.Get("id");
                if (string.IsNullOrEmpty(userId))
                {
                    Response.Redirect("/Users?action=update&success=false");
                    return;
                }

                string email = txtEmail.Text;
                string name = txtName.Text;
                int roleId = Convert.ToInt32(RoleDropdown.SelectedItem.Value);
                using (MySqlConnection conn = DBConn.GetConnection())
                {

                    MySqlCommand isEmailExistsCmd = new MySqlCommand("SELECT email from users where email=@Email and id != @Id", conn);
                    isEmailExistsCmd.Parameters.AddWithValue("@Email", email);
                    isEmailExistsCmd.Parameters.AddWithValue("@Id", userId);
                    MySqlDataReader reader = isEmailExistsCmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        lblError.Text = "Email already used by Other! Try different email";
                        return;
                    }
                    lblError.Text = "";
                    reader.Close();

                    string query = "Update users SET email=@Email,name=@Name,role_id=@RoleId where id=@UserId";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@RoleId", roleId);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    int rows = cmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        lblSuccess.Text = "User Created Successfully";
                        Response.Redirect("/Users?success=true&action=update");
                    }
                    else
                    {
                        lblError.Text = "Failed to create user! Please try again.";
                    }
                }

            }
        }


        private void loadRoles()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query = "Select * from roles";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                MySqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Role role = new Role
                    {
                        Id = Convert.ToInt32(reader["id"]),
                        Name = reader["role_name"].ToString()
                    };
                    RolesList.Add(role);
                }
                RoleDropdown.DataSource = RolesList;
                RoleDropdown.DataTextField = "Name";
                RoleDropdown.DataValueField = "Id";
                RoleDropdown.DataBind();
            }
        }
    }
}