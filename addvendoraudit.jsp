
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
        String VENDORID = request.getParameter("VENDORID");
        String AUDITID = request.getParameter("AUDITID");
      	if (act.equals("ADD")) {  
          out.print("<center><table><tr><td><img border=0 src=\"icons/audit.png\"></td><td><strong><h1>Add vendor audit</h1></strong></td></tr></table></center><hr>");
        } else {
          out.print("<center><table><tr><td><img border=0 src=\"icons/audit.png\"></td><td><strong><h1>Modify vendor audit</h1></strong></td></tr></table></center><hr>");
        }
        out.print("<hr>");
        Calendar rn= Calendar.getInstance();
        String DATEAUDIT = ""+rn.get(Calendar.YEAR)+"-"+(rn.get(Calendar.MONTH)+1)+"-"+rn.get(Calendar.DATE);
        String COMMENT = "";
        String RESULT ="";
        if (act.equals("ADD")) {
          out.print("<form name=\"formFILTER\" method=\"post\" action=\"audit.jsp?TODO=ADD&VENDORID="+VENDORID+"\" target=\"_top\">");
        } else {
          out.print("<form name=\"formFILTER\" method=\"post\" action=\"audit.jsp?TODO=MOD&VENDORID="+VENDORID+"&AUDITID="+AUDITID+"\" target=\"_top\">");
        }
        if (act.equals("MOD")) {
          Statement STR01= Conn.createStatement();
          String QR01 = "SELECT DATEAUDIT,COMMENT,RESULT FROM VENDOR_AUDIT WHERE ID='"+AUDITID+"' AND VENDORID='"+VENDORID+"'";
          ResultSet R01 = STR01.executeQuery(QR01);
          if (R01.next()) {
            DATEAUDIT=R01.getString("DATEAUDIT");
            COMMENT=R01.getString("COMMENT");
            RESULT=R01.getString("RESULT");
          }
          STR01.close();
        }
        out.print("<table>");
        out.print("<tr><td>Vendor : </td><td><select name=\"VENDORID\">");
        Statement STR02 = Conn.createStatement();
        String QR02 = "SELECT * FROM VENDOR";
        ResultSet R02 = STR02.executeQuery(QR02);
        while(R02.next()) {
          out.print("<option");
          if (VENDORID.equals(R02.getString("ID"))) {
            out.print(" selected ");
          }
          out.print(">"+R02.getString("ID")+" - "+R02.getString("NAME")+"</option>");
        }
        STR02.close();
        out.print("</select></td></tr>");
        out.print("<tr><td>Date of audit : </td><td><input name=\"DATEAUDIT\" type=\"text\" size=\"50\" value=\""+DATEAUDIT+"\" readonly=\"readonly\">");  
        out.print("<script language=\"JavaScript\"> new tcal ({'formname': 'formFILTER','controlname': 'DATEAUDIT'}); </script></td></tr>");
        out.print("<tr><td>Comment : </td><td><textarea name=\"COMMENT\" cols=\"60\" rows=\"5\" value=\"\">"+COMMENT+"</textarea></td></tr>");
        out.print("<tr><td>Result : </td><td><select name=\"RESULT\">");
        out.print("<option");
        if (RESULT.equals("PLANNED")) {
          out.print(" selected ");
        }
        out.print(">PLANNED</option>");
        out.print("<option");
        if (RESULT.equals("IN PROGRESS")) {
          out.print(" selected ");
        }
        out.print(">IN PROGRESS</option>");
        out.print("<option");
        if (RESULT.equals("POSTPONED")) {
          out.print(" selected ");
        }
        out.print(">POSTPONED</option>");
        out.print("<option");
        if (RESULT.equals("CANCELED")) {
          out.print(" selected ");
        }
        out.print(">CANCELED</option>");
        out.print("<option");
        if (RESULT.equals("OK TO USE")) {
          out.print(" selected ");
        }
        out.print(">OK TO USE</option>");
        out.print("<option");
        if (RESULT.equals("OK TO USE WITH CAUTION")) {
          out.print(" selected ");
        }
        out.print(">OK TO USE WITH CAUTION</option>");
        out.print("<option");
        if (RESULT.equals("NOT TO BE USED")) {
          out.print(" selected ");
        }
        out.print(">NOT TO BE USED</option>");
        out.print("</select></td></tr>");
        if (act.equals("ADD")) {
          out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/add.png\" type=image Value=submit></td>");
          out.print("<td><A HREF=\"audit.jsp?TODO=NONE\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        } else {  
          out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
          out.print("<td><A HREF=\"audit.jsp?TODO=NONE\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
        }
        out.print("</table>");
        out.print("</form>");
        Conn.close();     
      }

    %>
  </body>
</html>
