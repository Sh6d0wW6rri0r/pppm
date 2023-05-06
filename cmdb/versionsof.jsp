
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
  String SOFTWAREID = request.getParameter("SOFTWAREID");
  String VERSION = request.getParameter("VERSION");
  String SERVERID = "";
  String DESCRIPTION="";
  String GOLIVE="";
  String CCFORM="";
  String ID ="";
  String ACTIVE="N";
  String CONTRACTID="NONE";

  if (act.equals("NEW")) {
      out.print("<center><strong><h1>New version</h1></strong></center><hr>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"versions.jsp?TODO=DEF&SOFTWAREID="+SOFTWAREID+"\" target=\"appliFrame\">");
  } else {
      out.print("<center><strong><h1>Modify software</h1></strong></center><hr>");
    ID = request.getParameter("ID");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"versions.jsp?TODO=MOD&ID="+ID+"\" target=\"appliFrame\">");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_SOFTWARE_VERSION WHERE ID='"+ID+"'";
    ResultSet r30 = st30.executeQuery(q30);
    if (r30.next()) {
      SOFTWAREID=r30.getString("SOFTWAREID");
      VERSION=r30.getString("VERSION");
      DESCRIPTION=r30.getString("DESCRIPTION");
      GOLIVE=r30.getString("GOLIVE");
      CCFORM=r30.getString("CCFORM");
      ACTIVE=r30.getString("ACTIVE");
      CONTRACTID=r30.getString("CONTRACTID");
    }
    st30.close();
  } 
  out.print("<table>");
  out.print("<tr><td>Version number: </td><td><input name=\"VERSION\" type=\"text\" size=\"50\" value=\""+VERSION+"\"></td></tr>");
  out.print("<tr><td>Description of the version : </td><td><textarea name=\"DESCRIPTION\" cols=\"80\" rows=\"25\" value=\"\">"+DESCRIPTION+"</textarea></td></tr>");
  out.print("<tr><td>Date of GOLIVE : </td><td><input name=\"GOLIVE\" type=\"text\" size=\"50\" value=\""+GOLIVE+"\"></td></tr>");
  out.print("<tr><td>Change Control Form : </td><td><input name=\"CCFORM\" type=\"text\" size=\"50\" value=\""+CCFORM+"\"></td></tr>");
  out.print("<tr><td>Is this version ACTIVE : </td><td><select name=\"ACTIVE\">");
  out.print("<option");
  if (ACTIVE.equals("Y")) {
    out.print(" selected");
  }
  out.print(">Y</option>");
  out.print("<option");
  if (ACTIVE.equals("N")) {
    out.print(" selected");
  }
  out.print(">N</option>");
  out.print("</select></td></tr>");    

  out.print("<tr><td>Support contract : </td><td><select name=\"CONTRACTID\">");
  out.print("<option");
  if (CONTRACTID.equals("NONE")) {
    out.print(" selected ");
  }
  out.print(">NONE</option>");
  Statement st50 = Conn.createStatement();
  String q50 = "SELECT * FROM CMDB_VENDOR_CONTRACT";
  ResultSet r50 = st50.executeQuery(q50);
  while(r50.next()) {
    out.print("<option");
    if (CONTRACTID.equals(r50.getString("ID"))) {
      out.print(" selected ");
    }
    Statement st51 = Conn.createStatement();
    String q51 = "SELECT * FROM VENDOR WHERE ID='"+r50.getString("VENDORID")+"'";
    ResultSet r51 = st51.executeQuery(q51);
    if (r51.next()) {
      out.print(">"+r50.getString("ID")+" - "+r50.getString("REFERENCE")+" - "+r51.getString("NAME")+"</option>");
    } else {
      out.print(">"+r50.getString("ID")+" - "+r50.getString("REFERENCE")+"</option>");
    }
    st51.close();
  }
  st50.close();
  out.print("</select></td></tr>");
  
    out.print("<tr><td>&nbsp</td><td><input type=\"submit\" name=\"Save\" value=\"Save\"></td></tr></center>");
  out.print("</table>");
  out.print("</form>");

%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
