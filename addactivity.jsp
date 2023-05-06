
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

  <body>
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
        String PROJECTID = request.getParameter("PROJECTID");
        String ID = request.getParameter("ID");
        String FATHER = request.getParameter("FATHER");
        String NAMEONLY = request.getParameter("NAMEONLY");        out.print("<hr>");
        String NAME = "";
        if (NAMEONLY==null) {
          NAMEONLY="FALSE";
        }
        Calendar rn= Calendar.getInstance();
        String DATE_START = ""+rn.get(Calendar.YEAR)+"-"+(rn.get(Calendar.MONTH)+1)+"-"+rn.get(Calendar.DATE);
        String DATE_END = ""+rn.get(Calendar.YEAR)+"-"+(rn.get(Calendar.MONTH)+1)+"-"+rn.get(Calendar.DATE);
        String WORKLOAD = "";
        String DURATION = "";
        int ORD=0; 
        if (act.equals("ADD")) {
          out.print("<form name=\"formFILTER\" method=\"post\" action=\"projectplanning.jsp?TODO=ACTADD&PROJECTID="+PROJECTID+"&FATHER="+FATHER+"&NAMEONLY=FALSE\" target=\"_top\">");
        } else {
          out.print("<form name=\"formFILTER\" method=\"post\" action=\"projectplanning.jsp?TODO=ACTMOD&PROJECTID="+PROJECTID+"&ID="+ID+"&NAMEONLY="+NAMEONLY+"\" target=\"_top\">");
        }
        if (act.equals("MOD")) {
          Statement STR01 = Conn.createStatement();
          String QR01 = "SELECT ID,NAME,ORD,DATE_START,DATE_END,WORKLOAD FROM PROJECT_ACTIVITY WHERE ID='"+ID+"' AND PROJECTID='"+PROJECTID+"'";
          ResultSet R01 = STR01.executeQuery(QR01);
          if (R01.next()) {
            NAME=R01.getString("NAME");
            ORD=R01.getInt("ORD");
            DATE_START=R01.getString("DATE_START");
            DATE_END=R01.getString("DATE_END");
            WORKLOAD=R01.getString("WORKLOAD");
          }
          STR01.close();
        }
        out.print("<table>");
        if (act.equals("ADD")) {
          out.print("<tr><td><input type=\"radio\" name=\"CREATETYPE\" value=\"SCRATCH\" checked> Create the activity from scratch</td></tr>");
        }
        out.print("<tr><td>Name : </td><td><input name=\"NAME\" type=\"text\" size=\"50\" value=\""+NAME+"\"></td></tr>");
        if (NAMEONLY.equals("FALSE")) {
          out.print("<tr><td>Date start : </td><td><input name=\"DATE_START\" type=\"text\" size=\"50\" value=\""+DATE_START+"\" readonly=\"readonly\">");
          out.print("<script language=\"JavaScript\"> new tcal ({'formname': 'formFILTER','controlname': 'DATE_START'}); </script>");
          out.print("</td></tr>");
          out.print("<tr><td>Date end : </td><td><input name=\"DATE_END\" type=\"text\" size=\"50\" value=\""+DATE_END+"\" readonly=\"readonly\">");  
          out.print("<script language=\"JavaScript\"> new tcal ({'formname': 'formFILTER','controlname': 'DATE_END'}); </script>");
          out.print("</td></tr>");
          out.print("<tr><td>Workload (hours): </td><td><input name=\"WORKLOAD\" type=\"text\" size=\"50\" value=\""+WORKLOAD+"\"></td></tr>");
          if (act.equals("ADD")) {
            out.print("<tr><td colspan=2><hr></td></tr>");
            out.print("<tr><td><input type=\"radio\" name=\"CREATETYPE\" value=\"TEMPLATE\"> Create the activity from template</td></tr>");
            out.print("<tr><td>Activity template : </td><td><select name=\"TEMPLATEACTIVITY\">");
            Statement STR02 = Conn.createStatement();
            String QR02 = "SELECT ORD,NAME FROM PHASE_TEMPLATE_ACTIVITY WHERE TEMPLATE IN (SELECT TEMPLATE FROM PROJECT WHERE ID='"+PROJECTID+"')";
            ResultSet R02 = STR02.executeQuery(QR02);
            while(R02.next()) {
              out.print("<option");
              out.print(">"+R02.getString("ORD")+"-"+R02.getString("NAME")+"</option>");
            }
            STR02.close();
            out.print("</select></td></tr>");
            out.print("<tr><td>Date start : </td><td><input name=\"DATE_START_TEMPLATE\" type=\"text\" size=\"50\" value=\""+DATE_START+"\" readonly=\"readonly\">");
            out.print("<script language=\"JavaScript\"> new tcal ({'formname': 'formFILTER','controlname': 'DATE_START_TEMPLATE'}); </script>");
            out.print("</td></tr>");
            out.print("<tr><td>Date end : </td><td><input name=\"DATE_END_TEMPLATE\" type=\"text\" size=\"50\" value=\""+DATE_END+"\" readonly=\"readonly\">");  
            out.print("<script language=\"JavaScript\"> new tcal ({'formname': 'formFILTER','controlname': 'DATE_END_TEMPLATE'}); </script>");
            out.print("</td></tr>");
          }
          out.print("</table>");
        }
        if (act.equals("ADD")) {
          out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/add.png\" type=image Value=submit></td>");
          out.print("<td><A HREF=\"projectplanning.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        } else {  
          out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
          out.print("<td><A HREF=\"projectplanning.jsp?TODO=NONE&PROJECTID="+PROJECTID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        }
        out.print("</table>");
        out.print("</form>");
        Conn.close();
      }
    %>
  </body>
</html>
