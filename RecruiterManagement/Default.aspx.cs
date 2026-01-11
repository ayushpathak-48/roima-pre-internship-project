using MySql.Data.MySqlClient;
using RecruiterManagement.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace RecruiterManagement
{

    public partial class _Default : Page
    {

        public Dictionary<string, string> stats = new Dictionary<string, string> { };
        DataTable jobsDt = new DataTable();
        string candidateId;
        public string cvFilePath;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedIn"] == null)
            {
                Response.Redirect("/Login");
            }
            if (Session["role"].Equals("recruiter"))
                Response.Redirect("/Jobs");

            else if (Session["role"].Equals("viewer"))
                Response.Redirect("/Users");

            else if (Session["role"].Equals("reviewer"))
                Response.Redirect("/Review");

            if (Session["role"].Equals("admin"))
            {
                LoadAdminStats();
            }
            else if (Session["role"].Equals("candidate"))
            {
                using (MySqlConnection conn = DBConn.GetConnection())
                {
                    string query = "SELECT id,cv_file_name FROM candidates WHERE user_id=@UserId";
                    MySqlCommand cmd = new MySqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", Session["userId"].ToString());
                    MySqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        candidateId = reader["id"].ToString();
                        cvFilePath = reader["cv_file_name"].ToString();
                    }
                }
                if (!IsPostBack)
                {
                    LoadJobs();
                }
            }
        }

        private void LoadAdminStats()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query = @"SELECT
                                (SELECT COUNT(*) FROM users) AS total_users,
                                (SELECT COUNT(*) FROM users INNER JOIN roles ON users.role_id = roles.id where roles.role_name = 'candidate') AS total_candidates,
                                (SELECT COUNT(*) FROM jobs) AS total_jobs,
                                (SELECT COUNT(*) FROM skills) AS total_skills;";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                MySqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    stats.Add("total_users", reader["total_users"].ToString());
                    stats.Add("total_candidates", reader["total_candidates"].ToString());
                    stats.Add("total_jobs", reader["total_jobs"].ToString());
                    stats.Add("total_skills", reader["total_skills"].ToString());
                }
            }
        }

        private void LoadJobs()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query = @"SELECT j.*, 
                    GROUP_CONCAT(CASE when js.type = 'REQUIRED' THEN s.name END ORDER BY s.name SEPARATOR ', ') AS required_skills, 
                    GROUP_CONCAT(CASE when js.type = 'PREFERRED' THEN s.name END ORDER BY s.name SEPARATOR ', ') AS preferred_skills,
                    CASE 
                            WHEN caj.job_id IS NOT NULL THEN 1
                            ELSE 0
                    END AS is_applied
                    FROM jobs j 
                    LEFT JOIN job_skills js ON j.id = js.job_id
                    LEFT JOIN skills s ON js.skill_id = s.id 
                    LEFT JOIN candidate_applied_jobs caj 
                           ON caj.job_id = j.id
                          AND caj.candidate_id = @CandidateId
                    WHERE j.status='OPEN' ORDER BY created_at DESC";

                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("CandidateId", candidateId);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                jobsDt.Columns.Add("isEligible", typeof(bool));
                da.Fill(jobsDt);

                foreach (DataRow row in jobsDt.Rows)
                {
                    row["isEligible"] = isCandidateEligible(Convert.ToString(row["id"]));
                }
                rptJobs.DataSource = jobsDt;
                rptJobs.DataBind();
                noJobsFound.Visible = jobsDt.Rows.Count == 0;
                rptJobs.Visible = jobsDt.Rows.Count > 0;
            }
        }
        protected bool isCandidateEligible(string jobId)
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query2 = @"SELECT 
                                        COUNT(js.skill_id) = COUNT(cs.skill_id) AS has_all_required_skills
                                    FROM job_skills js
                                    LEFT JOIN candidate_skills cs
                                        ON js.skill_id = cs.skill_id
                                        AND cs.candidate_id = @CandidateId
                                    WHERE js.job_id = @JobId
                                      AND js.type = 'REQUIRED'";
                MySqlCommand cmd2 = new MySqlCommand(query2, conn);
                cmd2.Parameters.AddWithValue("CandidateId", candidateId);
                cmd2.Parameters.AddWithValue("JobId", jobId);
                MySqlDataReader reader = cmd2.ExecuteReader();
                if (reader.Read())
                {
                    if (reader["has_all_required_skills"].ToString() == "1")
                        return true;
                }
            }
            return false;
        }

        protected void ApplyCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Apply")
            {
                string jobId = Convert.ToString(e.CommandArgument);

                if (isCandidateEligible(jobId))
                {
                    using (MySqlConnection conn = DBConn.GetConnection())
                    {
                        string sql = "INSERT INTO candidate_applied_jobs (job_id,candidate_id) VALUES (@JobId,@CandidateId)";
                        MySqlCommand cmd = new MySqlCommand(sql, conn);
                        cmd.Parameters.AddWithValue("@JobId", jobId);
                        cmd.Parameters.AddWithValue("@CandidateId", candidateId);
                        int rows = cmd.ExecuteNonQuery();
                    }
                }
            }
        }
    }
}