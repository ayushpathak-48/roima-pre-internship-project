using MySql.Data.MySqlClient;
using RecruiterManagement.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement.Candidates
{
    public partial class Add : System.Web.UI.Page
    {

        public List<Skill> SkillsList = new List<Skill>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedIn"] == null)
            {
                Response.Redirect("/Login");
            }

            else if (!Session["role"].Equals("admin") && !Session["role"].Equals("recruiter"))
            {
                Response.Redirect("/");
            }

            if (IsPostBack) return;
            LoadSkills();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text;
            string email = txtEmail.Text;
            string phone = txtPhone.Text;
            string gender = radioGender.SelectedValue;
            string date_of_birth = dateOfBirth.Text;
            string address = txtAddress.Text;
            string city = txtCity.Text;
            string state = txtState.Text;
            string education = txtEducation.Text;
            string experience_years = txtExperienceYears.Text;
            string current_position = txtCurrentPosition.Text;
            string expected_salary = txtExpectedSalary.Text;

            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query = "SELECT * from users where email=@Email";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                MySqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    lblError.Text = "Email already used";
                    return;
                }

                lblError.Text = "";
                reader.Close();
                string hashedPassword = BCrypt.Net.BCrypt.HashPassword("123456");
                string insertUserQuery = @"INSERT INTO users (`email`,`name`,`role_id`,`password`) VALUES (@Email,@Name,@RoleId,@Password)";
                MySqlCommand insertCmd = new MySqlCommand(insertUserQuery, conn);
                insertCmd.Parameters.AddWithValue("@Email", email);
                insertCmd.Parameters.AddWithValue("@Name", name);
                insertCmd.Parameters.AddWithValue("@RoleId", 7);
                insertCmd.Parameters.AddWithValue("@Password", hashedPassword);
                int rows = insertCmd.ExecuteNonQuery();
                if (rows > 0)
                {
                    long userId = insertCmd.LastInsertedId;
                    string insertCandidateQuery = @"INSERT INTO `candidates`(`user_id`, `phone`, `gender`, `date_of_birth`, `address`, `city`, `state`,  `education`, `experience_years`, `current_position`, `expected_salary`, `status_id`) VALUES (@UserId,@Phone,@Gender,@DateOfBirth,@Address,@City,@State,@Education,@ExperienceYears,@CurrentPosition,@ExpectedSalary,1)";
                    MySqlCommand insertCandidateCmd = new MySqlCommand(insertCandidateQuery, conn);
                    insertCandidateCmd.Parameters.AddWithValue("@UserId", userId);
                    insertCandidateCmd.Parameters.AddWithValue("@Phone", phone);
                    insertCandidateCmd.Parameters.AddWithValue("@Gender", gender);
                    insertCandidateCmd.Parameters.AddWithValue("@DateOfBirth", date_of_birth);
                    insertCandidateCmd.Parameters.AddWithValue("@Address", address);
                    insertCandidateCmd.Parameters.AddWithValue("@City", city);
                    insertCandidateCmd.Parameters.AddWithValue("@State", state);
                    insertCandidateCmd.Parameters.AddWithValue("@Education", education);
                    insertCandidateCmd.Parameters.AddWithValue("@ExperienceYears", experience_years);
                    insertCandidateCmd.Parameters.AddWithValue("@CurrentPosition", current_position);
                    insertCandidateCmd.Parameters.AddWithValue("@ExpectedSalary", expected_salary);
                    int candidateRows = insertCandidateCmd.ExecuteNonQuery();
                    if (candidateRows > 0)
                    {
                        long candidateId = insertCandidateCmd.LastInsertedId;

                        List<int> selectedSkillIds = new List<int>();

                        foreach (ListItem item in skillsCheckboxList.Items)
                        {
                            if (item.Selected)
                            {
                                selectedSkillIds.Add(Convert.ToInt32(item.Value));
                            }
                        }

                        if (selectedSkillIds.Count > 0)
                        {
                            List<string> valuePlaceholders = new List<string>();
                            MySqlCommand insertCandidateSkillsCmd = new MySqlCommand();

                            for (int i = 0; i < selectedSkillIds.Count; i++)
                            {
                                string paramName = "@Skill" + i;
                                valuePlaceholders.Add($"(@CandidateId, {paramName})");
                                insertCandidateSkillsCmd.Parameters.AddWithValue(paramName, selectedSkillIds[i]);
                            }

                            string insertQuery = $"INSERT INTO candidate_skills (candidate_id, skill_id) VALUES {string.Join(", ", valuePlaceholders)}";

                            insertCandidateSkillsCmd.CommandText = insertQuery;
                            insertCandidateSkillsCmd.Connection = conn;
                            insertCandidateSkillsCmd.Parameters.AddWithValue("@CandidateId", candidateId);

                            int skillsinserted = insertCandidateSkillsCmd.ExecuteNonQuery();

                            if (skillsinserted > 0)
                            {
                                Response.Redirect("/Candidates?action=addcandidate&success=true");
                            }
                        }
                    }
                }
                else
                {
                    lblError.Text = "Failed to create user! Please try again.";
                }
            }
        }


        private void LoadSkills()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query = "SELECT * FROM skills";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                MySqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    Skill skill = new Skill
                    {
                        Id = Convert.ToInt32(reader["id"]),
                        Name = reader["name"].ToString(),
                    };

                    SkillsList.Add(skill);
                }
                skillsCheckboxList.DataSource = SkillsList;
                skillsCheckboxList.DataTextField = "name";
                skillsCheckboxList.DataValueField = "id";
                skillsCheckboxList.DataBind();
            }
        }
    }
}