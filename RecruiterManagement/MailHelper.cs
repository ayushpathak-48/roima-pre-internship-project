using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace RecruiterManagement
{
    public class MailHelper
    {
        public static void SendEmail(string toEmail, string subject, string bodyContent)
        {
            string fromEmail = ConfigurationManager.AppSettings["EmailFrom"];
            string appPassword = ConfigurationManager.AppSettings["EmailPassword"];


            string body = $@"
<body style='margin:0; padding:0; background-color:#f3f4f6; font-family:Arial, Helvetica, sans-serif;'>

  <table width='100%' cellpadding='0' cellspacing='0' style='background-color:#f3f4f6; padding:5px;'>
    <tr>
      <td align='center'>
        <table width='600' cellpadding='0' cellspacing='0' style='background-color:#ffffff; border-radius:6px; overflow:hidden;'>

          <tr>
            <td style='background-color:#1f2937; padding:16px 24px;text-align:center;'>
              <h2 style='margin:0; color:#ffffff; font-size:20px;'>
                Recruit Manager
              </h2>
            </td>
          </tr>

          <tr>
            {bodyContent}
          </tr>

          <tr>
            <td style='background-color:#f9fafb; padding:12px 24px; text-align:center; font-size:12px; color:#6b7280;'>
              © 2026 Recruit Manager. All rights reserved.
            </td>
          </tr>

        </table>
      </td>
    </tr>
  </table>

</body>";


            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(fromEmail,"Recruit Manager");
            mail.To.Add(toEmail);
            mail.Subject = subject;
            mail.Body = body;
            mail.IsBodyHtml = true;

            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new NetworkCredential(fromEmail, appPassword);
            smtp.EnableSsl = true;

            smtp.Send(mail);
        }
    }
}