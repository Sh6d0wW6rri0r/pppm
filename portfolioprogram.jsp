
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
        String PORTFOLIOID = request.getParameter("PORTFOLIOID");
      	Portfolio pf = new Portfolio(Conn);
        if (act.equals("ADD")) {
          String PROGRAMID = request.getParameter("PROGRAMID");
          pf.addProgramPortfolio(PROGRAMID,PORTFOLIOID);
        }
        if (act.equals("DELETE")) {
          String PROGRAMID = request.getParameter("PROGRAMID");
          pf.deleteProgramPortfolio(PROGRAMID,PORTFOLIOID);
        }
        out.print("<center><strong><h1>Portfolio project configuration</h1></strong></center><hr>");
        out.print("<table><tr><td>You are here : Portfolio Management \\ <A HREF=\"portconfig.jsp?TODO=NONE\">Portfolio configuration</A> \\ Portfolio program configuration</td><td><A HREF=\"portfolioprogram.jsp?TODO=NONE&PORTFOLIOID="+PORTFOLIOID+"\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table><tr><td><h2><strong>Program(s) in portfolio</strong></h2></center></td><td><A HREF=\"pickportfolioprogram.jsp?TODO=ADD&PORTFOLIOID="+PORTFOLIOID+"\"><img border=0 src=\"icons/addsmall.png\"></A></td></tr></table>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"40%\"><center>Name</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"50%\"><center>Description</center></td>");
        out.print("<td width=\"10%\"><center>&nbsp;</td>");
        out.print("</tr>");
        Statement STR01 = Conn.createStatement();
        String QR01 = "SELECT * FROM PGMPOR WHERE PORTFOLIOID='"+PORTFOLIOID+"'";
        ResultSet R01 = STR01.executeQuery(QR01);
        boolean paire=false;
        while(R01.next()) {
          out.print("<tr>");    
          Statement STR02 = Conn.createStatement();
          String QR02 = "SELECT * FROM PROGRAM WHERE ID='"+R01.getString("PROGRAMID")+"'";
          ResultSet R02 = STR02.executeQuery(QR02);
          if(R02.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+R02.getString("NAME")+"</center></td>");
            out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp;"+R02.getString("DESCRIPTION")+"</center></td>");
          } 
          STR02.close();  
          out.print("<td><center><A HREF=\"deleteportfolioprogram.jsp?TODO=DELETE&PROGRAMID="+R01.getString("PROGRAMID")+"&PORTFOLIOID="+PORTFOLIOID+"\"><img border=0 src=\"icons/deletesmall.png\"></center></A></td>");
          out.print("</tr>");
        }
        STR01.close();
        out.print("</table>");
        Conn.close();
      } 

    %>
  </body>
</html>
