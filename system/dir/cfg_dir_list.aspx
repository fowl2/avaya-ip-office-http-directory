<%@ Page Language="C#" Debug="false" %>

<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
    Response.ContentType = "text/xml";

    using (XmlTextWriter xmlOut = new XmlTextWriter(Response.Output))
    {
        xmlOut.WriteStartDocument(true);
        xmlOut.WriteStartElement("corporate_dir", "http://www.avaya.com/ipoffice/corporatedirectory");
        xmlOut.WriteAttributeString("xmlns", "xsi", null, "http://www.w3.org/2001/XMLSchema-instance");
        xmlOut.WriteAttributeString("xsi", "schemaLocation", null, "http://www.avaya.com/ipoffice/corporatedirectory corporate_dir.xsd");
        
        xmlOut.WriteElementString("data_source", "IPOFFICE/8.1(69) " + Request.ServerVariables["LOCAL_ADDR"]);
        xmlOut.WriteElementString("content", "cfg_directory");
        
        xmlOut.WriteStartElement("modified");
        xmlOut.WriteValue(DateTime.UtcNow);
        xmlOut.WriteEndElement();
        
        xmlOut.WriteElementString("stale_data", "false");
        
        xmlOut.WriteStartElement("list");
        using (SqlConnection db = new SqlConnection("Data Source=.;Initial Catalog=DatabaseName;"))
        {
            db.Open();
            using (SqlCommand cmd = db.CreateCommand())
            {
                cmd.CommandText = @"SELECT Name, DialablePhoneNumber FROM dbo.AvayaIPOfficeDirectoryView";
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        xmlOut.WriteElementString("name", reader["Name"].ToString());
                        xmlOut.WriteElementString("numb", reader["DialablePhoneNumber"].ToString());
                    }
                }
            }
        }

        xmlOut.WriteElementString("name", "zzLastUpdated");
        xmlOut.WriteElementString("numb", DateTime.Now.ToString("yyyyMMdd-HHmmss"));
        xmlOut.WriteEndElement();
        xmlOut.WriteEndElement();
        xmlOut.WriteEndDocument();
    }
%>