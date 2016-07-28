# avaya-ip-office-http-directory
Tiny shim to allow SQL Server directories to be used in Avaya IP Office 

Tested with: Avaya IP Office Server Edition R8.1(69)
Requires: Microsoft IIS, ASP.NET, Microsoft URL Rewrite 2.0

Instructions: 
1. Extract zip into wwwroot, check SQL connection string and query in .aspx file.
3. Ensure http://<IP of server>/system/dir/cfg_dir_list returns directory
2. Configure IP office to use HTTP directory in "IP Office" mode with IP of web server and "configuration only".