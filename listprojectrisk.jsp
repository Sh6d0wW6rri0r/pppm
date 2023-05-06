
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
      String PROJECTID = request.getParameter("PROJECTID");
      String LEVEL = request.getParameter("LEVEL");

      String risk_matrix[][] = new String[6][6];
      risk_matrix[1][5]="O";
      risk_matrix[1][4]="G";
      risk_matrix[1][3]="G";
      risk_matrix[1][2]="G";
      risk_matrix[1][1]="G";
      risk_matrix[2][5]="O";
      risk_matrix[2][4]="O";
      risk_matrix[2][3]="G";
      risk_matrix[2][2]="G";
      risk_matrix[2][1]="G";
      risk_matrix[3][5]="R";
      risk_matrix[3][4]="O";
      risk_matrix[3][3]="O";
      risk_matrix[3][2]="G";
      risk_matrix[3][1]="G";
      risk_matrix[4][5]="R";
      risk_matrix[4][4]="R";
      risk_matrix[4][3]="O";
      risk_matrix[4][2]="O";
      risk_matrix[4][1]="G";
      risk_matrix[5][5]="R";
      risk_matrix[5][4]="R";
      risk_matrix[5][3]="R";
      risk_matrix[5][2]="O";
      risk_matrix[5][1]="O";
      out.print("<center><strong><h1>List of "+LEVEL+" Risks for ");
      Statement STR01 = Conn.createStatement();
      String QR01 = "SELECT NAME FROM PROJECT WHERE ID='"+PROJECTID+"'";
      ResultSet R01 = STR01.executeQuery(QR01);
      if (R01.next()) {
        out.print(R01.getString("NAME"));
      }
      STR01.close();
      out.print("</h1></strong></center>");
      String level="G";
      if(LEVEL.equals("LOW")) {
        level="G";
      }
      if(LEVEL.equals("MEDIUM")) {
        level="O";
      }
      if(LEVEL.equals("HIGH")) {
        level="R";
      }
      out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\"  width=\"100%\">");
      out.print("<t>");
      out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>RISK</center></td>");
      out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>IMPACT</center></td>");
      out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>LIKELIHOOD</center></td>");
      out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>DATE DISCOVER</center></td>");
      out.print("<td width=\"20%\" background=\"images/fond_titre.jpg\"><center>DATE CLOSED</center></td>");
      out.print("</tr>");
      Statement STR02 = Conn.createStatement();
      String QR02 = "SELECT ID,NAME,DATE_DISCOVER,DATE_CLOSING,IMPACT,LIKELIHOOD,CLOSED FROM PROJECT_RISK WHERE PROJECTID='"+PROJECTID+"'";
      ResultSet R02 = STR02.executeQuery(QR02);
      while (R02.next()) {
        if (risk_matrix[R02.getInt("IMPACT")][R02.getInt("LIKELIHOOD")].equals(level)) {
          out.print("<tr>"); 
          out.print("<td><center>"+R02.getString("NAME")+"</center></td>");
          out.print("<td><center>"+R02.getString("IMPACT")+"</center></td>");
          out.print("<td><center>"+R02.getString("LIKELIHOOD")+"</center></td>");
          out.print("<td><center>"+R02.getString("DATE_DISCOVER")+"</center></td>");
          if (R02.getString("CLOSED").equals("Y")) {
            out.print("<td><center>"+R02.getString("DATE_CLOSING")+"</center></td>");
          } else {
            out.print("<td><center> --- </center></td>");
          }
          out.print("</tr>");
        }
      }
      STR02.close();
      out.print("</table>");
      out.print("<hr><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
      Conn.close();
    %>
  </body>
</html>
