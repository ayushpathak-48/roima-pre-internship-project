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
    public partial class Add : System.Web.UI.Page
    {
        public List<Skill> SkillsList = new List<Skill>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            LoadSkills();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text;
            string description = txtDescription.Text;
            string salary_from = txtSalaryFrom.Text;
            string salary_to = txtSalaryTo.Text;
            string stipend = txtStipend.Text;
            string job_type = radioJobType.SelectedValue;
            using (MySqlConnection conn = DBConn.GetConnection())
            {
                string query = "INSERT INTO jobs (`name`,`description`,`salary_range_start`,`salary_range_end`,`stipend`,`job_type`) VALUES (@Name,@Description,@SalaryStart,@SalaryEnd,@Stipend,@JobType)";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@SalaryStart", salary_from);
                cmd.Parameters.AddWithValue("@SalaryEnd", salary_to);
                cmd.Parameters.AddWithValue("@Stipend", stipend);
                cmd.Parameters.AddWithValue("@JobType", job_type);
                int jobRows = cmd.ExecuteNonQuery();
                if (jobRows > 0)
                {
                    long jobId = cmd.LastInsertedId;
                    List<int> selectedRequiredSkillIds = new List<int>();
                    List<int> selectedPreferredSkillIds = new List<int>();

                    foreach (ListItem item in requiredSkillsCheckboxList.Items)
                    {
                        if (item.Selected)
                        {
                            selectedRequiredSkillIds.Add(Convert.ToInt32(item.Value));
                        }
                    }

                    foreach (ListItem item in preferredSkillsCheckboxList.Items)
                    {
                        if (item.Selected)
                        {
                            selectedPreferredSkillIds.Add(Convert.ToInt32(item.Value));
                        }
                    }

                    List<string> valuePlaceholders = new List<string>();
                    MySqlCommand insertJobSkillsCmd = new MySqlCommand();

                    for (int i = 0; i < selectedRequiredSkillIds.Count; i++)
                    {
                        string paramName = "@ReqSkill" + i;
                        valuePlaceholders.Add($"(@JobId,'REQUIRED', {paramName})");
                        insertJobSkillsCmd.Parameters.AddWithValue(paramName, selectedRequiredSkillIds[i]);
                    }

                    for (int i = 0; i < selectedPreferredSkillIds.Count; i++)
                    {
                        string paramName = "@PrefSkill" + i;
                        valuePlaceholders.Add($"(@JobId,'PREFERRED', {paramName})");
                        insertJobSkillsCmd.Parameters.AddWithValue(paramName, selectedPreferredSkillIds[i]);
                    }

                    string insertQuery = $"INSERT INTO job_skills (job_id, type,skill_id) VALUES {string.Join(", ", valuePlaceholders)}";

                    insertJobSkillsCmd.CommandText = insertQuery;
                    insertJobSkillsCmd.Connection = conn;
                    insertJobSkillsCmd.Parameters.AddWithValue("@JobId", jobId);

                    int skillsinserted = insertJobSkillsCmd.ExecuteNonQuery();

                    if (skillsinserted > 0)
                    {
                        Response.Redirect("/Jobs?action=addjob&success=true");
                    }
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
    }
}