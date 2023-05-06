<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css"> 
      body { color: black; font-family: arial; font-size: x-small}
      h1 { color: black; font-family: arial; font-size: small}
    </style> 
  </head>

    <%-- Vortex PPM, the OpenSource PPM (Portfolio, Project and Program management) system --%>
    <%-- Copyright (C) 2012  Olivier Moulin --%>

    <%-- This program is free software: you can redistribute it and/or modify --%>
    <%-- it under the terms of the GNU General Public License as published by --%>
    <%-- the Free Software Foundation, version 3 of the License. --%>

    <%-- This program is distributed in the hope that it will be useful, --%>
    <%-- but WITHOUT ANY WARRANTY; without even the implied warranty of --%>
    <%-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the --%>
    <%-- GNU General Public License for more details. --%>

    <%-- You should have received a copy of the GNU General Public License --%>
    <%-- along with this program.  If not, see http://www.gnu.org/licenses/. --%>


  <%@ page import = "java.sql.*" %>
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>

  <body background="fond_appli.jpg">
    <font size="-1">
    <%
      // database connection
      Context initCtx = new InitialContext();
      DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/STRPPMPOOL");
      Connection Conn = ds.getConnection();
  
      // JSP parameters
      String LOGIN = request.getParameter("LOGIN");

      Statement STR01 = Conn.createStatement();
      String QR01 = "SELECT * FROM USERS WHERE LOGIN='"+LOGIN+"'";
      ResultSet R01 = STR01.executeQuery(QR01);
      R01.next();
      out.print("<strong><center><h1>"+LOGIN+" - "+R01.getString("FORNAME")+" "+R01.getString("NAME")+"</H1></center></strong>");
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
      Conn.close();
%>
</font>
</body>
</html>
