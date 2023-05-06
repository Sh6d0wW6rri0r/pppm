
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


  String SERVICEID="";
  String PORT="";

  out.print("<center><strong><h1>New Service instance</h1></strong></center><hr>");
  out.print("<form name=\"formFILTER\" method=\"post\" action=\"serverservice.jsp?TODO=NEW&ID="+ID+"\" target=\"appliFrame\">");
  out.print("<table>");
 
  out.print("<tr><td>Name of the server : </td><td>"+ID+"</td></tr>");
  
  out.print("<tr><td>Service : </td><td><select name=\"SERVICEID\">");
  Statement st21 = Conn.createStatement();
  String q21 = "SELECT * FROM CMDB_SERVICE";
  ResultSet r21 = st21.executeQuery(q21);
  while(r21.next()) {
    out.print("<option");
    out.print(">"+r21.getString("ID")+" - "+r21.getString("NAME")+"</option>");
  }
  st21.close();
  out.print("</select></td></tr>");    

  out.print("<tr><td>Port : </td><td><input name=\"PORT\" type=\"text\" size=\"50\" value=\""+PORT+"\"></td></tr>");

  out.print("<tr><td>&nbsp</td><td><input type=\"submit\" name=\"Save\" value=\"Save\"></td></tr></center>");
  out.print("</table>");
  out.print("</form>");

%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
