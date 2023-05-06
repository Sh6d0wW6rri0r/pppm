
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Untitled Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css"> 
      body { color: black; font-family: arial; font-size: 11px}
      h1 { color: black; font-family: arial; font-size: 16px}
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
  <%@ page import = "java.util.*" %>
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>

  <body>
    <script language="JavaScript" src="javascript/calendar_db.js"></script>
    <link rel="stylesheet" href="javascript/calendar.css">
    <%
      // session attributes
      String Userlogin = (String)session.getAttribute("LOGIN");
      if (Userlogin==null) {
        out.print("<script language=\"JavaScript\">");
        out.print("top.location='index.jsp?TIMEOUT=TRUE';");
        out.print("</script>");
      } else {
        String POOLNAME=(String)session.getAttribute("POOLNAME");

        // database connection
        Context initCtx = new InitialContext();
        DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
        Connection Conn = ds.getConnection();

        // JSP parameters
        String act = request.getParameter("TODO");
        String LOGIN = request.getParameter("LOGIN");
        String currentpage= request.getParameter("PAGE");
      	out.print("<hr>");
        String NAME = "";
        String FORNAME = "";
        String LDAPLOGIN="";
        String DISABLED="";
        String MAIL="";
        if (act.equals("ADD")) {
          LOGIN="";
          out.print("<form name=\"formFILTER\" method=\"post\" action=\"user.jsp?TODO=ADD&PAGE="+currentpage+"\" target=\"appliFrame\">");
        } else {
          out.print("<form name=\"formFILTER\" method=\"post\" action=\"user.jsp?TODO=MOD&LOGIN="+LOGIN+"&PAGE="+currentpage+"\" target=\"appliFrame\">");
        }
        if (act.equals("MOD")) {
          Statement STR01 = Conn.createStatement();
          String QR01 = "SELECT NAME,FORNAME,LDAPLOGIN,DISABLED,MAIL FROM USERS WHERE LOGIN='"+LOGIN+"'";
          ResultSet R01 = STR01.executeQuery(QR01);
          if (R01.next()) {
            NAME=R01.getString("NAME");
            FORNAME=R01.getString("FORNAME");
            LDAPLOGIN=R01.getString("LDAPLOGIN");
            DISABLED=R01.getString("DISABLED");
            MAIL=R01.getString("MAIL");
          }
          STR01.close();
        }
        out.print("<table>");
        if (act.equals("ADD")) {
          out.print("<tr><td>Login : </td><td><input name=\"LOGIN\" type=\"text\" size=\"50\" value=\"\"></td></tr>");
        }   
        out.print("<tr><td>Name : </td><td><input name=\"NAME\" type=\"text\" size=\"50\" value=\""+NAME+"\"></td></tr>");
        out.print("<tr><td>Forname : </td><td><input name=\"FORNAME\" type=\"text\" size=\"50\" value=\""+FORNAME+"\"></td></tr>");
        out.print("<tr><td>LDAPlogin : </td><td><input name=\"LDAPLOGIN\" type=\"text\" size=\"50\" value=\""+LDAPLOGIN+"\"></td></tr>");
        out.print("<tr><td>Disabled : </td><td><INPUT TYPE=\"checkbox\" NAME=\"DISABLED\" VALUE=\"+DISABLED+\"");
        if (DISABLED.equals("Y")) {
          out.print(" CHECKED ");
        }
        out.print("></td></tr>");
        out.print("<tr><td>Mail : </td><td><input name=\"MAIL\" type=\"text\" size=\"50\" value=\""+MAIL+"\"></td></tr>");
        if (act.equals("ADD")) {
          out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/add.png\" type=image Value=submit></td>");
          out.print("<td><A HREF=\"user.jsp?TODO=NONE&PAGE="+currentpage+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        } else {  
          out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
          out.print("<td><A HREF=\"user.jsp?TODO=NONE&PAGE="+currentpage+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        }
        out.print("</table>");
        out.print("</form>");
        Conn.close();
      }

    %>
  </body>
</html>
