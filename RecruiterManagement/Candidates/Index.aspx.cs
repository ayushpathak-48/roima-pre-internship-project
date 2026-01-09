using MySql.Data.MySqlClient;
using RecruiterManagement.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement.Candidates
{
    public partial class Index : System.Web.UI.Page
    {
        public List<Candidate> candidatesList = new List<Candidate>();
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


            loadCandidates();
            string action = Request.Params.Get("action");
            string success = Request.Params.Get("success");
            if (!string.IsNullOrEmpty(action) && !string.IsNullOrEmpty(success))
            {
                if (action.Equals("delete") && success.Equals("true"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'success',title:'Deleted!',text:'Candidate deleted successfully!',timer:1500,showConfirmButton:false});", true);
                }

                else if (action.Equals("delete") && success.Equals("false"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'error',title:'Failed!',text:'Failed to delete the candidate',timer:1500,showConfirmButton:false});", true);

                }

                else if (action.Equals("update") && success.Equals("false"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'error',title:'Failed!',text:'Failed to update the candidate',timer:1500,showConfirmButton:false});", true);
                }

                else if (action.Equals("update") && success.Equals("true"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'success',title:'Updated!',text:'Candidate updated successfully',timer:1500,showConfirmButton:false});", true);
                }

                else if (action.Equals("addcandidate") && success.Equals("true"))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showAlert",
        "Swal.fire({icon:'success',title:'Added!',text:'Candidate added successfully',timer:1500,showConfirmButton:false});", true);
                }

                ScriptManager.RegisterStartupScript(this, GetType(),
                        "removeQuery",
                "if (window.location.search) { " +
                "   const newUrl = window.location.origin + window.location.pathname;" +
                "   window.history.replaceState({}, document.title, newUrl);" +
                "}", true);
            }
        }

        private void loadCandidates()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query =
                    @"SELECT 
                    u.name AS name,
                    u.email AS email,
                    c.*,
                    cs.status AS status,
                    GROUP_CONCAT(s.name SEPARATOR ', ') AS skills
                    FROM candidates c 
                    LEFT JOIN users u ON c.user_id = u.id 
                    LEFT JOIN candidate_status cs ON c.status_id = cs.id
                    LEFT JOIN candidate_skills cskills ON cskills.candidate_id = c.id
                    LEFT JOIN skills s ON s.id = cskills.skill_id
                    GROUP BY c.id";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                MySqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Candidate candidate = new Candidate
                    {
                        ID = Convert.ToInt32(reader["id"]),
                        Name = reader["name"].ToString(),
                        Email = reader["email"].ToString(),
                        Phone = reader["phone"].ToString(),
                        Date_Of_Birth = reader["date_of_birth"].ToString(),
                        Address = reader["address"].ToString(),
                        City = reader["city"].ToString(),
                        State = reader["state"].ToString(),
                        Education = reader["education"].ToString(),
                        Skills = reader["skills"].ToString(),
                        Experience_Years = reader["experience_years"].ToString(),
                        Current_Position = reader["current_position"].ToString(),
                        Expected_Salary = reader["expected_salary"].ToString(),
                        Status = reader["status"].ToString()
                    };

                    candidatesList.Add(candidate);
                }
            }
        }
    }
}