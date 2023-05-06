
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
 
  <body background="images/fond.gif">
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
        String Language = (String)session.getAttribute("LANGUAGE");
        String act = request.getParameter("TODO");
        String SITEID = request.getParameter("SITEID");
      	out.print("<center><strong><h1>Project Manager</h1></strong></center><hr>");
        out.print("You are here : Administration \\ <A HREF=\"adminlocation.jsp?TODO=NONE\" target=\"appliFrame\"> Divisions and sites</A> \\ <A HREF=\"admincalendar.jsp?TODO=NONE&SITEID="+SITEID+"\" target=\"appliFrame\"> Calendar management</A> \\ Add weekly day off");
        out.print("<hr>");
        out.print("<table>");
        out.print("<tr><td>Day</td>");
        out.print("<tr><td><A HREF=\"admincalendar.jsp?TODO=WEEKADD&DAYOFF=0&SITEID="+SITEID+"\">SUNDAY</td>");
        out.print("<tr><td><A HREF=\"admincalendar.jsp?TODO=WEEKADD&DAYOFF=1&SITEID="+SITEID+"\">MONDAY</td>");
        out.print("<tr><td><A HREF=\"admincalendar.jsp?TODO=WEEKADD&DAYOFF=2&SITEID="+SITEID+"\">TUESDAY</td>");
        out.print("<tr><td><A HREF=\"admincalendar.jsp?TODO=WEEKADD&DAYOFF=3&SITEID="+SITEID+"\">WEDNESDAY</td>");
        out.print("<tr><td><A HREF=\"admincalendar.jsp?TODO=WEEKADD&DAYOFF=4&SITEID="+SITEID+"\">THURSDAY</td>");
        out.print("<tr><td><A HREF=\"admincalendar.jsp?TODO=WEEKADD&DAYOFF=5&SITEID="+SITEID+"\">FRIDAY</td>");
        out.print("<tr><td><A HREF=\"admincalendar.jsp?TODO=WEEKADD&DAYOFF=6&SITEID="+SITEID+"\">SATURDAY</td>");
        out.print("</table>");
        out.print("<A HREF=\"admincalendar.jsp?TODO=NONE&SITEID="+SITEID+"\"><img border=0 src=\"icons/cancel.png\"></A>");
        Conn.close();
      }

    %>
  </body>
</html>
