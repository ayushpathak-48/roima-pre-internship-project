using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RecruiterManagement.Models
{
    public class User
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }  // optional
        public string Role { get; set; }
    }
}