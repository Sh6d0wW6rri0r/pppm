
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


<body background="images/comp023.gif">

<%String Userlogin = (String)session.getAttribute("LOGIN");
  Connection Conn = (Connection)session.getAttribute("DBConnection");
  String act = request.getParameter("TODO");
  String ID = request.getParameter("ID");
  String SERVICEID = request.getParameter("SERVICEID");
  String PORT = request.getParameter("PORT");

  out.print("<center><strong><h1>Service instance deletion approval</h1></strong></center><hr>");


  out.print("<form name=\"formFILTER\" method=\"post\" action=\"serverservice.jsp?TODO=DELETE&ID="+ID+"&SERVICEID="+SERVICEID+"&PORT="+PORT+"\" target=\"appliFrame\">");
  out.print("<table>");

  out.print("<tr><td>Server : </td><td>"+ID+"</td></tr>");
  Statement st31 = Conn.createStatement();
  String q31 = "SELECT * FROM SERVICE WHERE ID='"+SERVICEID+"'";
  ResultSet r31 = st31.executeQuery(q31);
  if (r31.next()) {
    out.print("<tr><td>Service : </td><td>"+r31.getString("NAME")+"</td></tr>");
  }
  st31.close();
  out.print("<tr><td>Service : </td><td>"+ID+"</td></tr>");
  out.print("<tr><td>Port : </td><td>"+PORT+"</td></tr>");

  out.print("<tr><td><H1>Are you sure that you want to delete this instance ??</H1></td><td>&nbsp</td></tr>");
  out.print("<tr><td>&nbsp</td><td><input type=\"submit\" name=\"Save\" value=\"Delete\">");
  out.print("<input type=button onClick=\"location.href='serverservice.jsp?TODO=NONE&ID="+ID+"'\" value='Cancel'></td></tr>");
  out.print("</table>");
  out.print("</form>");

%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
