/*	Example view
 
	Formats both mobile and landline E164 numbers into a local format dialable from and Australian ISDN trunk.
	Adds country or state when not "AU" and "VIC", plus "M" for mobile
	Add "(?)" when there is more than one person with the same number.

   Assumes you have a table called "Employee" with both:
      * "Phone" and "Mobile" collumns with pretty E.164 numbers 
	  * "FullName", "Country" and "State", "Disabled" columns
*/

CREATE VIEW [dbo].[AvayaIPOfficeDirectoryView] as 
with allRecords AS (
	SELECT	 FullName
			, CASE WHEN Country <> 'AU' THEN ' (' + Country  +') M' ELSE
			  CASE WHEN [State] <> 'VIC' THEN ' ('+ State + ')' ELSE '' END
			  + ' M' END															AS TypeSuffix
			, REPLACE(REPLACE(REPLACE(Mobile, ' ', ''), '+61', '0'), '+', '00(11)') AS Numb
	FROM Employee
	WHERE LEN(Mobile) > 5 AND Disabled = 0
	UNION
	SELECT	 FullName
			, CASE WHEN Country <> 'AU' THEN ' (' + Country  +') M' ELSE
			  CASE WHEN [State] <> 'VIC' THEN ' ('+ State + ')' ELSE '' END
			  + '' END																AS TypeSuffix
			, REPLACE(REPLACE(REPLACE(Phone, ' ', ''), '+61', '0'), '+', '00(11)')	AS Numb	
	FROM dbo.Employee
	WHERE LEN(Phone) > 5 AND (Disabled = 0 or Person = 0)
	AND Phone like '+%' -- exclude 1800 number
)

SELECT MIN(Fullname) + MAX(TypeSuffix) 
 + CASE WHEN DENSE_RANK() OVER (PARTITION BY Numb ORDER BY FullName) +
             DENSE_RANK() OVER (PARTITION BY Numb ORDER BY FullName DESC) > 2 THEN '(?)' ELSE '' END AS Name,
	   Numb AS DialablePhoneNumber,
	   count(*) AS r 
FROM allRecords
GROUP BY FullName, numb
