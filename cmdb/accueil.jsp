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



<%@ page import = "java.sql.*" %>

<body background="images/comp023.gif">
<p>&nbsp;</p>
<p>&nbsp;</p>
<p align="center"><font color="#3399CC" size="5" face="Arial, Helvetica, sans-serif"><strong>IT Repository</strong></font></p>

<%String Userlogin = (String)session.getAttribute("LOGIN");
  Connection Conn = (Connection)session.getAttribute("DBConnection");
  String act = request.getParameter("TODO");
  if (act==null) {
    act="";
  }

  if (act.equals("DEF")) {
    String LOGIN = request.getParameter("LOGIN");
    String OLDPWD = request.getParameter("OLDPWD");
    String NEWPWD1 = request.getParameter("NEWPWD1");
    String NEWPWD2 = request.getParameter("NEWPWD2");
    Statement stmt20 = Conn.createStatement();
    String query20 = "SELECT * FROM USERS WHERE LOGIN='"+LOGIN+"'";
    ResultSet rs20 = stmt20.executeQuery(query20);
    rs20.next();
    if (OLDPWD.equals(rs20.getString("PWD"))) {
      if (NEWPWD1.equals(NEWPWD2)) {
        Statement sti2 = Conn.createStatement();
        String i2 = "UPDATE USERS SET PWD='"+NEWPWD1+"' WHERE LOGIN='"+LOGIN+"'";
        sti2.executeUpdate(i2);
        sti2.close();
      } else {
        out.print("<center><strong>Error : The new passwords are not the same !</strong></center>");
      }
    } else {
      out.print("<center><strong>Error : Old password invalid !</strong></center>");
    }
  }
  out.print("<table width=\"45%\" border=\"1\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">");
  out.print("<tr>");
  out.print("<td bgcolor=\"FFFFFF\"><center><p><strong>Welcome</strong></p>");
  out.print("<p>&nbsp;</p>");

  Statement stmt = Conn.createStatement();
  String query = "SELECT * FROM USERS WHERE LOGIN='"+Userlogin+"'";
  ResultSet rs = stmt.executeQuery(query);
  if (rs.next()) {
    String returnedName = rs.getString("NAME")+" "+rs.getString("FORNAME");
    out.print("<p><strong>"+Userlogin+" - "+returnedName+"</strong></p>");
      out.print("<p><A HREF=\"passwd.jsp?LOGIN="+Userlogin+"\">Change Password</A></p>");
  }
  out.print("<p>&nbsp;</p></center></td>");
  out.print("</tr>");
  out.print("</table>");
%>
<div align="center"></div>
<div align="center"></div>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>
