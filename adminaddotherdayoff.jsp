
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
        String SITEID = request.getParameter("SITEID");      	
        out.print("<center><table><tr><td><img border=0 src=\"icons/risks.png\"></td><td><strong><h1>Add other day off</h1></strong></td></tr></table></center><hr>");
        out.print("You are here : Administration \\ <A HREF=\"adminlocation.jsp?TODO=NONE\" target=\"appliFrame\">Divisions and sites </A>\\ <A HREF=\"admincalendar.jsp?TODO=NONE&SITEID="+SITEID+"\" target=\"appliFrame\"> Site calendar </A>\\ Add other day off");
        out.print("<hr>");
        Calendar rn= Calendar.getInstance();
        String DAYOFF = ""+rn.get(Calendar.YEAR)+"-"+(rn.get(Calendar.MONTH)+1)+"-"+rn.get(Calendar.DATE);
        String EMPLOYEEID="";
        String IMPACT="0";
        String LIKELIHOOD="0";
        String ESCALATE="N";
        String CLOSED="N";
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"admincalendar.jsp?TODO=OTHERADD&SITEID="+SITEID+"\" target=\"appliFrame\">");
        out.print("<table>");
        out.print("<tr><td>Date day off : </td><td><input name=\"DAYOFF\" type=\"text\" size=\"50\" value=\""+DAYOFF+"\" readonly=\"readonly\">");
    	out.print("<script language=\"JavaScript\"> new tcal ({'formname': 'formFILTER','controlname': 'DAYOFF'}); </script>");
        out.print("</td></tr>");
        out.print("</table>");
        out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/add.png\" type=image Value=submit></td>");
        out.print("<td><A HREF=\"admincalendar.jsp?TODO=NONE&SITEID="+SITEID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        out.print("</table>");
        out.print("</form>");
        Conn.close();
      }

    %>
  </body>
</html>