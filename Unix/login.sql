--   login.sql
--   SQL*Plus user login startup file.
--
--   This script is automatically run after glogin.sql
--
-- To change the SQL*Plus prompt to display the current user,
-- connection identifier and current time.
-- First set the database date format to show the time.
ALTER SESSION SET nls_date_format = 'YYYY-MM-DD HH24:MI:SS';

-- SET the SQLPROMPT to include the _USER, _CONNECT_IDENTIFIER
-- and _DATE variables.
SET SQLPROMPT "_USER'@'_CONNECT_IDENTIFIER _DATE> "

-- To set the number of lines to display in a report page to 24.
SET PAGESIZE 60

-- To set the number of characters to display on each report line to 78.
SET LINESIZE 150

-- To set the number format used in a report to $99,999.
--SET NUMFORMAT $99,999
SET NUMFORMAT ""

