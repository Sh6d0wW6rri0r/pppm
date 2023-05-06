
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Untitled Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css"> 
      body { color: black; font-family: arial; font-size: 11px}
      h1 { color: black; font-family: arial; font-size: 16px}
      h2 { color: black; font-family: arial; font-size: 13px}
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
  <%@ page import = "java.util.Calendar" %>
  <%@ page import = "java.text.SimpleDateFormat" %>
  <%@ page import = "java.util.GregorianCalendar" %>
  <%@ page import = "java.text.DateFormat" %>
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>
  <%@ page import = "fr.pppm.*" %>

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
        String PROGRAMID = request.getParameter("PROGRAMID");
      	out.print("<center><table><tr><td><img border=0 src=\"icons/resources.png\"></td><td><strong><h1>Project resources</h1></strong></td></tr></table></center><hr>");
        out.print("<table><tr><td><h2><strong>Program resource(s)</strong></h2></center></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr BGCOLOR=\"#9A9A9A\" height=\"30\">");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>Project</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>Forname</center></td>");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>Activity</center></td>");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>Workload</center></td>");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>Approved</center></td>");
        out.print("</tr>");
        Statement st29 = Conn.createStatement();
        String q29 = "SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+PROGRAMID+"'";
        ResultSet r29 = st29.executeQuery(q29);
        while(r29.next()) {
            Statement st30 = Conn.createStatement();
            String q30 = "SELECT EMPLOYEEID,APPROVED,ACTIVITYID,PERCENTAGE FROM RESOURCE_USER_ACTIVITY WHERE PROJECTID='"+r29.getString("PROJECTID")+"' ORDER BY EMPLOYEEID,APPROVED";
            ResultSet r30 = st30.executeQuery(q30);
            while(r30.next()) {
              out.print("<tr>");
              Statement st31b = Conn.createStatement();
              String q31b = "SELECT NAME FROM PROJECT WHERE ID='"+r29.getString("PROJECTID")+"'";
              ResultSet r31b = st31b.executeQuery(q31b);
              if(r31b.next()) {
                out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31b.getString("NAME")+"</center></A></td>");
              } else {
                out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp</center></A></td>");
              }
              st31b.close();
              Statement st31 = Conn.createStatement();
              String q31 = "SELECT NAME,FORNAME FROM EMPLOYEE WHERE ID='"+r30.getString("EMPLOYEEID")+"'";
              ResultSet r31 = st31.executeQuery(q31);
              if(r31.next()) {
                out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31.getString("NAME")+"</center></A></td>");
                out.print("<td bgcolor=\"#FFFFFF\"><center>"+r31.getString("FORNAME")+"</center></td>");
              } else {
                out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp</center></A></td>");
                out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp</center></td>");
              }
              st31.close();
              Statement st32 = Conn.createStatement();
              String q32 = "SELECT NAME,WORKLOAD FROM PROJECT_ACTIVITY WHERE ID='"+r30.getString("ACTIVITYID")+"' AND PROJECTID='"+r29.getString("PROJECTID")+"'";
              ResultSet r32 = st32.executeQuery(q32);
              if(r32.next()) {
                out.print("<td bgcolor=\"#FFFFFF\"><center>"+r32.getString("NAME")+"</center></A></td>");
                out.print("<td bgcolor=\"#FFFFFF\"><center>"+r32.getInt("WORKLOAD")*r30.getInt("PERCENTAGE")/100+"</center></td>");
              } else {
                out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp</center></A></td>");
                out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp</center></td>");
              }
              st32.close();
              out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("APPROVED")+"</center></td>"); 
             out.print("</tr>");
            }
            st30.close();
        }
        st29.close();
        out.print("</table>");
        out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
        Conn.close();
      }

    %>
  </body>
</html>
