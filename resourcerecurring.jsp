
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
        String EMPLOYEEID = request.getParameter("EMPLOYEEID");
        String RECURRINGID = request.getParameter("RECURRINGID");
        String ORD = request.getParameter("ORD");
      	out.print("<center><strong><h1>Recurring workload</h1></strong></center><hr>");
         String WORKLOAD = "";
        String DATE_START = "";
        String DATE_END = "";
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"resourcecapacity.jsp?TODO=LOADMOD&ORD="+ORD+"&EMPLOYEEID="+EMPLOYEEID+"&RECURRINGID="+RECURRINGID+"\" target=\"_top\">");
        Statement st10 = Conn.createStatement();
        String q10 = "SELECT WORKLOAD,DATE_START,DATE_END FROM EMPREC WHERE ORD="+ORD+" AND EMPLOYEEID='"+EMPLOYEEID+"' AND RECURRINGID='"+RECURRINGID+"'";
        ResultSet r10 = st10.executeQuery(q10);
        if (r10.next()) {
          WORKLOAD=r10.getString("WORKLOAD");
          DATE_START=r10.getString("DATE_START");
          DATE_END=r10.getString("DATE_END");
        }
        st10.close();
        out.print("<table>");
        out.print("<tr><td>Workload (hours per month) : </td><td><input name=\"WORKLOAD\" type=\"text\" size=\"50\" value=\""+WORKLOAD+"\"></td></tr>");
        out.print("<tr><td>Date start : </td><td><input name=\"DATE_START\" type=\"text\" size=\"50\" value=\""+DATE_START+"\" readonly=\"readonly\">");
        out.print("<script language=\"JavaScript\"> new tcal ({'formname': 'formFILTER','controlname': 'DATE_START'}); </script>");
        out.print("</td></tr>");
        out.print("<tr><td>Date end : </td><td><input name=\"DATE_END\" type=\"text\" size=\"50\" value=\""+DATE_END+"\" readonly=\"readonly\">");  
        out.print("<script language=\"JavaScript\"> new tcal ({'formname': 'formFILTER','controlname': 'DATE_END'}); </script>");
        out.print("</td></tr></table>");
        out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/add.png\" type=image Value=submit></td>");
        out.print("<td><A HREF=\"resourcecapacity.jsp?TODO=NONE&EMPLOYEEID="+EMPLOYEEID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        out.print("</table>");
        out.print("</form>");
        Conn.close();
      }

    %>
  </body>
</html>
