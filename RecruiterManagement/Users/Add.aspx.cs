using MySql.Data.MySqlClient;
using RecruiterManagement.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement.Users
{
    public partial class Add : System.Web.UI.Page
    {
        public List<Role> RolesList = new List<Role>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedIn"] == null)
            {
                Response.Redirect("/Login");
            }

            else if (!Session["role"].Equals("admin") && !Session["role"].Equals("recruiter") )
            {
                Response.Redirect("/");
            }

            if (!IsPostBack)
            {
                loadRoles();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string email = txtEmail.Text;
                string password = txtPassword.Text;
                string name = txtName.Text;
                int roleId = Convert.ToInt32(RoleDropdown.SelectedItem.Value);
                string hashedPassword = BCrypt.Net.BCrypt.HashPassword(password);
                using (MySqlConnection conn = DBConn.GetConnection())
                {

                    MySqlCommand isEmailExistsCmd = new MySqlCommand("SELECT email from users where email=@Email", conn);
                    isEmailExistsCmd.Parameters.AddWithValue("@Email", email);
                    MySqlDataReader reader = isEmailExistsCmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        lblError.Text = "Email already used! Try different email";
                        return;
                    }
                    lblError.Text = "";
                    reader.Close();
                    string query = "INSERT INTO users (`email`,`name`,`role_id`,`password`) VALUES (@Email,@Name,@RoleId,@Password)";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@RoleId", roleId);
                    cmd.Parameters.AddWithValue("@Password", hashedPassword);
                    int rows = cmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        lblSuccess.Text = "User Created Successfully";
                        Response.Redirect("/Users?success=true&action=adduser");
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