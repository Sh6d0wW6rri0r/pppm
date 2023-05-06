
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
  String DESCRIPTION="";
  String RACKID="";
  String U="";
  String USIZE="";
  String NBPLUG="";
  out.print("<center><strong><h1>Switch "+ID+"</h1></strong></center><hr>");
  Statement st30 = Conn.createStatement();
  String q30 = "SELECT * FROM CMDB_SWITCH WHERE ID='"+ID+"'";
  ResultSet r30 = st30.executeQuery(q30);
  if (r30.next()) {
      DESCRIPTION=r30.getString("DESCRIPTION");
      RACKID=r30.getString("RACKID");
      U=r30.getString("U");
      USIZE=r30.getString("USIZE");
      NBPLUG=r30.getString("NBPLUG");
  }
  st30.close();
  out.print("<center><table  cellspacing=\"0\" cellpadding=\"0\">");
  out.print("<tr><td width=\"88\"><img src=\"images/begin_switch.jpg\"></td>");
  int nbcol=0;
  for (int i=0;i<Integer.parseInt(NBPLUG);i=i+2) {
    if (nbcol>47) {
      out.print("<td width=\"74\"><img src=\"images/end_switch.jpg\"></td>");
      out.print("</tr></table>");
      out.print("<center><table cellspacing=\"0\" cellpadding=\"0\">");
      out.print("<tr><td width=\"88\"><img src=\"images/begin_switch.jpg\"></td>");
      nbcol=0;
    }
    boolean haut=false;
    Statement st40 = Conn.createStatement();
    String q40 = "SELECT * FROM CMDB_NETCABLE WHERE SWITCHID='"+ID+"' AND PLUG='"+i+"'";
    ResultSet r40 = st40.executeQuery(q40);
    if (r40.next()) {
       haut = true;
    }
    st40.close();
    boolean bas=false;
    Statement st41 = Conn.createStatement();
    String q41 = "SELECT * FROM CMDB_NETCABLE WHERE SWITCHID='"+ID+"' AND PLUG='"+(i+1)+"'";
    ResultSet r41 = st41.executeQuery(q41);
    if (r41.next()) {
       bas = true;
    }
    st41.close();
    if (!haut && !bas) {
      out.print("<td background=\"images/port_switch.jpg\" width=\"26\"><table cellspacing=\"0\" cellpadding=\"0\" width=\"26\" height=\"74\"><tr valign=bottom><td><span style=\"color:white\">"+i+"</span></td></tr><tr valign=center><td><span style=\"color:white\">"+(i+1)+"</span></td></tr></table></center></td>");
    }
    if (haut && !bas) {
      out.print("<td background=\"images/port_switchH.jpg\" width=\"26\"><table cellspacing=\"0\" cellpadding=\"0\" width=\"26\" height=\"74\"><tr valign=bottom><td><span style=\"color:white\">"+i+"</span></td></tr><tr valign=center><td><span style=\"color:white\">"+(i+1)+"</span></td></tr></table></center></td>");
    }
    if (!haut && bas) {
      out.print("<td background=\"images/port_switchB.jpg\" width=\"26\"><table cellspacing=\"0\" cellpadding=\"0\" width=\"26\" height=\"74\"><tr valign=bottom><td><span style=\"color:white\">"+i+"</span></td></tr><tr valign=center><td><span style=\"color:white\">"+(i+1)+"</span></td></tr></table></center></td>");
    }
    if (haut && bas) {
      out.print("<td background=\"images/port_switchHB.jpg\" width=\"26\"><table cellspacing=\"0\" cellpadding=\"0\" width=\"26\" height=\"74\"><tr valign=bottom><td><span style=\"color:white\">"+i+"</span></td></tr><tr valign=center><td><span style=\"color:white\">"+(i+1)+"</span></td></tr></table></center></td>");
    }
    nbcol=nbcol+2;
  }
  out.print("<td width=\"74\"><img src=\"images/end_switch.jpg\"></td>");
  out.print("</tr></table>");
  out.print("<br>");
  out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
  out.print("<tr BGCOLOR=\"#9A9A9A\">");
  out.print("<td background=\"images/fond_titre.jpg\"><center>PORT</center></td>");
  out.print("<td background=\"images/fond_titre.jpg\"><center>ELEMENT ID</center></td>");
  out.print("</tr>");
  for (int i=0;i<Integer.parseInt(NBPLUG);i++) {
    Statement st40 = Conn.createStatement();
    String q40 = "SELECT * FROM CMDB_NETCABLE WHERE SWITCHID='"+ID+"' AND PLUG='"+i+"'";
    ResultSet r40 = st40.executeQuery(q40);
    if (r40.next()) {
       out.print("<tr><td bgcolor=\"#FFFFFF\">"+i+"</td><td bgcolor=\"#FFFFFF\">"+r40.getString("ELEMENTID")+"</td></tr>");
    }
  }
  out.print("</table>");
  out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
 Conn.close();
}


%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
