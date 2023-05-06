<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css"> 
body { color: black; font-family: arial; font-size: 12px}
h1 { color: black; font-family: arial; font-size: 18px}

 </style>
</head>


    <%-- PPPM.ORG, the OpenSource PPM (Portfolio, Project and Program management) system --%>
    <%-- Copyright (C) 2012  Olivier Moulin --%>

    <%-- This program is free software: you can redistribute it and/or modify --%>
    <%-- it under the terms of the GNU General Public License as published by --%>
    <%-- the Free Software Foundation, version 3 of the License. --%>

    <%-- This program is distributed in the hope that it will be useful, --%>
    <%-- but WITHOUT ANY WARRANTY; without even the implied warranty of --%>
    <%-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the --%>
    <%-- GNU General Public License for more details. --%>



<body>

<%
String error_log = (String)session.getAttribute("ERROR_LOGIN");

out.print("<link href=\"substancesCSS.css\" rel=\"stylesheet\" type=\"text/css\">");
out.print("<p>&nbsp;</p>");
out.print("<p align=\"center\">&nbsp;</p>");
out.print("<div align=\"center\">");
out.print("<table width=\"60%\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\">");
out.print("<tr>");
out.print("<td background=\"fond_windows.gif\">");
out.print("<p align=\"center\"><font color=\"#3399CC\" size=\"5\" face=\"Arial, Helvetica, sans-serif\"><strong>IT-REP v1.0</strong></font></p>");
out.print("<p align=\"center\">Please Log-In</p>");
out.print("<form name=\"form1\" method=\"post\" action=\"login_database.jsp\" target=\"_top\">");
out.print("<table width=\"80%\" border=\"0\" align=\"center\">");
out.print("<tr>");
out.print("<td width=\"40%\">Login :</td>");
out.print("<td width=\"60%\"><input type=\"text\" name=\"UserLogin\"> </td></tr>");
out.print("<tr><td>&nbsp</td><td>Please enter DOMAIN\\login<br> </td>");
out.print("</tr>");
out.print("<tr>");
out.print("<td>Password:</td>");
out.print("<td><input type=\"password\" name=\"UserPassword\"></td>");
out.print("</tr>");
out.print("<tr>");
out.print("<td>&nbsp;</td>");
out.print("<td>&nbsp;</td>");
out.print("</tr>");
out.print("<tr>");
out.print("<td colspan=\"2\"><div align=\"center\">");
out.print("<input type=\"submit\" name=\"Submit2\" value=\"Submit\">");
out.print("</div></td>");
out.print("</tr>");
out.print("</table>");
out.print("<p>&nbsp;</p></form>");
out.print("</td>");
out.print("</tr>");
out.print("</table>");
out.print("</div>");
if (error_log!=null) {
  if (error_log.equals("NOLDAP")) {
    out.print("<p><center>You have entered bad credentials, please check and try again !</center></p>");
  }
  if (error_log.equals("NOLOCAL")) {
    out.print("<p><center>You have no local account on this application, please check and try again !</center></p>");
  }
  if (error_log.equals("DISABLED")) {
    out.print("<p><center>Your account on this application is disabled, please contact your administrator !</center></p>");
  }
}
out.print("<p>");
%>
</p>
</body>
</html>
