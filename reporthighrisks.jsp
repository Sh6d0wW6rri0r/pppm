
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

  
  <%@ page import = "java.io.*" %>
  <%@ page import = "java.util.*" %>
  <%@ page import = "java.sql.*" %>
  <%@ page import = "java.util.Date" %>
  <%@ page import = "java.util.Calendar" %>
  <%@ page import = "java.text.SimpleDateFormat" %>
  <%@ page import = "java.util.GregorianCalendar" %>
  <%@ page import = "java.text.DateFormat" %>
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
      	out.print("<center><table><tr><td><img border=0 src=\"icons/report.png\"></td><td><strong><h1>High risks</h1></strong></td></tr></table></center>");
        out.print("<hr>");
        out.print("<Table><tr><td>You are here : Report \\ <A HREF=\"reportpmogroup.jsp?TODO=NONE\" target=\"appliFrame\">PMO</A> \\ Projects with high risks</td><td><A HREF=\"reporthighrisks.jsp?TODO=NONE\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>PROJECT</center></td>");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>RISK</center></td>");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>DESCRIPTION</center></td>");
        out.print("<td width=\"15%\" background=\"images/fond_titre.jpg\"><center>DATE DISCOVER</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>IMPACT</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>LIKELIHOOD</center></td>");
        out.print("<td width=\"10%\" background=\"images/fond_titre.jpg\"><center>PRIORITY</center></td>");
        out.print("</tr>");
        Statement st32 = Conn.createStatement();  
        String q32 = "SELECT * FROM PROJECT_RISK WHERE CLOSED='N' AND ((IMPACT=3 AND LIKELIHOOD=5) OR (IMPACT=4 AND LIKELIHOOD>=4) OR (IMPACT=3 AND LIKELIHOOD>=3))";
        ResultSet r32 = st32.executeQuery(q32);
        while (r32.next()) {
          out.print("<tr>");
          Statement st231 = Conn.createStatement();
          String q231 = "SELECT NAME FROM PROJECT WHERE ID='"+r32.getString("PROJECTID")+"'";
          ResultSet r231 = st231.executeQuery(q231);
          if (r231.next()) {
            out.print("<td bgcolor=\"#EFEFEF\"><center>"+r231.getString("NAME")+"</center></A></td>"); 
          }
          st231.close();
          out.print("<td bgcolor=\"#EFEFEF\"><center>"+r32.getString("NAME")+"</center></A></td>"); 
          out.print("<td bgcolor=\"#EFEFEF\"><center>"+r32.getString("DESCRIPTION")+"</center></A></td>"); 
          out.print("<td bgcolor=\"#EFEFEF\"><center>"+r32.getString("DATE_DISCOVER")+"</center></A></td>"); 
          out.print("<td bgcolor=\"#EFEFEF\"><center>"+r32.getString("IMPACT")+"</center></A></td>"); 
          out.print("<td bgcolor=\"#EFEFEF\"><center>"+r32.getString("LIKELIHOOD")+"</center></A></td>"); 
          int impact = r32.getInt("IMPACT");
          int likelihood = r32.getInt("LIKELIHOOD");
          if (risk_matrix[impact][likelihood].equals("G")) {
            out.print("<td bgcolor=\"#00FF00\"><center>Low</center></td>");
          }
          if (risk_matrix[impact][likelihood].equals("O")) {
            out.print("<td bgcolor=\"#FF7F3F\"><center>Medium</center></td>");
          }
          if (risk_matrix[impact][likelihood].equals("R")) {
            out.print("<td bgcolor=\"#FF0000\"><center>High</center></td>");
          }
          out.print("</tr>");
        }
        st32.close();
        Conn.close();
      }
      out.print("</table>");

    %>
  </body>
</html>
