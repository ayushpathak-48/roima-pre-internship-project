using MySql.Data.MySqlClient;
using RecruiterManagement.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement.Jobs
{
    public partial class Update : System.Web.UI.Page
    {
        public List<Skill> SkillsList = new List<Skill>();
        private long jobId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!long.TryParse(Request.QueryString["id"], out jobId))
            {
                Response.Redirect("/Users?action=update&success=false");
                return;
            }

            if (!IsPostBack)
            {
                LoadSkills();
                LoadJobDetails();
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
                    SkillsList.Add(new Skill
                    {
                        Id = Convert.ToInt32(reader["id"]),
                        Name = reader["name"].ToString()
                    });
                }
                reader.Close();

                requiredSkillsCheckboxList.DataSource = SkillsList;
                requiredSkillsCheckboxList.DataTextField = "name";
                requiredSkillsCheckboxList.DataValueField = "id";
                requiredSkillsCheckboxList.DataBind();

                preferredSkillsCheckboxList.DataSource = SkillsList;
                preferredSkillsCheckboxList.DataTextField = "name";
                preferredSkillsCheckboxList.DataValueField = "id";
                preferredSkillsCheckboxList.DataBind();
            }
        }

        private void LoadJobDetails()
        {
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query = "SELECT * FROM jobs WHERE id = @JobId";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@JobId", jobId);
                MySqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtName.Text = reader["name"].ToString();
                    txtDescription.Text = reader["description"].ToString();
                    txtSalaryFrom.Text = reader["salary_range_start"].ToString();
                    txtSalaryTo.Text = reader["salary_range_end"].ToString();
                    txtStipend.Text = reader["stipend"].ToString();
                    radioJobType.SelectedValue = reader["job_type"].ToString();
                }
                reader.Close();

                string skillQuery = "SELECT skill_id, type FROM job_skills WHERE job_id = @JobId";
                MySqlCommand skillCmd = new MySqlCommand(skillQuery, conn);
                skillCmd.Parameters.AddWithValue("@JobId", jobId);
                MySqlDataReader skillReader = skillCmd.ExecuteReader();

                List<int> requiredIds = new List<int>();
                List<int> preferredIds = new List<int>();

                while (skillReader.Read())
                {
                    int skillId = Convert.ToInt32(skillReader["skill_id"]);
                    string type = skillReader["type"].ToString();
                    if (type == "REQUIRED") requiredIds.Add(skillId);
                    else preferredIds.Add(skillId);
                }
                skillReader.Close();

                foreach (ListItem item in requiredSkillsCheckboxList.Items)
                {
                    if (requiredIds.Contains(Convert.ToInt32(item.Value)))
                        item.Selected = true;
                }

                foreach (ListItem item in preferredSkillsCheckboxList.Items)
                {
                    if (preferredIds.Contains(Convert.ToInt32(item.Value)))
                        item.Selected = true;
                }
                handleJobTypeInputFields();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string description = txtDescription.Text.Trim();
            string salaryFrom = txtSalaryFrom.Text.Trim();
            string salaryTo = txtSalaryTo.Text.Trim();
            string stipend = txtStipend.Text.Trim();
            string jobType = radioJobType.SelectedValue;

            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string updateQuery = @"UPDATE jobs 
                                       SET name=@Name, description=@Description, 
                                           salary_range_start=@SalaryStart, 
                                           salary_range_end=@SalaryEnd, 
                                           stipend=@Stipend, 
                                           job_type=@JobType
                                       WHERE id=@JobId";
                MySqlCommand updateCmd = new MySqlCommand(updateQuery, conn);
                updateCmd.Parameters.AddWithValue("@Name", name);
                updateCmd.Parameters.AddWithValue("@Description", description);
                updateCmd.Parameters.AddWithValue("@JobType", jobType);
                updateCmd.Parameters.AddWithValue("@JobId", jobId);

                if (jobType.Equals("JOB"))
                {
                    updateCmd.Parameters.AddWithValue("@SalaryStart", salaryFrom);
                    updateCmd.Parameters.AddWithValue("@SalaryEnd", salaryTo);
                    updateCmd.Parameters.AddWithValue("@Stipend", "0");
                }
                else if (jobType.Equals("INTERNSHIP"))
                {
                    updateCmd.Parameters.AddWithValue("@SalaryStart", "0");
                    updateCmd.Parameters.AddWithValue("@SalaryEnd", "0");
                    updateCmd.Parameters.AddWithValue("@Stipend", stipend);
                }
                else
                {
                    updateCmd.Parameters.AddWithValue("@SalaryStart", salaryFrom);
                    updateCmd.Parameters.AddWithValue("@SalaryEnd", salaryTo);
                    updateCmd.Parameters.AddWithValue("@Stipend", stipend);
                }


                int rows = updateCmd.ExecuteNonQuery();

                string deleteSkills = "DELETE FROM job_skills WHERE job_id = @JobId";
                MySqlCommand delCmd = new MySqlCommand(deleteSkills, conn);
                delCmd.Parameters.AddWithValue("@JobId", jobId);
                delCmd.ExecuteNonQuery();

                List<string> valuePlaceholders = new List<string>();
                MySqlCommand insertCmd = new MySqlCommand();
                insertCmd.Connection = conn;
                insertCmd.Parameters.AddWithValue("@JobId", jobId);

                int index = 0;
                foreach (ListItem item in requiredSkillsCheckboxList.Items)
                {
                    if (item.Selected)
                    {
                        string param = "@Skill" + index++;
                        valuePlaceholders.Add($"(@JobId,'REQUIRED',{param})");
                        insertCmd.Parameters.AddWithValue(param, item.Value);
                    }
                }
                foreach (ListItem item in preferredSkillsCheckboxList.Items)
                {
                    if (item.Selected)
                    {
                        string param = "@Skill" + index++;
                        valuePlaceholders.Add($"(@JobId,'PREFERRED',{param})");
                        insertCmd.Parameters.AddWithValue(param, item.Value);
                    }
                }

                if (valuePlaceholders.Count > 0)
                {
                    insertCmd.CommandText = $"INSERT INTO job_skills (job_id, type, skill_id) VALUES {string.Join(", ", valuePlaceholders)}";
                    insertCmd.ExecuteNonQuery();
                    Response.Redirect("/Jobs?action=update&success=true");
                }


            }
        }

        protected void jobTypeRadioButtonList_SelectedIndexChanged(object sender, EventArgs e)
        {
            handleJobTypeInputFields();
        }

        private void handleJobTypeInputFields()
        {
            string selectedType = radioJobType.SelectedValue;
            if (selectedType == "INTERNSHIP")
            {
                stipendDiv.Visible = true;
                salaryFromDiv.Visible = false;
                salaryToDiv.Visible = false;
            }
            else if (selectedType == "JOB")
            {
                stipendDiv.Visible = false;
                salaryFromDiv.Visible = true;
                salaryToDiv.Visible = true;
            }
            else
            {
                stipendDiv.Visible = true;
                salaryFromDiv.Visible = true;
                salaryToDiv.Visible = true;
            }
        }
    }
}
