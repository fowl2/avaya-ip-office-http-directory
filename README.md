# avaya-ip-office-http-directory
Tiny shim to allow names and phone numbers from SQL Server to be displayed in Avaya IP Office contacts/directories.

We use this because the default LDAP support doesn't handle matching caller ID against E.164 (ie. international format, begining with a plus) format numbers, our AD has duplicates, etc, and we already had a copy sitting in SQL.
  
Tested with: Avaya IP Office Server Edition R8.1(69) and R8.1()  

Requires
---
- IIS
- ASP.NET
- Microsoft URL Rewrite 2.0
- a SQL Server with a phone contacts  
  
Instructions
---
  1.  Extract zip into wwwroot, check SQL connection string and query in .aspx file.  
  2.  Ensure http://\<IP of server\>/system/dir/cfg\_dir\_list returns directory.  
  3.  Configure IP Office to use HTTP directory: Open Manager, then set the following under System -> Directory Services -> HTTP:
    *  Directory Type: "IP Office"  
    *  Source: IP of web server  
    *  List: "configuration only"

Once everything is working there should be a special "zzLastUpdated" entry with the date and time of last sync encoded clumsily as the phone number.  
  
Note: I'm not affliated with Avaya, this might crash your phone system, etc.
