
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
<%@ page import="fr.pppm.*" %>

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
  	  	boolean isthereaction=false;
  	    PPPMTools pt = new PPPMTools();
  	  	
      	if (act.equals("ADDCLOSE")) {
          Statement sti2 = Conn.createStatement();
          String i2 = "INSERT INTO VENDOR VALUES('"+pt.checkStr(request.getParameter("ID"))+"','"+pt.checkStr(request.getParameter("NAME"))+"','"+pt.checkStr(request.getParameter("ADDRESS"))+"')";
          sti2.executeUpdate(i2);
          sti2.close();      		
      	  out.print("<script language=\"JavaScript\">");
      	  out.print("window.close();"); 
            out.print("</script");  	
            isthereaction=true;
      	}
      	if (act.equals("MODCLOSE")) {

          Statement sti2 = Conn.createStatement();
          String i2 = "UPDATE VENDOR SET NAME='"+pt.checkStr(request.getParameter("NAME"))+"',ADDRESS='"+pt.checkStr(request.getParameter("ADDRESS"))+"' WHERE ID='"+VENDORID+"'";
          sti2.executeUpdate(i2);
          sti2.close();
      		out.print("<script language=\"JavaScript\">");
      	  out.print("window.close();"); 
            out.print("</script");  	
            isthereaction=true;
      	}
        
        if (!isthereaction) {
       	  if (act.equals("ADD")) {  
            VENDORID="";
            out.print("<center><table><tr><td><img border=0 src=\"icons/vendor.png\"></td><td><strong><h1>Add vendor</h1></strong></td></tr></table></center><hr>");
          } else {
            out.print("<center><table><tr><td><img border=0 src=\"icons/vendor.png\"></td><td><strong><h1>Modify vendor</h1></strong></td></tr></table></center><hr>");
          }
          out.print("<br>");
          String NAME = "";
          String ADDRESS = "";
          if (act.equals("ADD")) {
            out.print("<form name=\"formFILTER\" method=\"post\" action=\"addvendor.jsp?TODO=ADDCLOSE\" target=\"_top\">");
          } else {
            out.print("<form name=\"formFILTER\" method=\"post\" action=\"addvendor.jsp?TODO=MODCLOSE&VENDORID="+VENDORID+"\" target=\"_top\">");
          }
          if (act.equals("MOD")) {
            Statement STR01 = Conn.createStatement();
            String QR01 = "SELECT ID,NAME,ADDRESS FROM VENDOR WHERE ID='"+VENDORID+"'";
            ResultSet R01 = STR01.executeQuery(QR01);
            if (R01.next()) {
              NAME=R01.getString("NAME");
              ADDRESS=R01.getString("ADDRESS");
            }
            STR01.close();
          }
          out.print("<table>");
          if (act.equals("ADD")) {
            out.print("<tr><td>ID : </td><td><input name=\"ID\" type=\"text\" size=\"50\" value=\"\"></td></tr>");
          }
          out.print("<tr><td>Name : </td><td><input name=\"NAME\" type=\"text\" size=\"50\" value=\""+NAME+"\"></td></tr>");
          out.print("<tr><td>Address : </td><td><textarea name=\"ADDRESS\" cols=\"60\" rows=\"5\" value=\"\">"+ADDRESS+"</textarea></td></tr>");
          if (act.equals("ADD")) {
            out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/add.png\" type=image Value=submit></td>");
            out.print("<td><A HREF=\"#\" onclick=\"window.close();\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
          } else {  
            out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
            out.print("<td><A HREF=\"#\" onclick=\"window.close();\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
          }
          out.print("</table>");
          out.print("</form>");
        }
        Conn.close();
      }

    %>
  </body>
</html>
