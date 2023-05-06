
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
        String GROUPID = request.getParameter("GROUPID");      	
        PPPMTools pmt = PPPMTools();
        if (act.equals("PORTADD")) {
          String ID = request.getParameter("ID");
          Statement STU01 = Conn.createStatement();
          String QU01 = "INSERT INTO SCORING_GROUP_PORTFOLIO VALUES ('"+pmt.checkStr(GROUPID)+"','"+pmt.checkStr(ID)+"')";
          STU01.executeUpdate(QU01);
          STU01.close();
        }
        if (act.equals("PORTDELETE")) {
          String PORTFOLIOID = request.getParameter("PORTFOLIOID");
          Statement STU03 = Conn.createStatement();
          String QU03 = "DELETE FROM SCORING_GROUP_PORTFOLIO WHERE GROUPID='"+GROUPID+"' AND PORTFOLIOID='"+PORTFOLIOID+"'";
          STU03.executeUpdate(QU03);
          STU03.close();
        }
        out.print("<center><table><tr><td><img border=0 src=\"icons/attributes.png\"></td><td><strong><h1>Scoring questionnaire</h1></strong></td></tr></table></center><hr>");
        out.print("<Table><tr><td>You are here : Administration \\ <A HREF=\"adminscoring.jsp?TODO=NONE\">Manage scoring</A> \\ Scoring Portfolio</td><td><A HREF=\"adminscoringportfolio.jsp?TODO=NONE&GROUPID="+GROUPID+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        String scoring = "";
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT NAME FROM SCORING_GROUP where ID='"+GROUPID+"'";
        ResultSet R01 = STR01.executeQuery(QR01);
        if (R01.next()) {
          scoring = R01.getString("NAME");
        }
        STR01.close();
        out.print("<table><tr><td><h2><strong>Portfolios(s) on which the "+GROUPID+" scoring is applicable</strong></h2></center></td>");
        out.print("<td><A HREF=\"pickscoringportfolio.jsp?TODO=ADD&GROUPID="+GROUPID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td>");
        out.print("<td>&nbsp;</td>");
        out.print("</tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Id</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\"><center>Name</center></td>");
        out.print("</tr>");
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT ID,NAME FROM PORTFOLIO WHERE ID IN (SELECT PORTFOLIOID FROM SCORING_GROUP_PORTFOLIO WHERE GROUPID='"+GROUPID+"')";
        ResultSet R02 = STR02.executeQuery(QR02);
        while(R02.next()) {
          out.print("<tr>");
          out.print("<td bgcolor=#FFFFFF><center><table><tr><td>"+R02.getString("ID")+"</td><td><td><A HREF=\"adminaddscoringgroup.jsp?TODO=MOD&GROUPID="+R02.getString("ID")+"\"><img border=0 src=\"icons/modifysmall.png\"></A></td></tr></table></center></td>");
          out.print("<td bgcolor=#FFFFFF><center>"+R02.getString("NAME")+"</center></td>");
          out.print("<td><center><A HREF=\"admindeletescoringportfolio.jsp?TODO=DELETE&PORTFOLIOID="+R02.getString("ID")+"&GROUPID="+GROUPID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        STR02.close();
        out.print("</table>");
        Conn.close();
      } 

    %>
  </body>
</html>
