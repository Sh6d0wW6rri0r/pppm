
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

  out.print("<center><strong><h1>Vendor</h1></strong></center><hr>");

  String NAME = "";
  String DESCRIPTION = "";
  String CONTACT = "";

  if (act.equals("ADD")) {
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"vendor.jsp?TODO=ADD&RO=NO\" target=\"appliFrame\">");
  } else {
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"vendor.jsp?TODO=MOD&ID="+ID+"&RO=NO\" target=\"appliFrame\">");
  }

  if (!act.equals("ADD")) {
    Statement st10 = Conn.createStatement();
    String q10 = "SELECT * FROM VENDOR WHERE ID='"+ID+"'";
    ResultSet r10 = st10.executeQuery(q10);
    if (r10.next()) {
      NAME=r10.getString("NAME");
      DESCRIPTION=r10.getString("DESCRIPTION");
      CONTACT=r10.getString("CONTACT");
    }
    st10.close();
  }

  out.print("<table>");


  out.print("<tr><td>Name: </td><td><input name=\"NAME\" type=\"text\" size=\"50\" value=\""+NAME+"\"></td></tr>");

  out.print("<tr><td>Description : </td><td><textarea name=\"DESCRIPTION\" cols=\"80\" rows=\"25\" value=\"\">"+DESCRIPTION+"</textarea></td></tr>");
 
  out.print("<tr><td>Contact : </td><td><textarea name=\"CONTACT\" cols=\"80\" rows=\"25\" value=\"\">"+CONTACT+"</textarea></td></tr>");

  out.print("<tr><td>&nbsp</td><td><input type=\"submit\" name=\"Save\" value=\"Assign\"></td></tr></center>");

  out.print("</table>");
  out.print("</form>");

%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
