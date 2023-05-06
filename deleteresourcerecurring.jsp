
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
        String act = request.getParameter("TODO");
        String EMPLOYEEID = request.getParameter("EMPLOYEEID");
        String RECURRINGID = request.getParameter("RECURRINGID");
        String ORD = request.getParameter("ORD");      	
        out.print("<center><strong><h1>Resource recurring workload delete approval</h1></strong></center><hr>");
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"resourcecapacity.jsp?TODO=LOADDELETE&EMPLOYEEID="+EMPLOYEEID+"&RECURRINGID="+RECURRINGID+"&ORD="+ORD+"\" target=\"_top\">");
        out.print("<table>");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT * FROM EMPLOYEE WHERE ID='"+EMPLOYEEID+"'";
        ResultSet R01 = STR01.executeQuery(QR01);
        if (R01.next()) {
          out.print("<tr><td>Resource name: </td><td>"+R01.getString("NAME")+"</td></tr>");
          out.print("<tr><td>Resource forname: </td><td>"+R01.getString("FORNAME")+"</td></tr>");
        }
        STR01.close();
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT * FROM RECURRING WHERE ID='"+RECURRINGID+"'";
        ResultSet R02 = STR02.executeQuery(QR02);
        if (R02.next()) {
          out.print("<tr><td>Recurring workload name: </td><td>"+R02.getString("NAME")+"</td></tr>");
        }
        STR02.close();
        Statement STR03 = Conn.createStatement();
        String QR03 = "SELECT * FROM EMPREC WHERE RECURRINGID='"+RECURRINGID+"' AND EMPLOYEEID='"+EMPLOYEEID+"' AND ORD="+ORD;
        ResultSet R03 = STR03.executeQuery(QR03);
        if (R03.next()) {
          out.print("<tr><td>Workload : </td><td>"+R03.getString("WORKLOAD")+"</td></tr>");
          out.print("<tr><td>Start : </td><td>"+R03.getString("DATE_START")+"</td></tr>");
          out.print("<tr><td>End : </td><td>"+R03.getString("DATE_END")+"</td></tr>");
        }
        STR03.close();
        out.print("<tr><td><H1>Are you sure that you want to delete this recurring workload from this resource ??</H1></td><td>&nbsp;</td></tr>");
        out.print("<tr><td>&nbsp;</td><td><input type=\"submit\" name=\"Save\" value=\"Delete\">");
        out.print("<input type=button onClick=\"location.href='resourcecapacity.jsp?TODO=NONE&EMPLOYEEID="+EMPLOYEEID+"'\" value='Cancel'></td></tr>");
        out.print("</table>");
        out.print("</form>");
        Conn.close();
      }

    %>
  </body>
</html>
