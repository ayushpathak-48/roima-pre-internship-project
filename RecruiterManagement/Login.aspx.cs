using MySql.Data.MySqlClient;
using System;
using BCrypt.Net;

namespace RecruiterManagement
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedIn"] != null)
            {
                Response.Redirect("/");
            }

        }
        protected void btnSignIn_Click(object sender, EventArgs e)
        {

            if (IsPostBack)
            {
                string email = txtEmail.Text;
                string password = txtPassword.Text;
                string hashedPassword = BCrypt.Net.BCrypt.HashPassword(password);
                using (MySqlConnection conn = DBConn.GetConnection())
                {
                    string query = "SELECT users.email,users.password,users.name,roles.role_name FROM users RIGHT JOIN roles ON users.role_id = roles.id WHERE email=@Email";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Email", email);
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {   
                            string dbPassword = reader["password"].ToString();
                            bool isPasswordValid = BCrypt.Net.BCrypt.Verify(password, dbPassword);
                            if (isPasswordValid)
                            {
                                String role = reader["role_name"].ToString();
                                Session["email"] = email;
                                Session["name"] = reader["name"];
                                Session["loggedIn"] = true;
                                Session["role"] = role;
                                if(role == "recruiter") Response.Redirect("/Jobs");
                                Response.Redirect("/");
                            }
                            else
                            {
                                lblError.Text = "Invalid email or password!";
                            }
                        }
                        else
                        {
                            lblError.Text = "Invalid email or password!";
                        }
                    }
                }
            }
        }
    }

}
