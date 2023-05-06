
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css"> 
body { color: black; font-family: arial; font-size: 12px}
h1 { color: black; font-family: arial; font-size: 18px}

 </style> 


<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/PopupWindow.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/date.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/AnchorPosition.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
var cal = new CalendarPopup();
</SCRIPT>

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
  String RACKID = request.getParameter("RACKID");

  out.print("<center><strong><h1>PDU</h1></strong></center><hr>");

  String CAPACITY = "";
  String DESCRIPTION = "";
  String NBPLUG = "";
  String PLUGID = "";

  if (act.equals("ADD")) {
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"pdu.jsp?TODO=ADD&RACKID="+RACKID+"\" target=\"_top\">");
  } else {
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"pdu.jsp?TODO=MOD&ID="+ID+"&RACKID="+RACKID+"\" target=\"_top\">");
  }

  if (!act.equals("ADD")) {
    Statement st10 = Conn.createStatement();
    String q10 = "SELECT * FROM CMDB_PDU WHERE ID='"+ID+"' AND RACKID='"+RACKID+"'";
    ResultSet r10 = st10.executeQuery(q10);
    if (r10.next()) {
      CAPACITY=r10.getString("CAPACITY");
      DESCRIPTION=r10.getString("DESCRIPTION");
      NBPLUG=r10.getString("NBPLUG");
      PLUGID=r10.getString("PLUGID");
    }
    st10.close();
  }

  out.print("<table>");


  out.print("<tr><td>Description : </td><td><textarea name=\"DESCRIPTION\" cols=\"80\" rows=\"25\" value=\"\">"+DESCRIPTION+"</textarea></td></tr>");
  out.print("<tr><td>Power capacity (W) per plug : </td><td><input name=\"CAPACITY\" type=\"text\" size=\"50\" value=\""+CAPACITY+"\"></td></tr>");
  out.print("<tr><td>Number of plug : </td><td><input name=\"NBPLUG\" type=\"text\" size=\"50\" value=\""+NBPLUG+"\"></td></tr>");
  out.print("<tr><td>Connected to power plug : </td><td><select name=\"PLUGID\">");
  out.print("<option");
  String ROOMID="NONE";
  Statement st41 = Conn.createStatement();
  String q41 = "SELECT * FROM CMDB_RACK WHERE ID='"+RACKID+"'";
  ResultSet r41 = st41.executeQuery(q41);
  if(r41.next()) {
    ROOMID=r41.getString("ROOMID");
  }
  st41.close();
  if (PLUGID.equals("NONE")) {
    out.print(" selected ");
  }
  out.print(">NONE</option>");
  Statement st40 = Conn.createStatement();
  String q40 = "SELECT * FROM CMDB_PLUG WHERE ROOMID='"+ROOMID+"'";
  ResultSet r40 = st40.executeQuery(q40);
  while(r40.next()) {
    out.print("<option");
    if (PLUGID.equals(r40.getString("ID"))) {
      out.print(" selected ");
    }
    out.print(">"+r40.getString("ID")+" - "+r40.getString("DESCRIPTION")+"</option>");
  }
  st40.close();
  out.print("</select></td></tr>");
  if (act.equals("ADD")) {
    out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/add.png\" type=image Value=submit></td>");
    out.print("<td><A HREF=\"pdu.jsp?TODO=NONE&RACKID="+RACKID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
  } else {  
    out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
    out.print("<td><A HREF=\"pdu.jsp?TODO=NONE&RACKID="+RACKID+"\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
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
