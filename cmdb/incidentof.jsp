
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
  PPPMTools pt = new PPPMTools();

  String VERSIONID = request.getParameter("VERSIONID");

  String ID = request.getParameter("ID");

  String TITLE="";
  String DESCRIPTION="";
  String ACTION="";
  String RESULT="";
  String CHECKED ="";

  if (act.equals("NEW")) {
    out.print("<center><strong><h1>New issue</h1></strong></center><hr>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"incident.jsp?TODO=DEF&VERSIONID="+VERSIONID+"\" target=\"appliFrame\">");
  } else {
    out.print("<center><strong><h1>Modify issue</h1></strong></center><hr>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"incident.jsp?TODO=MOD&ID="+ID+"&VERSIONID="+VERSIONID+"\" target=\"appliFrame\">");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_SOFTWARE_INCIDENT WHERE ID='"+ID+"'";
    ResultSet r30 = st30.executeQuery(q30);
    if (r30.next()) {
      TITLE=r30.getString("TITLE");
      DESCRIPTION=r30.getString("DESCRIPTION");
      ACTION=r30.getString("ACTION");
      RESULT=r30.getString("RESULT");
      CHECKED=r30.getString("CHECKED");
    }
    st30.close();
  } 
  out.print("<table>");
  out.print("<tr><td>Title : </td><td><input name=\"TITLE\" type=\"text\" size=\"50\" value=\""+TITLE+"\"></td></tr>");
  out.print("<tr><td>Description : </td><td><textarea name=\"DESCRIPTION\" cols=\"80\" rows=\"25\" value=\"\">"+DESCRIPTION+"</textarea></td></tr>");
  out.print("<tr><td>Action : </td><td><textarea name=\"ACTION\" cols=\"80\" rows=\"25\" value=\"\">"+ACTION+"</textarea></td></tr>");
  out.print("<tr><td>Result : </td><td><textarea name=\"RESULT\" cols=\"80\" rows=\"25\" value=\"\">"+RESULT+"</textarea></td></tr>");
  out.print("<tr><td>Checked : </td><td><select name=\"CHECKED\">");
  out.print("<option");
  if (CHECKED.equals("NO")) {
      out.print(" selected");
  }
  out.print(">NO</option>");
  out.print("<option");
  if (CHECKED.equals("YES")) {
      out.print(" selected");
  }
  out.print(">YES</option>");
  out.print("</select></td></tr>");    
  out.print("<tr><td>&nbsp</td><td><input type=\"submit\" name=\"Save\" value=\"Save\"></td></tr></center>");
  out.print("</table>");
  out.print("</form>");

%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
