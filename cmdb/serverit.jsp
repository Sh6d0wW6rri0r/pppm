
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


  String DESCRIPTION="";
  String U="";
  String USIZE="";
  String RACKID="";
  String VIRTUAL="";
  String VIRTUALHOST="";
  String CONTRACTID="NONE";
  String SITEID="NONE";
  String OSID="NONE";
  String SPID="NONE";
  String VENDORID="NONE";

  if (act.equals("NEW")) {
      out.print("<center><strong><h1>New server</h1></strong></center><hr>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"server.jsp?TODO=NEW\" target=\"appliFrame\">");
  } else {
      out.print("<center><strong><h1>Modify server</h1></strong></center><hr>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"server.jsp?TODO=MOD&ID="+ID+"\" target=\"appliFrame\">");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_SERVER WHERE ID='"+ID+"'";
    ResultSet r30 = st30.executeQuery(q30);
    if (r30.next()) {
      DESCRIPTION=r30.getString("DESCRIPTION");
      U=r30.getString("U");
      USIZE=r30.getString("USIZE");
      RACKID=r30.getString("RACKID");
      VIRTUAL=r30.getString("VIRTUAL");
      VIRTUALHOST=r30.getString("VIRTUALHOST");
      CONTRACTID=r30.getString("CONTRACTID");
      SITEID=r30.getString("SITEID");
      OSID=r30.getString("OSID");
      SPID=r30.getString("SPID");
      VENDORID=r30.getString("VENDORID");
    }
    st30.close();
  } 
  out.print("<table>");
 
  if (act.equals("NEW")) {
    out.print("<tr><td>Name of the server : </td><td><input name=\"ID\" type=\"text\" size=\"50\" value=\""+ID+"\"></td></tr>");
  } else {
    out.print("<tr><td>Name of the server : </td><td>"+ID+"</td></tr>");
  }
  out.print("<tr><td>Description of the server : </td><td><textarea name=\"DESCRIPTION\" cols=\"80\" rows=\"25\" value=\"\">"+DESCRIPTION+"</textarea></td></tr>");

  out.print("<tr><td>Virtual : </td><td><select name=\"VIRTUAL\">");
  out.print("<option");
  if (VIRTUAL.equals("Y")) {
      out.print(" selected ");
  }
  out.print(">YES</option>");
  out.print("<option");
  if (VIRTUAL.equals("N")) {
      out.print(" selected ");
  }
  out.print(">NO</option>");
  out.print("</select></td></tr>");


  out.print("<tr><td>Virtual host: </td><td><select name=\"VIRTUALHOST\">");
  out.print("<option>NONE</option>");
  Statement st120 = Conn.createStatement();
  String q120 = "SELECT * FROM CMDB_SERVER";
  ResultSet r120 = st120.executeQuery(q120);
  while(r120.next()) {
    out.print("<option");
    if (VIRTUALHOST.equals(r120.getString("ID"))) {
      out.print(" selected ");
    }
    out.print(">"+r120.getString("ID")+"</option>");
  }
  st120.close();
  out.print("</select></td></tr>");


  out.print("<tr><td>Start on U : </td><td><input name=\"U\" type=\"text\" size=\"50\" value=\""+U+"\"></td></tr>");

  out.print("<tr><td>Size in U : </td><td><select name=\"USIZE\">");
  for (int j=1;j<=8; j++) {
    out.print("<option");
    if (USIZE.equals(""+j)) {
      out.print(" selected ");
    }
    out.print(">"+j+"</option>");
  }
  out.print("</select></td></tr>");

  out.print("<tr><td>Stored in rack : </td><td><select name=\"RACKID\">");
  out.print("<option>NONE</option>");
  Statement st20 = Conn.createStatement();
  String q20 = "SELECT * FROM CMDB_RACK";
  ResultSet r20 = st20.executeQuery(q20);
  while(r20.next()) {
    out.print("<option");
    if (RACKID.equals(r20.getString("ID"))) {
      out.print(" selected ");
    }
    out.print(">"+r20.getString("ID")+"</option>");
  }
  st20.close();
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

  out.print("<tr><td>Managed by site : </td><td><select name=\"SITEID\">");
  out.print("<option");
  if (SITEID.equals("NONE")) {
    out.print(" selected ");
  }
  out.print(">NONE</option>");
  Statement st200 = Conn.createStatement();
  String q200 = "SELECT * FROM LOCATION";
  ResultSet r200 = st200.executeQuery(q200);
  while(r200.next()) {
    out.print("<option");
    if (SITEID.equals(r200.getString("ID"))) {
      out.print(" selected");
    }
    out.print(">"+r200.getString("ID")+" - "+r200.getString("NAME")+"</option>");
  }
  st200.close();

  out.print("</select></td></tr>");    
  out.print("<tr><td>Vendor : </td><td><select name=\"VENDORID\">");
  out.print("<option");
  if (VENDORID.equals("NONE")) {
    out.print(" selected ");
  }
  out.print(">NONE</option>");
  Statement st400 = Conn.createStatement();
  String q400 = "SELECT * FROM VENDOR";
  ResultSet r400 = st400.executeQuery(q400);
  while(r400.next()) {
    out.print("<option");
    if (VENDORID.equals(r400.getString("ID"))) {
      out.print(" selected");
    }
    out.print(">"+r400.getString("ID")+" - "+r400.getString("NAME")+"</option>");
  }
  st400.close();
  out.print("</select></td></tr>"); 

  out.print("<tr><td>Operating System : </td><td><select name=\"OSSPID\">");
  out.print("<option");
  if (OSID.equals("NONE")) {
    out.print(" selected ");
  }
  out.print(">NONE</option>");
  Statement st300 = Conn.createStatement();
  String q300 = "SELECT * FROM CMDB_OS";
  ResultSet r300 = st300.executeQuery(q300);
  while(r300.next()) {
    Statement st301 = Conn.createStatement();
    String q301 = "SELECT * FROM CMDB_SP WHERE OSID='"+r300.getString("ID")+"'";
    ResultSet r301 = st301.executeQuery(q301);
    while(r301.next()) {
      out.print("<option");
      if (OSID.equals(r300.getString("ID")) && SPID.equals(r301.getString("ID"))) {
        out.print(" selected");
      }
      out.print(">"+r300.getString("ID")+" - "+r301.getString("ID")+" - "+r300.getString("NAME")+" "+r301.getString("NAME")+"</option>");
    }
    st301.close();
  }
  st300.close();
  out.print("</select></td></tr>"); 

    out.print("<tr><td>&nbsp</td><td><input type=\"submit\" name=\"Save\" value=\"Save\"></td></tr></center>");
  out.print("</table>");
  out.print("</form>");

%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
