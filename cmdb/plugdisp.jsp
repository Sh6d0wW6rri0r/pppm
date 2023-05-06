
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css"> 
body { color: black; font-family: arial; font-size: 12px}
h1 { color: black; font-family: arial; font-size: 18px}

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



<body background="images/comp023.gif">

<%
String Userlogin = (String)session.getAttribute("LOGIN");
if (Userlogin==null) {
  out.print("<script language=\"JavaScript\">");
  out.print("top.location='index.jsp?TIMEOUT=TRUE';");
  out.print("</script>");
} else {
  String POOLNAME=(String)session.getAttribute("POOLNAME");
  Context initCtx = new InitialContext();
  DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
  Connection Conn = ds.getConnection(); 
  String act = request.getParameter("TODO");
  String ID = request.getParameter("ID");
  String ROOMID = request.getParameter("ROOMID");
  out.print("<center><strong><h1>PLUG "+ID+"</h1></strong></center><hr>");


  out.print("<center><table  cellspacing=\"0\" cellpadding=\"0\">");
  out.print("<tr><td width=\"333\"><img src=\"images/input_power.jpg\"></td>");
  Statement st40 = Conn.createStatement();
  String q40 = "SELECT * FROM CMDB_PDU WHERE PLUGID='"+ID+"'";
  ResultSet r40 = st40.executeQuery(q40);
  if (r40.next()) {
    out.print("<td background=\"images/plug_power.jpg\" width=\"333\">&nbsp</td>");
  } else {
    out.print("<td width=\"333\">&nbsp</td>");    
  }
  st40.close();
  out.print("</tr></table>");

  out.print("<br>");

  out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
  out.print("<tr BGCOLOR=\"#9A9A9A\">");
  out.print("<td background=\"images/fond_titre.jpg\"><center>PDU</center></td>");
  out.print("<td background=\"images/fond_titre.jpg\"><center>DESCRIPTION</center></td>");
  out.print("</tr>");
  Statement st41 = Conn.createStatement();
  String q41 = "SELECT * FROM CMDB_PDU WHERE PLUGID='"+ID+"'";
  ResultSet r41 = st41.executeQuery(q41);
  while (r41.next()) {
    out.print("<tr><td bgcolor=\"#FFFFFF\">"+r41.getString("ID")+"</td><td bgcolor=\"#FFFFFF\">"+r41.getString("DESCRIPTION")+"</td></tr>");
  }
  st41.close();
  out.print("</table>");
  out.print("<br><center><A HREF=\"plug.jsp?TODO=NONE&ROOMID="+ROOMID+"\">Return</A></center>");
  Conn.close();
}


%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
