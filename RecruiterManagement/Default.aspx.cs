using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement
{

    public partial class _Default : Page
    {

        public Dictionary<string, string> stats = new Dictionary<string, string> { };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedIn"] != null)
                if (Session["role"].Equals("admin"))
                {
                    LoadAdminStats();
                }
                else if (Session["role"].Equals("candidate"))
                {
                    LoadJobs();
                }
        }

        private void LoadAdminStats()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query = "SELECT" +
                    "(SELECT COUNT(*) FROM users) AS total_users," +
                    "(SELECT COUNT(*) FROM users INNER JOIN roles ON users.role_id = roles.id where roles.role_name = 'candidate') AS total_candidates," +
                    "(SELECT COUNT(*) FROM jobs) AS total_jobs," +
                    "(SELECT COUNT(*) FROM skills) AS total_skills;";
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
                string query = @"SELECT id, name, description, salary_range_start, salary_range_end, stipend, job_type, status, created_at 
                                 FROM jobs 
                                 ORDER BY created_at DESC";

                MySqlCommand cmd = new MySqlCommand(query, conn);
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptJobs.DataSource = dt;
                rptJobs.DataBind();
            }
        }
    }
}