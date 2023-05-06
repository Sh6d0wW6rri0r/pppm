
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
  String VOLUMEID = request.getParameter("VOLUMEID");
  String VOLUMENAME="";
  String VOLUMESIZE="";
  if (act.equals("NEW")) {
    out.print("<center><strong><h1>New volume</h1></strong></center><hr>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"sanconf.jsp?TODO=NEWVOLUME&ID="+ID+"\" target=\"_top\">");
  } else {
    out.print("<center><strong><h1>Modify volume</h1></strong></center><hr>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"sanconf.jsp?TODO=MODVOLUME&ID="+ID+"&VOLUMEID="+VOLUMEID+"\" target=\"_top\">");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_SAN_VOLUME WHERE SANID='"+ID+"' AND VOLUMEID='"+VOLUMEID+"'";
    ResultSet r30 = st30.executeQuery(q30);
    if (r30.next()) {
      VOLUMENAME=r30.getString("VOLUMENAME");
      VOLUMESIZE=r30.getString("VOLUMESIZE");
    }
    st30.close();
  } 
  out.print("<table>");
  out.print("<tr><td>Name of the san : </td><td>"+ID+"</td></tr>");
  if (!act.equals("NEW")) {
    out.print("<tr><td>VOLUME ID : </td><td>"+VOLUMEID+"</td></tr>");
  }
  out.print("<tr><td>Name of volume : </td><td><input name=\"VOLUMENAME\" type=\"text\" size=\"50\" value=\""+VOLUMENAME+"\"></td></tr>");
  out.print("<tr><td>Size of volume : </td><td><input name=\"VOLUMESIZE\" type=\"text\" size=\"50\" value=\""+VOLUMESIZE+"\"></td></tr>");
  if (act.equals("NEW")) {
    out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/add.png\" type=image Value=submit></td>");
    out.print("<td><A HREF=\"sanconf.jsp?TODO=NONE&ID="+ID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
  } else {  
    out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
    out.print("<td><A HREF=\"sanconf.jsp?TODO=NONE&ID="+ID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
  }
  out.print("</table>");
  out.print("</form>");
  Conn.close();
}

%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
