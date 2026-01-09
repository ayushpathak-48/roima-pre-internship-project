using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement
{
    public partial class Review : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] == null)
                Response.Redirect("/Login");
            loadJob();
        }

        protected void loadJob()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string sql = @"SELECT j.*, 
                    GROUP_CONCAT(CASE when js.type = 'REQUIRED' THEN s.name END ORDER BY s.name SEPARATOR ', ') AS required_skills, 
                    GROUP_CONCAT(CASE when js.type = 'PREFERRED' THEN s.name END ORDER BY s.name SEPARATOR ', ') AS preferred_skills
                    FROM jobs j 
                    LEFT JOIN job_skills js ON j.id = js.job_id
                    LEFT JOIN skills s ON js.skill_id = s.id 
                    WHERE j.assigned_reviewer = @userId";
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("userId", Session["userId"]);
                MySqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    jobTitle.InnerText = reader["name"].ToString();
                    jobDesc.InnerText = reader["description"].ToString();
                    statusText.InnerText = reader["status"].ToString();
                    jobType.InnerText = reader["job_type"].ToString();
                    stipend.InnerText = reader["stipend"].ToString();
                    salary_range.InnerText = reader["job_type"].ToString() == "INTERNSHIP" ? "-" : reader["salary_range_start"].ToString() + " to " + reader["salary_range_end"].ToString();
                    requiredSkils.InnerText = reader["required_skills"].ToString();
                    preferredSkills.InnerText = reader["preferred_skills"].ToString();
                }
            }
        }
    }
}