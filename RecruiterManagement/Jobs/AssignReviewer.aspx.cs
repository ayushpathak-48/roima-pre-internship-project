using MySql.Data.MySqlClient;
using Org.BouncyCastle.Utilities;
using RecruiterManagement.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace RecruiterManagement.Jobs
{
    public partial class AssignReviewer : System.Web.UI.Page
    {
        private int jobId;
        public int assignedReviewerId;
        protected void Page_Load(object sender, EventArgs e)
        {
            jobId = Convert.ToInt32(Request.Params["id"]);
            if (!IsPostBack)
            {
                LoadReviewers();
            }
        }

        private void LoadReviewers()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query2 = "SELECT assigned_reviewer FROM jobs WHERE id=@JobId";
                MySqlCommand cmd2 = new MySqlCommand(query2, conn);
                cmd2.Parameters.AddWithValue("JobId", jobId);
                MySqlDataReader reader2 = cmd2.ExecuteReader();
                if (reader2.Read())
                {
                    assignedReviewerId = Convert.ToInt32(reader2["assigned_reviewer"]);
                }
                reader2.Close();


                string query = "SELECT * FROM users WHERE role_id=5";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                MySqlDataReader reader = cmd.ExecuteReader();
                rptReviewers.DataSource = reader;
                rptReviewers.DataBind();
                reader.Close();
            }

        }

        protected void btnAssign_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "AssignReviewer")
            {
                int reviewerId = Convert.ToInt32(e.CommandArgument);
                using (MySqlConnection conn = DBConn.GetConnection())
                {
                    string query = "UPDATE jobs SET `assigned_reviewer`=@ReviewerId WHERE id=@JobId";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("ReviewerId", reviewerId);
                    cmd.Parameters.AddWithValue("JobId", jobId);
                    int rows = cmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        Response.Redirect("/Jobs");
                    }
                }

            }
        }

        protected void rptReviewers_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                int reviewerId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "id"));

                Label lblAssigned = (Label)e.Item.FindControl("lblAssigned");
                Button btnAssign = (Button)e.Item.FindControl("btnAssign");
                Response.Write("reviewerId : " + reviewerId + " assignedReviewerId : " + assignedReviewerId);
                if (reviewerId == assignedReviewerId)
                {
                    lblAssigned.Visible = true;
                    btnAssign.Visible = false;
                }
            }
        }
    }
}