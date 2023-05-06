<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>ASK-IT : IT Enhancement Request System</title>
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



<%@ page import = "java.sql.*" %>

<body background="fond_appli.jpg">
<font size="-1">
<%
  Connection Conn = (Connection)session.getAttribute("DBConnection");

  String LOGIN = request.getParameter("LOGIN");

  Statement st5 = Conn.createStatement();
  String q5 = "SELECT * FROM USERS WHERE LOGIN='"+LOGIN+"'";
  ResultSet r5 = st5.executeQuery(q5);
  r5.next();
  out.print("<strong><center><h1>"+LOGIN+" - "+r5.getString("NAME")+" "+r5.getString("FORNAME")+"</H1></center></strong>");
  out.print("<center><h1>Change of user's password</h1></center>");
  out.print("<br><hr>");
  out.print("<form name=\"form\" method=\"post\" action=\"firstpage.jsp?TODO=DEF&LOGIN="+LOGIN+"\" target=\"mainFrame\">");
  out.print("<center><table>");
  out.print("<tr><td>Old password</td>"); 
  out.print("<td><input name=\"OLDPWD\" type=\"password\" size=\"50\" value=\"\"></td></tr>");
  out.print("<tr><td>New password</td>"); 
  out.print("<td><input name=\"NEWPWD1\" type=\"password\" size=\"50\" value=\"\"></td></tr>");
  out.print("<tr><td>New password verification</td>"); 
  out.print("<td><input name=\"NEWPWD2\" type=\"password\" size=\"50\" value=\"\"></td></tr>");
  out.print("</table></center>");
  out.print("<br><br><center><input type=\"submit\" name=\"MAJ\" value=\"Set\"></center>");
  out.print("</form>");  
%>
</font>
</body>
</html>
