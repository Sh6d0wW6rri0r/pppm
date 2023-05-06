
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
  <%@ page import = "java.util.Date" %>
  <%@ page import = "java.util.Calendar" %>
  <%@ page import = "java.text.SimpleDateFormat" %>
  <%@ page import = "java.util.GregorianCalendar" %>
  <%@ page import = "java.text.DateFormat" %>
  <%@ page import = "javax.sql.*" %>
  <%@ page import = "javax.naming.*" %>
  <%@ page import = "javax.servlet.*" %>
  <%@ page import = "javax.servlet.http.*" %>
  <%@ page import = "fr.pppm.*" %>

  <body>
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
        String NAME = request.getParameter("NAME");
      	PPPMTools pt = new PPPMTools();

        out.print("<center><strong><h1>Custom Reports</h1></strong></center><hr>");
        out.print("<Table><tr><td>You are here : Reporting \\ Manage custom reports \\ Run Report</td><td><A HREF=\"runreport.jsp?TODO=NONE&NAME="+NAME+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table><tr><td><h2><strong>Report : "+NAME+"</strong></h2></center></td>");
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        String TABLE_NAME="";
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT TABLE_NAME FROM CUSTOM_REPORT WHERE REPORT_NAME='"+NAME+"'";
        ResultSet R02 = STR02.executeQuery(QR02);
        if (R02.next()) {
          Statement STR02b = Conn.createStatement();
          String QR02b = "SELECT TABLE_DBNAME FROM REPORT_TABLES WHERE TABLE_NAME='"+R02.getString("TABLE_NAME")+"'";
          ResultSet R02b = STR02b.executeQuery(QR02b);
          if (R02b.next()) {
            TABLE_NAME=R02b.getString("TABLE_DBNAME");
          }
          STR02b.close();
        }
        STR02.close();
        String QR03="SELECT ";
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT FIELD_NAME FROM CUSTOM_REPORT_FIELDS WHERE REPORT_NAME='"+NAME+"'";
        ResultSet R01 = STR01.executeQuery(QR01);
        while(R01.next()) {
          out.print("<td background=\"images/fond_titre.jpg\"><center>"+R01.getString("FIELD_NAME")+"</center></td>");
          Statement STR01b = Conn.createStatement();
          String QR01b = "SELECT FIELD_DBNAME FROM REPORT_TABLES_FIELDS WHERE TABLE_DBNAME='"+TABLE_NAME+"' AND FIELD_NAME='"+R01.getString("FIELD_NAME")+"'";
          ResultSet R01b = STR01b.executeQuery(QR01b);
          if (R01b.next()) {
            if (QR03.equals("SELECT ")) {
              QR03= QR03 + R01b.getString("FIELD_DBNAME");
            } else {
              QR03 = QR03 + "," + R01b.getString("FIELD_DBNAME");
            }
          }
          STR01b.close();
        }
        STR01.close(); 
        QR03=QR03+" FROM "+TABLE_NAME;
        out.print("</tr>");
        Statement STR03 = Conn.createStatement();
        ResultSet R03 = STR03.executeQuery(QR03);
        while (R03.next()) {
          out.print("<tr>");
          Statement STR03b = Conn.createStatement();
          String QR03b = "SELECT FIELD_NAME FROM CUSTOM_REPORT_FIELDS WHERE REPORT_NAME='"+NAME+"'";
          ResultSet R03b = STR03b.executeQuery(QR03b);
          while(R03b.next()) {
            Statement STR03t = Conn.createStatement();
            String QR03t = "SELECT FIELD_DBNAME FROM REPORT_TABLES_FIELDS WHERE TABLE_DBNAME='"+TABLE_NAME+"' AND FIELD_NAME='"+R03b.getString("FIELD_NAME")+"'";
            ResultSet R03t = STR03t.executeQuery(QR03t);
            while(R03t.next()) {
              out.print("<td bgcolor=#FFFFFF><center>"+R03.getString(R03t.getString("FIELD_DBNAME"))+"</center></td>");
            }
             STR03t.close();
          }
          STR03b.close();
          out.print("</tr>");
        }
        STR03.close();
        out.print("</table>");
        Conn.close();
      } 

    %>
  </body>
</html>
