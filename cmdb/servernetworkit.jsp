
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
  String NETWORKID = request.getParameter("NETWORKID");


  String NETWORKTYPE="";
  String NETWORKSPEED="";
  String NETWORKADDRESS="";
  String NETWORKMASK="";
  String NETWORKGATEWAY="";
  String SWITCHID="NONE";
  String PLUG="";

  if (act.equals("NEW")) {
    out.print("<center><strong><h1>New Network adapter</h1></strong></center><hr>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"serverconf.jsp?TODO=NEWNETWORK&ID="+ID+"\" target=\"appliFrame\">");
  } else {
    out.print("<center><strong><h1>Modify Network adapter</h1></strong></center><hr>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"serverconf.jsp?TODO=MODNETWORK&ID="+ID+"&NETWORKID="+NETWORKID+"\" target=\"appliFrame\">");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_SERVER_NETWORK WHERE SERVERID='"+ID+"' AND NETWORKID='"+NETWORKID+"'";
    ResultSet r30 = st30.executeQuery(q30);
    if (r30.next()) {
      NETWORKTYPE=r30.getString("NETWORKTYPE");
      NETWORKSPEED=r30.getString("NETWORKSPEED");
      NETWORKADDRESS=r30.getString("NETWORKADDRESS");
      NETWORKMASK=r30.getString("NETWORKMASK");
      NETWORKGATEWAY=r30.getString("NETWORKGATEWAY");
    }
    st30.close();
    Statement st31 = Conn.createStatement();
    String q31 = "SELECT * FROM CMDB_NETCABLE WHERE ELEMENTID='"+ID+" - "+NETWORKID+"' AND ELEMENTTYPE='SERVER'";
    ResultSet r31 = st31.executeQuery(q31);
    if (r31.next()) {
      SWITCHID=r31.getString("SWITCHID");
      PLUG=r31.getString("PLUG");
    }
    st31.close();
  } 
  out.print("<table>");
 
  out.print("<tr><td>Name of the server : </td><td>"+ID+"</td></tr>");

  if (!act.equals("NEW")) {
    out.print("<tr><td>NETWORK ID : </td><td>"+NETWORKID+"</td></tr>");
  }
  out.print("<tr><td>Type of network : </td><td><input name=\"NETWORKTYPE\" type=\"text\" size=\"50\" value=\""+NETWORKTYPE+"\"></td></tr>");
  out.print("<tr><td>Speed of network : </td><td><input name=\"NETWORKSPEED\" type=\"text\" size=\"50\" value=\""+NETWORKSPEED+"\"></td></tr>");
  out.print("<tr><td>Network address : </td><td><input name=\"NETWORKADDRESS\" type=\"text\" size=\"50\" value=\""+NETWORKADDRESS+"\"></td></tr>");
  out.print("<tr><td>Network mask : </td><td><input name=\"NETWORKMASK\" type=\"text\" size=\"50\" value=\""+NETWORKMASK+"\"></td></tr>");
  out.print("<tr><td>Network gateway : </td><td><input name=\"NETWORKGATEWAY\" type=\"text\" size=\"50\" value=\""+NETWORKGATEWAY+"\"></td></tr>");

  out.print("<tr><td>Connected to Switch : </td><td><select name=\"SWITCHID\">");
  out.print("<option");
  if (SWITCHID.equals("NONE")) {
    out.print(" selected ");
  }
  out.print(">NONE</option>");
  Statement st40 = Conn.createStatement();
  String q40 = "SELECT * FROM CMDB_SWITCH";
  ResultSet r40 = st40.executeQuery(q40);
  while(r40.next()) {
    out.print("<option");
    if (SWITCHID.equals(r40.getString("ID"))) {
      out.print(" selected ");
    }
    out.print(">"+r40.getString("ID")+"</option>");
  }
  st40.close();
  out.print("</select></td></tr>");
  out.print("<tr><td>Connected on port : </td><td><input name=\"PLUG\" type=\"text\" size=\"50\" value=\""+PLUG+"\"></td></tr>");


    out.print("<tr><td>&nbsp</td><td><input type=\"submit\" name=\"Save\" value=\"Save\"></td></tr></center>");
  out.print("</table>");
  out.print("</form>");

%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
