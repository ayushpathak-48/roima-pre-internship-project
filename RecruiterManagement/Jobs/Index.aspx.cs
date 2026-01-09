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
    public partial class Index : System.Web.UI.Page
    {
        public List<Job> JobsList = new List<Job>();
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

            LoadJobs();

            string action = Request.Params.Get("action");
            string success = Request.Params.Get("success");
            if (!string.IsNullOrEmpty(action) && !string.IsNullOrEmpty(success))
            {
                if (action.Equals("delete") && success.Equals("true"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'success',title:'Deleted!',text:'Job deleted successfully!',timer:1500,showConfirmButton:false});", true);
                }

                else if (action.Equals("delete") && success.Equals("false"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'error',title:'Failed!',text:'Failed to delete the job',timer:1500,showConfirmButton:false});", true);

                }

                else if (action.Equals("update") && success.Equals("false"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'error',title:'Failed!',text:'Failed to update the job',timer:1500,showConfirmButton:false});", true);
                }

                else if (action.Equals("update") && success.Equals("true"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'success',title:'Updated!',text:'Job updated successfully',timer:1500,showConfirmButton:false});", true);
                }

                else if (action.Equals("addjob") && success.Equals("true"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'success',title:'Added!',text:'Job added successfully',timer:1500,showConfirmButton:false});", true);
                }

                ScriptManager.RegisterStartupScript(this, GetType(),
                        "removeQuery",
                "if (window.location.search) { " +
                "   const newUrl = window.location.origin + window.location.pathname;" +
                "   window.history.replaceState({}, document.title, newUrl);" +
                "}", true);
            }
        }

        private void LoadJobs()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query = @"SELECT j.*, 
                    GROUP_CONCAT(CASE when js.type = 'REQUIRED' THEN s.name END ORDER BY s.name SEPARATOR ', ') AS required_skills, 
                    GROUP_CONCAT(CASE when js.type = 'PREFERRED' THEN s.name END ORDER BY s.name SEPARATOR ', ') AS preferred_skills,
                    u.name as reviewer_name, u.email as reviewer_email
                    FROM jobs j 
                    LEFT JOIN job_skills js ON j.id = js.job_id 
                    LEFT JOIN users u ON j.assigned_reviewer = u.id
                    LEFT JOIN skills s ON js.skill_id = s.id 
                    GROUP BY j.id, j.name;";


                MySqlCommand cmd = new MySqlCommand(query, conn);
                MySqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Job job = new Job
                    {
                        Id = Convert.ToInt32(reader["id"]),
                        Name = reader["name"].ToString(),
                        Preferred_Skills = reader["preferred_skills"].ToString(),
                        Required_Skills = reader["required_skills"].ToString(),
                        Status = reader["status"].ToString(),
                        Description = reader["description"].ToString(),
                        SalaryFrom = reader["salary_range_start"].ToString(),
                        SalaryTo = reader["salary_range_end"].ToString(),
                        Stipend = reader["stipend"].ToString(),
                        Type = reader["job_type"].ToString(),
                        ReviewerName = reader["reviewer_name"].ToString(),
                        ReviewerEmail = reader["reviewer_email"].ToString()
                    };

                    JobsList.Add(job);
                }
            }
        }
    }
}