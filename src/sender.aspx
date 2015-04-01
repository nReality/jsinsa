<%@ Page Language="C#" %>

<%
        try
        {

      			string message = "";

      			Response.Cache.SetCacheability(HttpCacheability.NoCache);
      			Response.ContentType = "text/plain";
            bool sponsor = false;
            bool speaker = false;
      			foreach (string key in Request.QueryString.Keys)
      			{
      			  message += key + "   :   " + Request.QueryString[key]+ System.Environment.NewLine;
      			  if (Request.QueryString[key].ToUpper().Contains("SPONSOR"))
                sponsor = true;
              if (Request.QueryString[key].ToUpper().Contains("SELFELEVATORPITCH"))
                speaker = true;  
                
      			}
              
      			if(message == "")
      				throw new Exception("Nothing filled in.");
      			
            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
            mail.From = new System.Net.Mail.MailAddress("jubjub@brokenkeyboards", "JSinSA incoming");
            mail.To.Add("info@jsinsa.com");
            
            if(sponsor)
              mail.Subject = "JSinSA possible sponsor";
            else if(speaker)
              mail.Subject = "JSinSA possible speaker";
            else
              mail.Subject = "JSinSA";
            mail.Body = message; //Request.QueryString.ToString();

            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();
            smtp.UseDefaultCredentials = false;
            //smtp.Host = "mymail.brinkster.com";
            smtp.Host = "mymail.brinkster.com";
            smtp.Port = 25;
            smtp.Credentials = new System.Net.NetworkCredential("jubjub@brokenkeyboards.com", "1232FSAFASewr");
            smtp.Send(mail);

      			string json = "" 
      				+ "["
      				+ "{\"Success\":\"1\",\"Result\":\"" + "WORKED" + "\"}"
      				+ "]"
      				+ "";


                  Response.Write(json);
        }
        catch (Exception ee)
        {
      			string json = "" 
      				+ "["
      				+ "{\"Success\":\"0\",\"Result\":\"" + ee.Message + "\"}"
      				+ "]"
      				+ "";
                  Response.Write(json);
        }
        
%>


