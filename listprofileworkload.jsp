
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
      String PORTFOLIO = request.getParameter("PORTFOLIO");
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
      out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>PROJECT</center></td>");
      out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>PROJECT SCORE</center></td>");
      out.print("<td width=\"40%\" background=\"images/fond_titre.jpg\"><center>ACTIVITY</center></td>");
      out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>WORKLOAD (hours)</center></td>");
      out.print("</tr>");
      Statement STR02 = Conn.createStatement();
      String QR02 = "SELECT PROJECTID,ACTIVITYID,PERCENTAGE FROM RESOURCE_PROFILE_ACTIVITY WHERE PROFILEID='"+PROFILEID+"' AND PROJECTID IN (SELECT ID FROM PROJECT WHERE STATUS<>'REQUEST') ";
      if (!PORTFOLIO.equals("***")) {
        QR02=QR02+"AND PROJECTID IN (SELECT PROJECTID FROM PRJPOR WHERE PORTFOLIOID='"+PORTFOLIO+"') ";
      }
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
        out.print("<tr>");
        Statement STR04 = Conn.createStatement();
        String QR04 = "SELECT NAME,SCORE FROM PROJECT WHERE ID='"+R02.getString("PROJECTID")+"'";
        ResultSet R04 = STR04.executeQuery(QR04);
        if (R04.next()) {
          out.print("<td>"+R04.getString("NAME")+"</td>");
          out.print("<td><center>"+R04.getString("SCORE")+"</center></td>");
        } else {
          out.print("<td>---</td>");
          out.print("<td>---</td>");
        }
        STR04.close();
        Statement STR05 = Conn.createStatement();
        String QR05 = "SELECT NAME FROM PROJECT_ACTIVITY WHERE ID='"+R02.getString("ACTIVITYID")+"' AND PROJECTID='"+R02.getString("PROJECTID")+"'";
        ResultSet R05 = STR05.executeQuery(QR05);
        if (R05.next()) {
          out.print("<td>"+R05.getString("NAME")+"</td>");
        } else {
          out.print("<td>---</td>");
        }
        STR05.close();
        int tmpval=(mwrkl*R02.getInt("PERCENTAGE")/100);
        out.print("<td><center>"+tmpval+"</center></td>");
        out.print("</tr>");
        workload=workload+tmpval;   
      }
      STR02.close();
      Statement STR06 = Conn.createStatement();
      String QR06 = "SELECT PROJECTID,ACTIVITYID,PERCENTAGE FROM RESOURCE_USER_ACTIVITY WHERE PROFILEID='"+PROFILEID+"' AND PROJECTID IN (SELECT ID FROM PROJECT WHERE STATUS<>'REQUEST') ";
      if (!PORTFOLIO.equals("***")) {
        QR06=QR06+"AND PROJECTID IN (SELECT PROJECTID FROM PRJPOR WHERE PORTFOLIOID='"+PORTFOLIO+"') ";
      }
      ResultSet R06 = STR06.executeQuery(QR06);
      while (R06.next()) {
        Statement STR07 = Conn.createStatement();
        String QR07 = "SELECT PROJECTID,ACTIVITYID,WORKLOAD FROM PROJECT_ACTIVITY_WORKLOAD WHERE PROJECTID='"+R06.getString("PROJECTID")+"' AND ACTIVITYID='"+R06.getString("ACTIVITYID")+"' AND MONTH="+MONTH+" AND YEAR="+YEAR;
        ResultSet R07 = STR07.executeQuery(QR07);
        int mwrkl = 0;
        if (R07.next()) {
          mwrkl=R07.getInt("WORKLOAD");
        }
        STR07.close();
        int tmpval=(mwrkl*R06.getInt("PERCENTAGE")/100);
        if (tmpval!=0) {
          out.print("<tr>");
          Statement STR08 = Conn.createStatement();
          String QR08 = "SELECT NAME,SCORE FROM PROJECT WHERE ID='"+R06.getString("PROJECTID")+"'";
          ResultSet R08 = STR08.executeQuery(QR08);
          if (R08.next()) {
            out.print("<td>"+R08.getString("NAME")+"</td>");
            out.print("<td><center>"+R08.getString("SCORE")+"</center></td>");
          } else {
            out.print("<td>---</td>");
            out.print("<td>---</td>");
          }
          STR08.close();
          Statement STR09 = Conn.createStatement();
          String QR09 = "SELECT NAME FROM PROJECT_ACTIVITY WHERE ID='"+R06.getString("ACTIVITYID")+"' AND PROJECTID='"+R06.getString("PROJECTID")+"'";
          ResultSet R09 = STR09.executeQuery(QR09);
          if (R09.next()) {
            out.print("<td>"+R09.getString("NAME")+"</td>");
          } else {
            out.print("<td>---</td>");
          }
          STR09.close();
          out.print("<td><center>"+tmpval+"</center></td>");
          out.print("</tr>");
        }
        workload=workload+tmpval;   
      }
      STR06.close();
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
