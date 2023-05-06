
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
  PPPMTools pt = new PPPMTools();

  String SOFTWARENAME="";
  String SOFTWAREDESCRIPTION="";
  String SITEID="NONE";
  String VENDORID="NONE";

  if (act.equals("NEW")) {
      out.print("<center><strong><h1>New software</h1></strong></center><hr>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"software.jsp?TODO=DEF&ID=NEW\" target=\"appliFrame\">");
  } else {
      out.print("<center><strong><h1>Modify software</h1></strong></center><hr>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"software.jsp?TODO=DEF&ID="+ID+"\" target=\"appliFrame\">");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_SOFTWARE WHERE ID='"+ID+"'";
    ResultSet r30 = st30.executeQuery(q30);

    if (r30.next()) {
      SOFTWARENAME=r30.getString("NAME");
      SOFTWAREDESCRIPTION=r30.getString("DESCRIPTION");
      SITEID=r30.getString("SITEID");
      VENDORID=r30.getString("VENDORID");
    }
    st30.close();
  } 
  out.print("<table>");

  out.print("<tr><td>Name of the software : </td><td><input name=\"SOFTWARENAME\" type=\"text\" size=\"50\" value=\""+SOFTWARENAME+"\"></td></tr>");
  out.print("<tr><td>Description of the software : </td><td><textarea name=\"SOFTWAREDESCRIPTION\" cols=\"80\" rows=\"25\" value=\"\">"+SOFTWAREDESCRIPTION+"</textarea></td></tr>");
  out.print("<tr><td>Managed by site : </td><td><select name=\"SITEID\">");
  out.print("<option");
  if (SITEID.equals("NONE")) {
    out.print(" selected ");
  }
  out.print(">NONE</option>");
  Statement st20 = Conn.createStatement();
  String q20 = "SELECT * FROM LOCATION";
  ResultSet r20 = st20.executeQuery(q20);
  while(r20.next()) {
    out.print("<option");
    if (SITEID.equals(r20.getString("ID"))) {
      out.print(" selected");
    }
    out.print(">"+r20.getString("ID")+" - "+r20.getString("NAME")+"</option>");
  }
  st20.close();
  out.print("</select></td></tr>");    
  out.print("<tr><td>Vendor / Editor : </td><td><select name=\"VENDORID\">");
  out.print("<option");
  if (VENDORID.equals("NONE")) {
    out.print(" selected ");
  }
  out.print(">NONE</option>");
  Statement st21 = Conn.createStatement();
  String q21 = "SELECT * FROM VENDOR";
  ResultSet r21 = st21.executeQuery(q21);
  while(r21.next()) {
    out.print("<option");
    if (VENDORID.equals(r21.getString("ID"))) {
      out.print(" selected");
    }
    out.print(">"+r21.getString("ID")+" - "+r21.getString("NAME")+"</option>");
  }
  st21.close();
  out.print("</select></td></tr>");    

    out.print("<tr><td>&nbsp</td><td><input type=\"submit\" name=\"Save\" value=\"Save\"></td></tr></center>");
  out.print("</table>");
  out.print("</form>");

%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
