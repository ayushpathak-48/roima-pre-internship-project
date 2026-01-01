using MySql.Data.MySqlClient;
using RecruiterManagement.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement.Jobs
{
    public partial class ChangeStatus : System.Web.UI.Page
    {
        public List<Candidate> candidateList = new List<Candidate>();
        private string jobId;
        protected void Page_Load(object sender, EventArgs e)
        {
            jobId = Request.QueryString["id"];
            if (IsPostBack) return;
            if (String.IsNullOrEmpty(jobId))
            {
                Response.Redirect("/Jobs");
            }
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                MySqlCommand selectJob = new MySqlCommand("SELECT name,status FROM jobs where id=@Id", conn);
                selectJob.Parameters.AddWithValue("@Id", jobId);
                MySqlDataReader reader = selectJob.ExecuteReader();
                while (reader.Read())
                {
                    lblJobName.Text = reader["name"].ToString();
                    statusDD.SelectedValue = reader["status"].ToString();
                }
            }
        }
        protected void statusDD_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (candidateList.Count == 0) LoadCandidates();
        }

        private void LoadCandidates()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query =
                    @"SELECT id,name,email FROM users where role_id=6";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                MySqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Candidate candidate = new Candidate
                    {
                        ID = Convert.ToInt32(reader["id"]),
                        Name = reader["name"].ToString(),
                        Email = reader["email"].ToString(),
                    };

                    candidateList.Add(candidate);
                }
                candidatesCheckboxList.DataSource = candidateList;
                candidatesCheckboxList.DataTextField = "email";
                candidatesCheckboxList.DataValueField = "id";
                candidatesCheckboxList.DataBind();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(commentText.Text))
            {
                lblMessage.Text = "Comment is required";
                return;
            }

            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string updateQuery = "UPDATE jobs set status=@Status where id=@Id";
                MySqlCommand updateCommand = new MySqlCommand(updateQuery, conn);
                updateCommand.Parameters.AddWithValue("@Status", statusDD.SelectedValue);
                updateCommand.Parameters.AddWithValue("@Id", jobId);
                int updated = updateCommand.ExecuteNonQuery();
                if (updated > 0)
                {
                    string insertCommentQuery = "INSERT INTO job_comments (`comment`,`job_id`,`status`) VALUES (@Comment,@JobId,@Status)";
                    MySqlCommand insertCmd = new MySqlCommand(insertCommentQuery, conn);
                    insertCmd.Parameters.AddWithValue("@Status", statusDD.SelectedValue);
                    insertCmd.Parameters.AddWithValue("@Comment", commentText.Text);
                    insertCmd.Parameters.AddWithValue("@JobId", jobId);
                    int inserted = insertCmd.ExecuteNonQuery();
                    if (inserted > 0)
                    {
                        Response.Redirect("/Jobs");
                    }
                    else
                    {
                        lblMessage.Text = "Error updating status ";
                    }
                }
                else
                {
                    lblMessage.Text = "Error updating status ";
                }
            }
        }
    }
}