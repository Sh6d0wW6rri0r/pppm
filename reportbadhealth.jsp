
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
      	out.print("<center><table><tr><td><img border=0 src=\"icons/report.png\"></td><td><strong><h1>Project with bad health check</h1></strong></td></tr></table></center>");
        out.print("<hr>");
        out.print("<Table><tr><td>You are here : Report \\ <A HREF=\"reportpmogroup.jsp?TODO=NONE\" target=\"appliFrame\">PMO</A> \\ Projects with bad health check</td><td><A HREF=\"reportbadhealth.jsp?TODO=NONE\"><img border=0 src=\"icons/reload.png\"></A></td></tr></table>");
        out.print("<hr>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
        out.print("<tr height=\"30\">");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Project</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Date</center></td>");
        out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>Phase</center></td>");
        Statement st330 = Conn.createStatement();
        int nbquestion=0;
        String q330 = "SELECT * FROM HEALTH_QUESTION ORDER BY ORD";
        ResultSet r330 = st330.executeQuery(q330);
        while(r330.next()) {
          out.print("<td background=\"images/fond_titre.jpg\"><center>"+r330.getString("NAME")+"</center></td>");
          nbquestion++;
        }
        st330.close();
        out.print("<td><center>&nbsp;</center></td>");
        out.print("</tr>");
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT DISTINCT PROJECTID FROM PROJECT_HEALTH WHERE RESULT>2";
        ResultSet r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr>");
          Statement st301 = Conn.createStatement();
          String q301 = "SELECT NAME FROM PROJECT WHERE ID='"+r30.getString("PROJECTID")+"'";
          ResultSet r301 = st301.executeQuery(q301);
          if (r301.next()) {
            out.print("<td bgcolor=\"#FFFFFF\"><center>"+r301.getString("NAME")+"</center></td>");
          }
          st301.close();
          st301 = Conn.createStatement();
          q301 = "SELECT DISTINCT DATE_HEALTH,PHASE FROM PROJECT_HEALTH WHERE PROJECTID='"+r30.getString("PROJECTID")+"' AND RESULT>2 ORDER BY DATE_HEALTH DESC";
          r301 = st301.executeQuery(q301);
          String DATE_HEALTH="";
          String PHASE="";
          if (r301.next()) {
            DATE_HEALTH= r301.getString("DATE_HEALTH");
            PHASE= r301.getString("PHASE");
          }
          st301.close();
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+DATE_HEALTH+"</center></td>");
          out.print("<td bgcolor=\"#FFFFFF\"><center>"+PHASE+"</center></td>");
          st301 = Conn.createStatement();
          q301 = "SELECT * FROM HEALTH_QUESTION ORDER BY ORD";
          r301 = st301.executeQuery(q301);
          int nbq = 0;
          while(r301.next()) {
            Statement st302 = Conn.createStatement();
            String q302 = "SELECT * FROM PROJECT_HEALTH WHERE PROJECTID='"+r30.getString("PROJECTID")+"' AND HEALTH_QUESTIONID='"+r301.getString("ID")+"' AND DATE_HEALTH='"+DATE_HEALTH+"'";
            ResultSet r302 = st302.executeQuery(q302);
            if (r302.next()) {
              if (r302.getInt("RESULT")>2) {
                out.print("<td bgcolor=\"#FF7F3F\">");
              } else {
                out.print("<td bgcolor=\"#FFFFFF\">");
              }
              out.print("<center>"+r302.getString("RESULT")+"</center></td>");
            }
            st302.close();
            nbq++;
          }
          st301.close();
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        Conn.close();
      }

    %>
  </body>
</html>
