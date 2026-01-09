using MySql.Data.MySqlClient;
using Org.BouncyCastle.Utilities;
using RecruiterManagement.Models;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace RecruiterManagement.Users
{
    public partial class Index : System.Web.UI.Page
    {

        public List<User> UsersList = new List<User>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedIn"] == null)
            {
                Response.Redirect("/Login");
            }

            else if (!Session["role"].Equals("admin") && !Session["role"].Equals("recruiter") && !Session["role"].Equals("viewer"))
            {
                Response.Redirect("/");
            }
            LoadUsers();

            string action = Request.Params.Get("action");
            string success = Request.Params.Get("success");
            if (!string.IsNullOrEmpty(action) && !string.IsNullOrEmpty(success))
            {
                // Show toast to user if the user is deleted successfully
                if (action.Equals("delete") && success.Equals("true"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'success',title:'Deleted!',text:'User deleted successfully!',timer:1500,showConfirmButton:false});", true);

                }

                if (action.Equals("delete") && success.Equals("false"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'error',title:'Failed!',text:'Failed to delete the user',timer:1500,showConfirmButton:false});", true);

                }

                if (action.Equals("update") && success.Equals("false"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'error',title:'Failed!',text:'Failed to update the user',timer:1500,showConfirmButton:false});", true);
                }

                if (action.Equals("update") && success.Equals("true"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'success',title:'Updated!',text:'User updated successfully',timer:1500,showConfirmButton:false});", true);
                }

                if (action.Equals("adduser") && success.Equals("true"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'success',title:'Added!',text:'User added successfully',timer:1500,showConfirmButton:false});", true);
                }



                ScriptManager.RegisterStartupScript(this, GetType(),
                        "removeQuery",
                "if (window.location.search) { " +
                "   const newUrl = window.location.origin + window.location.pathname;" +
                "   window.history.replaceState({}, document.title, newUrl);" +
                "}", true);
            }
        }

        private void LoadUsers()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query = "SELECT * FROM users LEFT JOIN roles ON users.role_id = roles.id";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                MySqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    User user = new User
                    {
                        Id = Convert.ToInt32(reader["id"]),
                        Name = reader["name"].ToString(),
                        Email = reader["email"].ToString(),
                        Role = reader["role_name"].ToString()
                    };

                    UsersList.Add(user);

                }
            }
        }
    }
}