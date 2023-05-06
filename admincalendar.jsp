
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
  <head>
    <title>Untitled Document</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <style type="text/css"> 
      body { color: black; font-family: arial; font-size: 11px}
      h1 { color: black; font-family: arial; font-size: 16px}
    </style> 
    <script language="JavaScript" src="javascript/tigra_hints.js"></script>
    <style>
      .hintsClass {
 	font-family: tahoma, verdana, arial;
	font-size: 12px;
	background-color: #f0f0f0;
	color: #000000;
	border: 1px solid #808080;
	padding: 5px;
      }
      .hintSource {
	color: green;
	text-decoration: underline;
	cursor: pointer;
      }
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
        String SITEID = request.getParameter("SITEID");
      
        String JOUR[]= new String[7];
        JOUR[0]="SUNDAY";
        JOUR[1]="MONDAY";
        JOUR[2]="TUESDAY";
        JOUR[3]="WEDNESDAY";
        JOUR[4]="THURSDAY";
        JOUR[5]="FRIDAY";
        JOUR[6]="SATURDAY";      	
        if (act.equals("WEEKADD")) {
          String DAYOFF = request.getParameter("DAYOFF");
          Statement STU01 = Conn.createStatement();
          String QU01 = "INSERT INTO WEEK_DAY_OFF VALUES ('"+SITEID+"',"+DAYOFF+")";
          STU01.executeUpdate(QU01);
          STU01.close();
        }
        if (act.equals("WEEKDELETE")) {
          String DAYOFF = request.getParameter("DAYOFF");
          Statement STU02 = Conn.createStatement();
          String QU02 = "DELETE FROM WEEK_DAY_OFF WHERE SITEID='"+SITEID+"' AND DAYOFF="+DAYOFF;
          STU02.executeUpdate(QU02);
          STU02.close();
        }
        if (act.equals("OTHERADD")) {
          String DAYOFF = request.getParameter("DAYOFF");
          Statement STU03 = Conn.createStatement();
          String QU03 = "INSERT INTO OTHER_DAY_OFF VALUES ('"+SITEID+"','"+DAYOFF+"')";
          STU03.executeUpdate(QU03);
          STU03.close();
        }
        if (act.equals("OTHERDELETE")) {
          String DAYOFF = request.getParameter("DAYOFF");
          Statement STU04 = Conn.createStatement();
          String QU04 = "DELETE FROM OTHER_DAY_OFF WHERE SITEID='"+SITEID+"' AND DAYOFF='"+DAYOFF+"'";
          STU04.executeUpdate(QU04);
          STU04.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/calendar.png\"></td><td><strong><h1>Organizational Unit calendar</h1></strong></td></tr></table></center><hr>");
        out.print("<Table><tr><td>You are here : Administration \\ Manage organisational unit calendar</td><td><A HREF=\"admincalendar.jsp?TODO=NONE&SITEID="+SITEID+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table><tr><td><h2><strong>Weekly day-off</strong></h2></center></td>");
        out.print("<td><A HREF=\"adminaddweekdayoff.jsp?TODO=ADD&SITEID="+SITEID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        out.print("<td>&nbsp;</td>");
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Day</center></td>");
        out.print("<td>&nbsp;</td>");
        out.print("</tr>");
        Statement STR01 = Conn.createStatement();
        String STR01 = "SELECT DAYOFF FROM WEEK_DAY_OFF WHERE SITEID='"+SITEID+"'";
        ResultSet R01 = STR01.executeQuery(QR01);
        while(R01.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=#FFFFFF><center>"+JOUR[R01.getInt("DAYOFF")]+"</center></td>");
          out.print("<td><center><A HREF=\"admindeleteweekdayoff.jsp?TODO=DELETE&SITEID="+SITEID+"&DAYOFF="+R01.getString("DAYOFF")+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        STR01.close();
        out.print("</table>");
        out.print("<table><tr><td><h2><strong>Other(s) day-off</strong></h2></center></td>");
        out.print("<td><A HREF=\"adminaddotherdayoff.jsp?TODO=ADD&SITEID="+SITEID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Day</center></td>");
        out.print("<td>&nbsp;</td>");
        out.print("</tr>");
        Statement STR02 = Conn.createStatement();
        QR02 = "SELECT DAYOFF FROM OTHER_DAY_OFF WHERE SITEID='"+SITEID+"'";
        R02 = STR02.executeQuery(QR02);
        while(R02.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=#FFFFFF><center>"+R02.getString("DAYOFF")+"</center></td>");
          out.print("<td><center><A HREF=\"admindeleteotherdayoff.jsp?TODO=DELETE&SITEID="+SITEID+"&DAYOFF="+R02.getString("DAYOFF")+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        STR02.close();
        out.print("</table>");
        Conn.close();
      } 

    %>
  </body>
</html>
