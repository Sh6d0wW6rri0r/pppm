
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


  <%@ page import = "java.sql.*" %>
  <%@ page import = "java.util.*" %>
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
        String PROGRAMID = request.getParameter("PROGRAMID");
      	out.print("<center><table><tr><td><img border=0 src=\"icons/financials.png\"></td><td><strong><h1>Program financials</h1></strong></td></tr></table></center><hr>");
        out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\" >");
        out.print("<tr height=\"30\">");
        out.print("<td width=\"50%\" COLSPAN=3  background=\"images/fond_titre.jpg\"><center>Description</center></td>");
        out.print("<td width=\"25%\"  background=\"images/fond_titre.jpg\"><center>Capital</center></td>");
        out.print("<td width=\"25%\"  background=\"images/fond_titre.jpg\"><center>Expense</center></td>");
        out.print("</tr>");
        long totalbudgetcapital=0;
        long totalbudgetexpense=0;
        long totalexpensecapital=0;
        long totalexpenseexpense=0;
        Statement st30 = Conn.createStatement();
        String q30 = "SELECT SUM(AMOUNT) FROM PROJECT_BUDGET WHERE TYPE='C' AND PROJECTID IN (SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+PROGRAMID+"')";
        ResultSet r30 = st30.executeQuery(q30);
        if(r30.next()) {
          totalbudgetcapital=r30.getInt("SUM(AMOUNT)");
        }
        st30.close();
        st30 = Conn.createStatement();
        q30 = "SELECT SUM(AMOUNT) FROM PROJECT_BUDGET WHERE TYPE='E' AND PROJECTID IN (SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+PROGRAMID+"')";
        r30 = st30.executeQuery(q30);
        if(r30.next()) {
          totalbudgetexpense=r30.getInt("SUM(AMOUNT)");
        }
        st30.close();
        st30 = Conn.createStatement();
        q30 = "SELECT SUM(AMOUNT) FROM PROJECT_EXPENSE WHERE TYPE='C' AND PROJECTID IN (SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+PROGRAMID+"')";
        r30 = st30.executeQuery(q30);
        if(r30.next()) {
          totalexpensecapital=r30.getInt("SUM(AMOUNT)");
        }
        st30.close();
        st30 = Conn.createStatement();
        q30 = "SELECT SUM(AMOUNT) FROM PROJECT_EXPENSE WHERE TYPE='E' AND PROJECTID IN (SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+PROGRAMID+"')";
        r30 = st30.executeQuery(q30);
        if(r30.next()) {
          totalexpenseexpense=r30.getInt("SUM(AMOUNT)");
        }
        st30.close();
        out.print("<tr height=\"30\">");
        out.print("<td COLSPAN=3 bgcolor=\"#FFFFFF\">Remaining budget</td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+(totalbudgetcapital-totalexpensecapital)+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+(totalbudgetexpense-totalexpenseexpense)+"</center></td>");
        out.print("</tr>");
        out.print("<tr height=\"30\">");
        out.print("<td colspan=3 bgcolor=\"#FFFFFF\"><table><tr><td>Budget line(s)</td></tr></table></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+totalbudgetcapital+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+totalbudgetexpense+"</center></td>");
        out.print("</tr>");
        st30 = Conn.createStatement();
        q30 = "SELECT * FROM PROJECT_BUDGET WHERE PROJECTID IN (SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+PROGRAMID+"') ORDER BY PROJECTID";
        r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr height=\"30\">");
          out.print("<td width=\"10%\"><center>&nbsp;</center></A></td>");
          Statement st43 = Conn.createStatement();
          String q43 = "SELECT ID,NAME FROM PROJECT WHERE ID='"+r30.getString("PROJECTID")+"'";
          ResultSet r43 = st43.executeQuery(q43);
          if (r43.next()) {
            out.print("<td bgcolor=\"#FFFFFF\">"+r43.getString("NAME")+"</td>");
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
          }
          st43.close();
          out.print("<td width=\"30%\" bgcolor=\"#FFFFFF\"><table><tr><td><center>"+r30.getString("DESCRIPTION")+"</center></td></td></tr></table></td>");
          if (r30.getString("TYPE").equals("C")) {
            out.print("<td width=\"25%\" bgcolor=\"#FFFFFF\"><center>"+r30.getString("AMOUNT")+"</center></td>");
            out.print("<td width=\"25%\" bgcolor=\"#FFFFFF\"><center>-</center></td>");
          }
          if (r30.getString("TYPE").equals("E")) {
            out.print("<td width=\"25%\" bgcolor=\"#FFFFFF\"><center>-</center></td>");
            out.print("<td width=\"25%\" bgcolor=\"#FFFFFF\"><center>"+r30.getString("AMOUNT")+"</center></td>");
          }
          out.print("</tr>");
        }
        st30.close(); 
        out.print("<tr height=\"30\">");
        out.print("<td colspan=3  bgcolor=\"#FFFFFF\"><table><tr><td>Expense(s)</td></tr></table></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+totalexpensecapital+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\"><center>"+totalexpenseexpense+"</center></td>");
        out.print("</tr>");
        st30 = Conn.createStatement();
        q30 = "SELECT * FROM PROJECT_EXPENSE WHERE PROJECTID IN (SELECT PROJECTID FROM PRJPGM WHERE PROGRAMID='"+PROGRAMID+"') ORDER BY PROJECTID";
        r30 = st30.executeQuery(q30);
        while(r30.next()) {
          out.print("<tr height=\"30\">");
          out.print("<td width=\"10%\"><center>&nbsp;</center></A></td>");
          Statement st43 = Conn.createStatement();
          String q43 = "SELECT ID,NAME FROM PROJECT WHERE ID='"+r30.getString("PROJECTID")+"'";
          ResultSet r43 = st43.executeQuery(q43);
          if (r43.next()) {
            out.print("<td bgcolor=\"#FFFFFF\">"+r43.getString("NAME")+"</td>");
          } else {
            out.print("<td bgcolor=\"#FFFFFF\"><center>-</center></td>");
          }
          st43.close();
          out.print("<td width=\"30%\" bgcolor=\"#FFFFFF\"><table><tr><td><center>"+r30.getString("DESCRIPTION")+"</center></td></tr></table></td>");
          if (r30.getString("TYPE").equals("C")) {
            out.print("<td width=\"25%\" bgcolor=\"#FFFFFF\"><center>"+r30.getString("AMOUNT")+"</center></td>");
            out.print("<td width=\"25%\" bgcolor=\"#FFFFFF\"><center>-</center></td>");
          }
          if (r30.getString("TYPE").equals("E")) {
            out.print("<td width=\"25%\" bgcolor=\"#FFFFFF\"><center>-</center></td>");
            out.print("<td width=\"25%\" bgcolor=\"#FFFFFF\"><center>"+r30.getString("AMOUNT")+"</center></td>");
          }
          out.print("</tr>");
        }
        st30.close();
        out.print("</table>");
        out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
        Conn.close();
      }

    %>
  </body>
</html>
