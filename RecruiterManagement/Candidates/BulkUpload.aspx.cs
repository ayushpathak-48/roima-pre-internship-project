using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement.Candidates
{
    public partial class BulkUpload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void uploadBtn_Click(object sender, EventArgs e)
        {
            if (!fileUploadControl.HasFile)
            {
                lblCSVStatus.Text = "Please select a CSV file.";
                return;
            }

            string extension = Path.GetExtension(fileUploadControl.FileName);
            if (extension.ToLower() != ".csv" && extension.ToLower() != ".xlsx")
            {
                lblCSVStatus.Text = "Only .csv or .xlsx files are allowed.";
                return;
            }

            string folderPath = Server.MapPath("~/Uploads/Candidates_CSV_Data");
            if (!Directory.Exists(folderPath))
                Directory.CreateDirectory(folderPath);

            string filePath = Path.Combine(folderPath, Path.GetFileName(fileUploadControl.FileName));
            fileUploadControl.SaveAs(filePath);

            int totalInserted = insertCsvDataToDB(filePath);

            lblMessage.Text = "File uploaded successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
        private int insertCsvDataToDB(string filePath)
        {
            int count = 0;

            using (MySqlConnection conn = DBConn.GetConnection())
            {
                using (StreamReader sr = new StreamReader(filePath))
                {
                    string headerLine = sr.ReadLine();

                    while (!sr.EndOfStream)
                    {
                        string line = sr.ReadLine();
                        if (string.IsNullOrWhiteSpace(line)) continue;

                        string[] values = line.Split(',');
                        string first_name = values[1].Trim();
                        string last_name = values[2].Trim();
                        string email = values[3].Trim();
                        string phone = values[4].Trim();
                        string gender = values[5].Trim();
                        string date_of_birth = values[6].Trim();
                        string address = values[7].Trim();
                        string city = values[8].Trim();
                        string state = values[9].Trim();
                        string country = values[10].Trim();
                        string education = values[11].Trim();
                        string experience_years = values[12].Trim();
                        string current_position = values[13].Trim();
                        string expected_salary = values[14].Trim();
                        string skills = values[15].Trim();

                        DateTime dob;

                        if (DateTime.TryParseExact(date_of_birth, "dd-MM-yyyy",
                            System.Globalization.CultureInfo.InvariantCulture,
                            System.Globalization.DateTimeStyles.None, out dob))
                        {
                            date_of_birth = dob.ToString("yyyy-MM-dd");
                        }
                        else
                        {
                            date_of_birth = null;
                        }


                        string checkEmailQuery = "SELECT COUNT(*) FROM users WHERE email=@Email";
                        MySqlCommand checkCmd = new MySqlCommand(checkEmailQuery, conn);
                        checkCmd.Parameters.AddWithValue("@Email", email);
                        int existing = Convert.ToInt32(checkCmd.ExecuteScalar());
                        if (existing > 0) continue;

                        string hashedPassword = BCrypt.Net.BCrypt.HashPassword("123456");
                        string insertUserQuery = @"INSERT INTO users (email, name, role_id, password) VALUES (@Email, @Name, 6, @Password)";
                        MySqlCommand insertUserCmd = new MySqlCommand(insertUserQuery, conn);
                        insertUserCmd.Parameters.AddWithValue("@Email", email);
                        insertUserCmd.Parameters.AddWithValue("@Name", first_name + " " + last_name);
                        insertUserCmd.Parameters.AddWithValue("@Password", hashedPassword);
                        insertUserCmd.ExecuteNonQuery();

                        long userId = insertUserCmd.LastInsertedId;

                        string insertCandidateQuery = @"INSERT INTO candidates 
                    (user_id, phone, gender, date_of_birth, address, city, state, education, experience_years, current_position, expected_salary, status_id) 
                    VALUES (@UserId,@Phone,@Gender,@DateOfBirth,@Address,@City,@State,@Education,@ExperienceYears,@CurrentPosition,@ExpectedSalary,1)";
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
                        insertCandidateCmd.ExecuteNonQuery();

                        long candidateId = insertCandidateCmd.LastInsertedId;

                        if (!string.IsNullOrEmpty(skills))
                        {
                            string[] skillList = skills.Split(';', ',');
                            foreach (string skill in skillList)
                            {
                                string trimmedSkill = skill.Trim();
                                if (string.IsNullOrEmpty(trimmedSkill)) continue;

                                string checkSkillQuery = "SELECT id FROM skills WHERE name=@Skill";
                                MySqlCommand checkSkillCmd = new MySqlCommand(checkSkillQuery, conn);
                                checkSkillCmd.Parameters.AddWithValue("@Skill", trimmedSkill);
                                object skillIdObj = checkSkillCmd.ExecuteScalar();

                                long skillId;
                                if (skillIdObj == null)
                                {
                                    string insertSkillQuery = "INSERT INTO skills (name) VALUES (@Skill)";
                                    MySqlCommand insertSkillCmd = new MySqlCommand(insertSkillQuery, conn);
                                    insertSkillCmd.Parameters.AddWithValue("@Skill", trimmedSkill);
                                    insertSkillCmd.ExecuteNonQuery();
                                    skillId = insertSkillCmd.LastInsertedId;
                                }
                                else
                                {
                                    skillId = Convert.ToInt64(skillIdObj);
                                }

                                string insertCandidateSkill = "INSERT INTO candidate_skills (candidate_id, skill_id) VALUES (@CandidateId, @SkillId)";
                                MySqlCommand linkCmd = new MySqlCommand(insertCandidateSkill, conn);
                                linkCmd.Parameters.AddWithValue("@CandidateId", candidateId);
                                linkCmd.Parameters.AddWithValue("@SkillId", skillId);
                                linkCmd.ExecuteNonQuery();
                            }
                        }

                        count++;
                    }
                }
            }

            return count;
        }

    }
}