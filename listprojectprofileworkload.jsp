
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Workload detail for Profile</title>
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
      String POOLNAME=(String)session.getAttribute("POOLNAME");

      // database connection
      Context initCtx = new InitialContext();
      DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
      Connection Conn = ds.getConnection();

      // JSP parameters
      String act = request.getParameter("TODO");
      String PROFILEID = request.getParameter("PROFILEID");
      String PROJECTID = request.getParameter("PROJECTID");
      String YEAR = request.getParameter("YEAR");
      String MONTH = request.getParameter("MONTH");

      String MOIS[] = new String[12];
      MOIS[0]="January";
      MOIS[1]="February";
      MOIS[2]="March";
      MOIS[3]="April";
      MOIS[4]="May";
      MOIS[5]="June";
      MOIS[6]="July";
      MOIS[7]="August";
      MOIS[8]="September";
      MOIS[9]="October";
      MOIS[10]="November";
      MOIS[11]="December";
      out.print("<center><strong><h1>List of task for ");
      Statement STR01 = Conn.createStatement();
      String QR01 = "SELECT NAME FROM PROFILE WHERE ID='"+PROFILEID+"'";
      ResultSet R01 = STR01.executeQuery(QR01);
      if (R01.next()) {
        out.print(R01.getString("NAME"));
      }
      STR01.close();
      out.print("</h1></strong></center>");
      out.print("<center><strong><h2>During the month of ");
      out.print(""+MOIS[Integer.parseInt(MONTH)-1]+" "+YEAR);
      out.print("</h2></strong></center><hr>");
      out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\"  width=\"100%\">");
      out.print("<t>");
      out.print("<td width=\"70%\" background=\"images/fond_titre.jpg\"><center>ACTIVITY</center></td>");
      out.print("<td width=\"30%\" background=\"images/fond_titre.jpg\"><center>WORKLOAD (hours)</center></td>");
      out.print("</tr>");
      Statement STR02 = Conn.createStatement();
      String QR02 = "SELECT PROJECTID,ACTIVITYID,PERCENTAGE FROM RESOURCE_PROFILE_ACTIVITY WHERE PROFILEID='"+PROFILEID+"' AND PROJECTID='"+PROJECTID+"'";
      ResultSet R02 = STR02.executeQuery(QR02);
      int workload=0;
      while (R02.next()) {
        Statement STR03 = Conn.createStatement();
        String QR03 = "SELECT PROJECTID,ACTIVITYID,WORKLOAD FROM PROJECT_ACTIVITY_WORKLOAD WHERE PROJECTID='"+R02.getString("PROJECTID")+"' AND ACTIVITYID='"+R02.getString("ACTIVITYID")+"' AND MONTH="+MONTH+" AND YEAR="+YEAR;
        ResultSet R03 = STR03.executeQuery(QR03);
        int mwrkl = 0;
        if (R03.next()) {
          mwrkl=R03.getInt("WORKLOAD");
        }
        STR03.close();
        int tmpval=(mwrkl*R02.getInt("PERCENTAGE")/100);
        if (tmpval!=0) {
          out.print("<tr>");
          Statement STR04 = Conn.createStatement();
          String QR04 = "SELECT NAME FROM PROJECT_ACTIVITY WHERE ID='"+R02.getString("ACTIVITYID")+"' AND PROJECTID='"+R02.getString("PROJECTID")+"'";
          ResultSet R04 = STR04.executeQuery(QR04);
          if (R04.next()) {
            out.print("<td>"+R04.getString("NAME")+"</td>");
          } else {
            out.print("<td>---</td>");
          }
          STR04.close();
          out.print("<td><center>"+tmpval+"</center></td>");
          out.print("</tr>");
        }
        workload=workload+tmpval;   
      }
      STR02.close();
      out.print("<tr>");
      out.print("<td background=\"images/fond_titre.jpg\"><center>TOTAL</center></td>");
      out.print("<td><center>"+workload+"</center></td>");
      out.print("</tr>");
      out.print("</table>");
      out.print("<hr><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
      Conn.close();
    %>
  </body>
</html>
