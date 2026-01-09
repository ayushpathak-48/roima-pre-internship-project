using MySql.Data.MySqlClient;
using RecruiterManagement.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedIn"] == null)
            {
                Response.Redirect("/Login");
            }

            loadProfileDetails();
        }

        private void loadProfileDetails()
        {

            string name = Session["name"].ToString();
            string email = Session["email"].ToString();
            string role = Session["role"].ToString();

            if (role == "candidate")
            {
                using (MySqlConnection conn = DBConn.GetConnection())
                {
                    string sql = @"SELECT c.*,
                    cs.status AS status,
                    GROUP_CONCAT(s.name SEPARATOR ', ') AS skills
                    FROM candidates c 
                    LEFT JOIN candidate_status cs ON c.status_id = cs.id
                    LEFT JOIN candidate_skills cskills ON cskills.candidate_id = c.id
                    LEFT JOIN skills s ON s.id = cskills.skill_id
                    where user_id=@userId";
                    MySqlCommand cmd = new MySqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("userId", Session["userId"]);
                    MySqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        dateOfBirth.Text = reader["date_of_birth"].ToString();
                        phoneLabel.Text = reader["phone"].ToString();
                        address.Text = reader["address"].ToString();
                        city.Text = reader["city"].ToString();
                        state.Text = reader["state"].ToString();
                        education.Text = reader["education"].ToString();
                        experience_years.Text = reader["experience_years"].ToString();
                        expected_salary.Text = reader["expected_salary"].ToString();
                        current_position.Text = reader["current_position"].ToString();
                        status.Text = reader["status"].ToString();
                        status.CssClass = reader["status"].ToString() == "ACTIVE" ? "text-green-500": "text-red-500";
                        gender.Text = reader["gender"].ToString();
                        skills.Text = reader["skills"].ToString();
                    }
                }
            }

            ltName.Text = name;
            ltNameDetail.Text = name;
            ltEmail.Text = email;
            ltRole.Text = role;
            ltRoleDetail.Text = role;

        }
    }
}