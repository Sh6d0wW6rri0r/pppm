<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>PPPM.org v1.0</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css"> 
  body { color: black; font-family: arial; font-size: 11px}
  h1 { color: black; font-family: arial; font-size: 16px}
</style> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.navbar {
    overflow: hidden;
    background-color: #333;
    font-family: Arial;
}

.navbar a {
    float: left;
    font-size: 16px;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

.dropdown {
    float: left;
    overflow: hidden;
}

.dropdown .dropbtn {
    cursor: pointer;
    font-size: 16px;    
    border: none;
    outline: none;
    color: white;
    padding: 14px 16px;
    background-color: inherit;
}

.navbar a:hover, .dropdown:hover .dropbtn {
    background-color: red;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    float: none;
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    text-align: left;
}

.dropdown-content a:hover {
    background-color: #ddd;
}

.show {
    display: block;
}
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



<%String Userlogin = (String)session.getAttribute("LOGIN");
  session.setAttribute("POOLNAME","PPPMPOOL");

  if (Userlogin==null) {
    // session  attributes
    String error_log = (String)session.getAttribute("ERROR_LOGIN");

    // JSP parameters
    String TIMEOUT = request.getParameter("TIMEOUT");
    out.print("<br><br><br>");
    out.print("<link href=\"substancesCSS.css\" rel=\"stylesheet\" type=\"text/css\">");
    out.print("<p>&nbsp;</p>");
    out.print("<p align=\"center\">&nbsp;</p>");
    out.print("<div align=\"center\">");
    if (TIMEOUT!=null) {
      out.print (" YOU HAVE BEEN DIRECTED TO THIS PAGE DUE TO A SESSION TIMEOUT, PLEASE LOG-IN AGAIN !");
    }
    out.print("<table width=\"60%\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\">");
    out.print("<tr>");
    out.print("<td background=\"fond_windows.gif\">");
    out.print("<p align=\"center\"><font color=\"#3399CC\" size=\"5\" face=\"Arial, Helvetica, sans-serif\"><strong>PPPM.org</strong></font></p>");
    out.print("<p align=\"center\">Please Log-In</p>");
    out.print("<form name=\"form1\" method=\"post\" action=\"login_database.jsp\" target=\"_top\">");
    out.print("<table width=\"80%\" border=\"0\" align=\"center\">");
    out.print("<tr>");
    out.print("<td width=\"40%\">Login :</td>");
    out.print("<td width=\"60%\"><input type=\"text\" name=\"UserLogin\"> </td></tr>");
    out.print("<tr><td>&nbsp;</td><td>Please enter DOMAIN\\login<br> </td>");
    out.print("</tr>");
    out.print("<tr>");
    out.print("<td>Password:</td>");
    out.print("<td><input type=\"password\" name=\"UserPassword\"></td>");
    out.print("</tr>");
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
  } else { %>
    <jsp:include page="mainmenu.jsp" />
    <%
    String ISLOCAL = (String)session.getAttribute("ISLOCAL");
    String POOLNAME=(String)session.getAttribute("POOLNAME");
    Context initCtx = new InitialContext();
    DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
    Connection Conn = ds.getConnection();
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

    out.print("<br><br><br>");
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
  }
%>
<body>

</body></noframes>
</html>
