<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Untitled Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css"> 
      body { color: black; font-family: arial; font-size: x-small}
      h1 { color: black; font-family: arial; font-size: small}
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

    <%-- You should have received a copy of the GNU General Public License --%>
    <%-- along with this program.  If not, see http://www.gnu.org/licenses/. --%>

 

  <%@ page import = "java.sql.*" %>
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>

  <body>

    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p align="center"><font color="#3399CC" size="5" face="Arial, Helvetica, sans-serif"><strong>PPPM.org</strong></font></p>

    <%
      //Session attributes
    
      String Userlogin = (String)session.getAttribute("LOGIN");
      String ISLOCAL = (String)session.getAttribute("ISLOCAL");
      String POOLNAME=(String)session.getAttribute("POOLNAME");

      // database connection
      Context initCtx = new InitialContext();
      DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
      Connection Conn = ds.getConnection();
    
      // JSP parameters
      String act = request.getParameter("TODO");

      if (act==null) {
        act="";
      }

      if (act.equals("DEF")) {
        String LOGIN = request.getParameter("LOGIN");
        String OLDPWD = request.getParameter("OLDPWD");
        String NEWPWD1 = request.getParameter("NEWPWD1");
        String NEWPWD2 = request.getParameter("NEWPWD2");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT * FROM USERS WHERE LOGIN='"+LOGIN+"'";
        ResultSet R01 = STR01.executeQuery(QR01);
        R01.next();
        if (OLDPWD.equals(R01.getString("PWD"))) {
          if (NEWPWD1.equals(NEWPWD2)) {
            Statement STU01 = Conn.createStatement();
            String QU01 = "UPDATE USERS SET PWD='"+NEWPWD1+"' WHERE LOGIN='"+LOGIN+"'";
            STU01.executeUpdate(QU01);
            STU01.close();
          } else {
            out.print("<center><strong>Error : The new passwords are not the same !</strong></center>");
          }
        } else {
          out.print("<center><strong>Error : Old password invalid !</strong></center>");
        }
        STR01.close();
      }
      out.print("<table width=\"45%\" border=\"1\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">");
      out.print("<tr>");
      out.print("<td bgcolor=\"FFFFFF\"><center><p><strong>Welcome</strong></p>");
      out.print("<p>&nbsp;</p>");
      Statement STR02 = Conn.createStatement();
      String QR02 = "SELECT * FROM USERS WHERE LOGIN='"+Userlogin+"'";
      ResultSet R02 = STR02.executeQuery(QR02);
      if (R02.next()) {
        String returnedName = R02.getString("NAME")+" "+R02.getString("FORNAME");
        out.print("<p><strong>"+Userlogin+" - "+returnedName+"</strong></p>");
        if (ISLOCAL.equals("YES")) {
          out.print("<p><A HREF=\"passwd.jsp?LOGIN="+Userlogin+"\">Change Password</A></p>");
        }  
      }
      STR02.close();
      out.print("<p>&nbsp;</p></center></td>");
      out.print("</tr>");
      out.print("</table>");
      Conn.close();
    %>
  </body>
</html>
