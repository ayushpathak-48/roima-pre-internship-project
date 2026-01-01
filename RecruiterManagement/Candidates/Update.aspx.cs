using MySql.Data.MySqlClient;
using RecruiterManagement.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement.Candidates
{
    public partial class Update : System.Web.UI.Page
    {
        public List<Skill> SkillsList = new List<Skill>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSkills();
                string candidateIdStr = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(candidateIdStr))
                {
                    long candidateId = Convert.ToInt64(candidateIdStr);
                    hiddenCandidateId.Value = candidateIdStr;
                    LoadCandidateDetails(candidateId);
                }
                else
                {
                    Response.Redirect("/Candidates?action=update&success=false");
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
                reader.Close();
                skillsCheckboxList.DataSource = SkillsList;
                skillsCheckboxList.DataTextField = "Name";
                skillsCheckboxList.DataValueField = "Id";
                skillsCheckboxList.DataBind();
            }
        }

        private void LoadCandidateDetails(long candidateId)
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query = @"SELECT c.*, u.email, u.name 
FROM candidates c
INNER JOIN users u ON c.user_id = u.id
WHERE c.id = @CandidateId";

                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CandidateId", candidateId);
                MySqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtName.Text = reader["name"].ToString();
                    txtEmail.Text = reader["email"].ToString();
                    txtPhone.Text = reader["phone"].ToString();
                    radioGender.SelectedValue = reader["gender"].ToString();
                    dateOfBirth.Text = Convert.ToDateTime(reader["date_of_birth"]).ToString("yyyy-MM-dd");
                    txtAddress.Text = reader["address"].ToString();
                    txtCity.Text = reader["city"].ToString();
                    txtState.Text = reader["state"].ToString();
                    txtEducation.Text = reader["education"].ToString();
                    txtExperienceYears.Text = reader["experience_years"].ToString();
                    txtCurrentPosition.Text = reader["current_position"].ToString();
                    txtExpectedSalary.Text = reader["expected_salary"].ToString();
                }
                reader.Close();

                
                string skillQuery = "SELECT skill_id FROM candidate_skills WHERE candidate_id = @CandidateId";
                MySqlCommand skillCmd = new MySqlCommand(skillQuery, conn);
                skillCmd.Parameters.AddWithValue("@CandidateId", candidateId);
                MySqlDataReader skillReader = skillCmd.ExecuteReader();
                List<int> selectedSkills = new List<int>();
                while (skillReader.Read())
                {
                    selectedSkills.Add(Convert.ToInt32(skillReader["skill_id"]));
                }
                skillReader.Close();

                foreach (ListItem item in skillsCheckboxList.Items)
                {
                    if (selectedSkills.Contains(Convert.ToInt32(item.Value)))
                    {
                        item.Selected = true;
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            long candidateId = Convert.ToInt64(hiddenCandidateId.Value);
            string name = txtName.Text;
            string phone = txtPhone.Text;
            string gender = radioGender.SelectedValue;
            string dob = dateOfBirth.Text;
            string address = txtAddress.Text;
            string city = txtCity.Text;
            string state = txtState.Text;
            string education = txtEducation.Text;
            string expYears = txtExperienceYears.Text;
            string currentPosition = txtCurrentPosition.Text;
            string expectedSalary = txtExpectedSalary.Text;

            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string updateUserQuery = "UPDATE users SET name = @Name WHERE email = @Email";
                MySqlCommand updateUserCmd = new MySqlCommand(updateUserQuery, conn);
                updateUserCmd.Parameters.AddWithValue("@Name", name);
                updateUserCmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                updateUserCmd.ExecuteNonQuery();

             
                string updateCandidateQuery = @"UPDATE candidates SET 
phone=@Phone, gender=@Gender, date_of_birth=@DOB, address=@Address, city=@City, state=@State, 
education=@Education, experience_years=@ExpYears, current_position=@CurrentPosition, 
expected_salary=@ExpectedSalary 
WHERE id=@CandidateId";
                MySqlCommand updateCandidateCmd = new MySqlCommand(updateCandidateQuery, conn);
                updateCandidateCmd.Parameters.AddWithValue("@Phone", phone);
                updateCandidateCmd.Parameters.AddWithValue("@Gender", gender);
                updateCandidateCmd.Parameters.AddWithValue("@DOB", dob);
                updateCandidateCmd.Parameters.AddWithValue("@Address", address);
                updateCandidateCmd.Parameters.AddWithValue("@City", city);
                updateCandidateCmd.Parameters.AddWithValue("@State", state);
                updateCandidateCmd.Parameters.AddWithValue("@Education", education);
                updateCandidateCmd.Parameters.AddWithValue("@ExpYears", expYears);
                updateCandidateCmd.Parameters.AddWithValue("@CurrentPosition", currentPosition);
                updateCandidateCmd.Parameters.AddWithValue("@ExpectedSalary", expectedSalary);
                updateCandidateCmd.Parameters.AddWithValue("@CandidateId", candidateId);
                updateCandidateCmd.ExecuteNonQuery();

                
                string deleteOldSkills = "DELETE FROM candidate_skills WHERE candidate_id=@CandidateId";
                MySqlCommand deleteCmd = new MySqlCommand(deleteOldSkills, conn);
                deleteCmd.Parameters.AddWithValue("@CandidateId", candidateId);
                deleteCmd.ExecuteNonQuery();

                List<int> selectedSkills = new List<int>();
                foreach (ListItem item in skillsCheckboxList.Items)
                {
                    if (item.Selected)
                        selectedSkills.Add(Convert.ToInt32(item.Value));
                }

                if (selectedSkills.Count > 0)
                {
                    List<string> placeholders = new List<string>();
                    MySqlCommand insertCmd = new MySqlCommand();
                    for (int i = 0; i < selectedSkills.Count; i++)
                    {
                        string param = "@Skill" + i;
                        placeholders.Add($"(@CandidateId, {param})");
                        insertCmd.Parameters.AddWithValue(param, selectedSkills[i]);
                    }
                    insertCmd.Parameters.AddWithValue("@CandidateId", candidateId);
                    insertCmd.CommandText = $"INSERT INTO candidate_skills (candidate_id, skill_id) VALUES {string.Join(",", placeholders)}";
                    insertCmd.Connection = conn;
                    insertCmd.ExecuteNonQuery();

                    Response.Redirect("/Candidates?action=update&success=true");
                }

            }
        }
    }
}
