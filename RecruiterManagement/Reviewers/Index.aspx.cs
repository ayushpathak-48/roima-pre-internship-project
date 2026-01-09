using MySql.Data.MySqlClient;
using RecruiterManagement.Models;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace RecruiterManagement.Reviewers
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
                if (action.Equals("delete") && success.Equals("true"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'success',title:'Deleted!',text:'Reviewer deleted successfully!',timer:1500,showConfirmButton:false});", true);
                }

                else if (action.Equals("delete") && success.Equals("false"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'error',title:'Failed!',text:'Failed to delete the reviewer',timer:1500,showConfirmButton:false});", true);

                }

                else if (action.Equals("update") && success.Equals("false"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'error',title:'Failed!',text:'Failed to update the reviewer',timer:1500,showConfirmButton:false});", true);
                }

                else if (action.Equals("update") && success.Equals("true"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'success',title:'Updated!',text:'Reviewer updated successfully',timer:1500,showConfirmButton:false});", true);
                }

                else if (action.Equals("addskill") && success.Equals("true"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'success',title:'Added!',text:'Reviewer added successfully',timer:1500,showConfirmButton:false});", true);
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

                    UsersList.Add(user);
                }
            }
        }
    }
}