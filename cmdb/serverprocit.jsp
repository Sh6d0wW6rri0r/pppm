
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

<%String Userlogin = (String)session.getAttribute("LOGIN");
  String POOLNAME=(String)session.getAttribute("POOLNAME");
  Context initCtx = new InitialContext();
  DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/"+POOLNAME);
  Connection Conn = ds.getConnection();
  String act = request.getParameter("TODO");
  String ID = request.getParameter("ID");
  String PROCID = request.getParameter("PROCID");


  String PROCTYPE="";
  String PROCCORE="";

  if (act.equals("NEW")) {
    out.print("<center><strong><h1>New Processor</h1></strong></center><hr>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"serverconf.jsp?TODO=NEWPROC&ID="+ID+"\" target=\"appliFrame\">");
  } else {
    out.print("<center><strong><h1>Modify Processor</h1></strong></center><hr>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"serverconf.jsp?TODO=MODPROC&ID="+ID+"&PROCID="+PROCID+"\" target=\"appliFrame\">");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_SERVER_PROC WHERE SERVERID='"+ID+"' AND PROCID='"+PROCID+"'";
    ResultSet r30 = st30.executeQuery(q30);
    if (r30.next()) {
      PROCTYPE=r30.getString("PROCTYPE");
      PROCCORE=r30.getString("PROCCORE");
    }
    st30.close();
  } 
  out.print("<table>");
 
  out.print("<tr><td>Name of the server : </td><td>"+ID+"</td></tr>");

  if (!act.equals("NEW")) {
    out.print("<tr><td>Processod ID : </td><td>"+PROCID+"</td></tr>");
  }
  out.print("<tr><td>Type of processor : </td><td><input name=\"PROCTYPE\" type=\"text\" size=\"50\" value=\""+PROCTYPE+"\"></td></tr>");
  out.print("<tr><td>Number of Core : </td><td><input name=\"PROCCORE\" type=\"text\" size=\"50\" value=\""+PROCCORE+"\"></td></tr>");

    out.print("<tr><td>&nbsp</td><td><input type=\"submit\" name=\"Save\" value=\"Save\"></td></tr></center>");
  out.print("</table>");
  out.print("</form>");

%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
