using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RecruiterManagement.Models
{
    public enum Gender
    {
        Male,
        Female,
        Other
    }
    public class Candidate
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public Gender Gender { get; set; }
        public string Date_Of_Birth { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Education { get; set; }
        public string Experience_Years { get; set; }
        public string Current_Position { get; set; }
        public string Expected_Salary { get; set; }
        public string Status { get; set; }
        public string Skills { get; set; }
    }
}