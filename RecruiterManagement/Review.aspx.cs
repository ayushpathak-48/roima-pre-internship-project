using MySql.Data.MySqlClient;
using RecruiterManagement.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement
{
    public partial class Review : System.Web.UI.Page
    {

        public bool isAssignedAnyJob = false;

        private string JobId
        {
            get { return ViewState["JobId"]?.ToString(); }
            set { ViewState["JobId"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedIn"] == null)
                Response.Redirect("/Login");
            if (!Session["role"].ToString().Equals("admin") && !Session["role"].ToString().Equals("reviewer"))
            {
                Response.Redirect("/");
            }
            if (!IsPostBack)
            {
                LoadJob();
            }
        }

        protected void LoadJob()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string sql = @"SELECT j.*, 
                    GROUP_CONCAT(CASE when js.type = 'REQUIRED' THEN s.name END ORDER BY s.name SEPARATOR ', ') AS required_skills, 
                    GROUP_CONCAT(CASE when js.type = 'PREFERRED' THEN s.name END ORDER BY s.name SEPARATOR ', ') AS preferred_skills
                    FROM jobs j 
                    LEFT JOIN job_skills js ON j.id = js.job_id
                    LEFT JOIN skills s ON js.skill_id = s.id 
                    WHERE j.assigned_reviewer = @userId
                    GROUP BY j.id";
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("userId", Session["userId"]);
                MySqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    isAssignedAnyJob = true;
                    JobId = reader["id"].ToString();
                    jobTitle.InnerText = reader["name"].ToString();
                    jobDesc.InnerText = reader["description"].ToString();
                    statusText.InnerText = reader["status"].ToString();
                    jobType.InnerText = reader["job_type"].ToString();
                    stipend.InnerText = reader["stipend"].ToString();
                    salary_range.InnerText = reader["job_type"].ToString() == "INTERNSHIP" ? "-" : reader["salary_range_start"].ToString() + " to " + reader["salary_range_end"].ToString();
                    requiredSkils.InnerText = reader["required_skills"].ToString();
                    preferredSkills.InnerText = reader["preferred_skills"].ToString();
                    LoadAppliedCandidates();
                }
            }
        }

        protected void LoadAppliedCandidates()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string sql = @"SELECT c.*, u.name, u.email,caj.status as applied_status
                                FROM candidate_applied_jobs caj
                                INNER JOIN candidates c ON caj.candidate_id = c.id
                                INNER JOIN users u ON c.user_id = u.id
                                WHERE caj.job_id = @JobId";
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("JobId", JobId);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable candidatesDt = new DataTable();
                da.Fill(candidatesDt);
                rptCandidates.DataSource = candidatesDt;
                rptCandidates.DataBind();
            }
        }


        protected void sendReminderBtn_Click(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "SendReminder")
            {
                string toEmail = e.CommandArgument.ToString();
                string updateCandidateUrl = Request.Url.GetLeftPart(UriPartial.Authority) + "/Candidates/Update";
                string bodyContent = $@"<td style='padding:24px; color:#374151; font-size:15px; line-height:1.6;'>
              <p style='margin-top:0;'>
                Hello,
              </p>

              <p>
                You haven't uploaded your resume yet. Upload it now to complete your profile and increase your chances of getting hired.
              </p>

              <p style='text-align:center; margin:30px 0;'>
                <a href='{updateCandidateUrl}'
                   style='background-color:#2563eb; color:#ffffff; text-decoration:none; padding:12px 22px; border-radius:4px; display:inline-block; font-size:14px;'>
                  Upload Resume
                </a>
              </p>

              <p>
                If the button above doesn't work, copy and paste the following link into your browser:
              </p>

              <p style='word-break:break-all; color:#2563eb;'>
                {updateCandidateUrl}
              </p>

              <p style='margin-bottom:0;'>
                Regards,<br>
                <strong>Recruit Manager Team</strong>
              </p>
            </td>";
                try
                {
                    MailHelper.SendEmail(toEmail, "Upload Resume Reminder", bodyContent);
                }
                catch
                {
                    Console.WriteLine("Error while sending mail");
                }
            }
            Response.Redirect(Request.RawUrl);
        }

        protected void ShortlistCandidate_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "ShortlistCandidate")
            {
                string candidateId = e.CommandArgument.ToString();
                using (MySqlConnection conn = DBConn.GetConnection())
                {
                    string sql = @"UPDATE candidate_applied_jobs SET status='SHORTLISTED' WHERE candidate_id=@CandidateId AND job_id=@JobId";
                    MySqlCommand cmd = new MySqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("CandidateId", candidateId);
                    cmd.Parameters.AddWithValue("JobId", JobId);
                    cmd.ExecuteNonQuery();

                    string sql2 = @"SELECT u.name,u.email from candidates c 
                                    LEFT JOIN users u ON u.id=c.user_id 
                                    WHERE c.id=@CandidateId
                                    GROUP BY c.id";
                    MySqlCommand cmd2 = new MySqlCommand(sql2, conn);
                    cmd2.Parameters.AddWithValue("CandidateId", candidateId);
                    MySqlDataReader reader = cmd2.ExecuteReader();

                    if (reader.Read())
                    {
                        string toEmail = reader["email"].ToString();
                        string bodyContent = $@"<td style='padding:24px; color:#374151; font-size:15px; line-height:1.6;'>
              <p style='margin-top:0;'>
                Congratulations {reader["name"]}
              </p>

              <p>
                You got shortlisted in the company XYZ. Stay tuned for further details about interview.
              </p>

              <p style='margin-bottom:0;'>
                Regards,<br>
                <strong>Recruit Manager Team</strong>
              </p>
            </td>";
                        try
                        {
                            MailHelper.SendEmail(toEmail, "Shortlisted in ABC company", bodyContent);
                        }
                        catch
                        {
                            Console.WriteLine("Error while sending mail");
                        }
                    }
                }
            }

            Response.Redirect(Request.RawUrl);
        }
    }
}