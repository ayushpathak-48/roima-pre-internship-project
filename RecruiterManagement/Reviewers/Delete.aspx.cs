using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement.Reviewers
{
    public partial class Delete : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            Response.Write(id);
            if (id.Length == 0)
            {
                Response.Redirect("/Skills?action=delete&success=false");
            }
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                MySqlCommand cmd = new MySqlCommand("DELETE FROM skills where id=@Id", conn);
                cmd.Parameters.AddWithValue("@Id", id);
                int isDeleted = cmd.ExecuteNonQuery();
                if (isDeleted > 0)
                {
                    Response.Redirect("/Skills?action=delete&success=true");
                }
                else
                {
                    Response.Redirect("/Skills?action=delete&success=false");
                }
            }
        }
    }
}