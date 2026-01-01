using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement.Users
{
    public partial class Delete : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string userId = Request.QueryString["id"];
            Response.Write(userId);
            if (userId.Length == 0)
            {
                Response.Redirect("/Users?action=delete&success=false");
            }
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                MySqlCommand cmd = new MySqlCommand("DELETE FROM users where id=@Id", conn);
                cmd.Parameters.AddWithValue("@Id", userId);
                int userDeleted = cmd.ExecuteNonQuery();
                if (userDeleted > 0)
                {
                    Response.Redirect("/Users?action=delete&success=true");
                }
                else
                {
                    Response.Redirect("/Users?action=delete&success=false");
                }
            }
        }
    }
}