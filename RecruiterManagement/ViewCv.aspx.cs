using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RecruiterManagement
{
    public partial class ViewCv : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string fileName = Request.QueryString["file"];
            string folderPath = Server.MapPath("~/Uploads/CVs");
            string filePath = Path.Combine(folderPath, fileName);

            if (!File.Exists(filePath))
                return;

            Response.ContentType = "application/pdf";
            Response.AddHeader("Content-Disposition", "inline; filename=" + fileName);
            Response.TransmitFile(filePath);
            Response.End();
        }

    }
}