# avaya-ip-office-http-directory
Tiny shim to allow SQL Server directories to be used in Avaya IP Office 
  
Tested with: Avaya IP Office Server Edition R8.1(69)  
Requires: IIS, ASP.NET, Microsoft URL Rewrite 2.0  
  
Instructions:  
1. Extract zip into wwwroot, check SQL connection string and query in .aspx file.  
2. Ensure http://\<IP of server\>/system/dir/cfg_dir_list returns directory.  
3. Configure IP office to use HTTP directory in "IP Office" mode with IP of web server and "configuration only".  
4. Verify contacts are appearing on your phones. There should be a special "zzLastUpdated" entry with the date and time of last sync encoded clumsily as the phone number.


Note: I'm not affliated with Avaya, this might crash your phone system, etc.
