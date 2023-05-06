
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
      String EMPLOYEEID = request.getParameter("EMPLOYEEID");
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
      String QR01 = "SELECT NAME,FORNAME FROM EMPLOYEE WHERE ID='"+EMPLOYEEID+"'";
      ResultSet R01 = STR01.executeQuery(QR01);
      if (R01.next()) {
        out.print(R01.getString("NAME")+" "+R01.getString("FORNAME"));
      }
      STR01.close();
      out.print("</h1></strong></center>");
      out.print("<center><strong><h2>During the month of ");
      out.print(""+MOIS[Integer.parseInt(MONTH)-1]+" "+YEAR);
      out.print("</h2></strong></center><hr>");
      out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\"  width=\"100%\">");
      out.print("<t>");
      out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>PROJECT</center></td>");
      out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>PROJECT SCORE</center></td>");
      out.print("<td width=\"40%\" background=\"images/fond_titre.jpg\"><center>ACTIVITY</center></td>");
      out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>WORKLOAD (hours)</center></td>");
      out.print("</tr>");
      int workload=0;
      Statement STR02 = Conn.createStatement();
      String QR02 = "SELECT WORKLOAD,RECURRINGID FROM EMPLOYEE_RECURRING_WORKLOAD WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND MONTH="+MONTH+" AND YEAR="+YEAR;
      ResultSet R02 = STR02.executeQuery(QR02);
      while (R02.next()) {
        out.print("<tr>");
        out.print("<td>RECURRING</td>");
        out.print("<td><center>---</center></td>");
        Statement STR03 = Conn.createStatement();
        String QR03 = "SELECT NAME FROM RECURRING WHERE ID='"+R02.getString("RECURRINGID")+"'";
        ResultSet R03 = STR03.executeQuery(QR03);
        if (R03.next()) {
          out.print("<td>"+R03.getString("NAME")+"</td>");
        } else {
          out.print("<td>---</td>");
        }
        STR03.close();
        out.print("<td><center>"+R02.getString("WORKLOAD")+"</center></td>");  
        workload=workload+R02.getInt("WORKLOAD");
        out.print("</tr>");
      }
      STR02.close();
      Statement STR04 = Conn.createStatement();
      String QR04 = "SELECT PROJECTID,ACTIVITYID,PERCENTAGE FROM RESOURCE_USER_ACTIVITY WHERE EMPLOYEEID='"+EMPLOYEEID+"' AND PROJECTID IN (SELECT ID FROM PROJECT WHERE STATUS<>'REQUEST') ";
      ResultSet R04 = STR04.executeQuery(QR04);
      while (R04.next()) {
        Statement STR05 = Conn.createStatement();
        String QR05 = "SELECT PROJECTID,ACTIVITYID,WORKLOAD FROM PROJECT_ACTIVITY_WORKLOAD WHERE PROJECTID='"+R04.getString("PROJECTID")+"' AND ACTIVITYID='"+R04.getString("ACTIVITYID")+"' AND MONTH="+MONTH+" AND YEAR="+YEAR;
        ResultSet R05 = STR05.executeQuery(QR05);
        int mwrkl = 0;
        while (R05.next()) {
          mwrkl=mwrkl+R05.getInt("WORKLOAD");
        }
        STR05.close();
        int tmpval=(mwrkl*R04.getInt("PERCENTAGE")/100);
        if (tmpval!=0) {
          out.print("<tr>");
          Statement STR06 = Conn.createStatement();
          String QR06 = "SELECT NAME,SCORE FROM PROJECT WHERE ID='"+R04.getString("PROJECTID")+"'";
          ResultSet R06 = STR06.executeQuery(QR06);
          if (R06.next()) {
            out.print("<td>"+R06.getString("NAME")+"</td>");
            out.print("<td><center>"+R06.getString("SCORE")+"</center></td>");
          } else {
            out.print("<td>---</td>");
            out.print("<td><center>---</center></td>");
          }
          STR06.close();
          Statement STR07 = Conn.createStatement();
          String QR07 = "SELECT NAME FROM PROJECT_ACTIVITY WHERE ID='"+R04.getString("ACTIVITYID")+"' AND PROJECTID='"+R04.getString("PROJECTID")+"'";
          ResultSet R07 = STR07.executeQuery(QR07);
          if (R07.next()) {
            out.print("<td>"+R07.getString("NAME")+"</td>");
          } else {
            out.print("<td>---</td>");
          }
          STR07.close();
          out.print("<td><center>"+tmpval+"</center></td>");
          out.print("</tr>");
        }
        workload=workload+tmpval;   
      }
  
    STR04.close();
      out.print("<tr>");
      out.print("<td COLSPAN=3 background=\"images/fond_titre.jpg\"><center>TOTAL</center></td>");
      out.print("<td><center>"+workload+"</center></td>");
      out.print("</tr>");
      out.print("</table>");
      out.print("<hr><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
      Conn.close();
    %>
  </body>
</html>
