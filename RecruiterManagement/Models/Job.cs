using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RecruiterManagement.Models
{
    public class Job
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Status { get; set; }
        public string Description { get; set; }
        public string AppliedCount { get; set; }
        public string SalaryFrom { get; set; }
        public string SalaryTo { get; set; }
        public string Stipend { get; set; }
        public string Type { get; set; }
        public string Required_Skills { get; set; }
        public string Preferred_Skills { get; set; }

        public string ReviewerName { get; set; }
        public string ReviewerEmail { get; set; }
    }
}