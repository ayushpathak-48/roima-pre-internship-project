using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement.Jobs
{
    public partial class Delete : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            Response.Write(id);
            if (id.Length == 0)
            {
                Response.Redirect("/Jobs?action=delete&success=false");
            }
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                MySqlCommand deleteJobSkillsCMD = new MySqlCommand("DELETE FROM job_skills where job_id=@Id", conn);
                deleteJobSkillsCMD.Parameters.AddWithValue("@Id", id);
                int isSkillsDeleted = deleteJobSkillsCMD.ExecuteNonQuery();
                if (isSkillsDeleted <= 0) Response.Redirect("/Jobs?action=delete&success=false");
                MySqlCommand cmd = new MySqlCommand("DELETE FROM jobs where id=@Id", conn);
                cmd.Parameters.AddWithValue("@Id", id);
                int isDeleted = cmd.ExecuteNonQuery();
                if (isDeleted > 0)
                {
                    Response.Redirect("/Jobs?action=delete&success=true");
                }
                else
                {
                    Response.Redirect("/Jobs?action=delete&success=false");
                }
            }
        }
    }
}