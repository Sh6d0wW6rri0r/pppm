
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
        String PRODUCTID = request.getParameter("PRODUCTID");
        String ID = request.getParameter("ID");
      	out.print("<hr>");
        out.print("<form name=\"formFILTER\" method=\"post\" action=\"productplanning.jsp?TODO=SPLIT&PRODUCTID="+PRODUCTID+"&ID="+ID+"\" target=\"appliFrame\">");
        out.print("<table>");
        String mois[] = new String[13];
        mois[1]="January";
        mois[2]="February";
        mois[3]="March";
        mois[4]="April";
        mois[5]="May";
        mois[6]="June";
        mois[7]="July";
        mois[8]="August";
        mois[9]="September";
        mois[10]="October";
        mois[11]="November";
        mois[12]="December";
        Statement st10 = Conn.createStatement();
        String q10 = "SELECT YEAR,MONTH,DAY,WORKLOAD FROM PRODUCT_ACTIVITY_WORKLOAD WHERE ACTIVITYID='"+ID+"' AND PRODUCTID='"+PRODUCTID+"' ORDER BY YEAR,MONTH,DAY";
        ResultSet r10 = st10.executeQuery(q10);
        int total =0;
        while (r10.next()) {
          out.print("<tr><td>Workload for "+r10.getInt("YEAR")+" "+mois[r10.getInt("MONTH")]+" "+r10.getInt("DAY")+" : </td><td><input name=\""+r10.getInt("YEAR")+r10.getInt("MONTH")+""+r10.getInt("DAY")+"\" type=\"text\" size=\"50\" value=\""+r10.getInt("WORKLOAD")+"\"></td></tr>");
          total=total + r10.getInt("WORKLOAD");
        }
        out.print("<tr><td>Total workload : </td><td>"+total+"</td></tr>");
        out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/split.png\" type=image Value=submit></td>");
        out.print("<td><A HREF=\"productplanning.jsp?TODO=NONE&PRODUCTID="+PRODUCTID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        out.print("</table>");
        out.print("</form>");
        Conn.close();
      }

    %>
  </body>
</html>
