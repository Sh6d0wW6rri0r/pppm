
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
  String RO = request.getParameter("RO");
  PPPMTools pt = new PPPMTools();

  if (act.equals("ADD")) {
    Statement sti2 = Conn.createStatement();
    String SERVERID = request.getParameter("SERVERID");
    String i2 = "INSERT INTO CMDB_SOFTWARE_INSTANCE VALUES ('"+ID+"','"+SERVERID+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  }
  

  if (act.equals("DELETE")) {
    Statement sti2 = Conn.createStatement();
    String SERVERID = request.getParameter("SERVERID");
    String i2 = "DELETE FROM CMDB_SOFTWARE_INSTANCE WHERE VERSIONID='"+ID+"' AND SERVERID='"+SERVERID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }

    out.print("<center><strong><h1>Software Instances</h1></strong></center><hr>");


    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\"><center><strong>SERVER</strong></center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center><strong>DELETE</strong></center></td>");  
    out.print("</tr>");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_SOFTWARE_INSTANCE WHERE VERSIONID='"+ID+"'";
    ResultSet r30 = st30.executeQuery(q30);
    while(r30.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("SERVERID")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"deleteinstanceof.jsp?TODO=NONE&VERSIONID="+ID+"&SERVERID="+r30.getString("SERVERID")+"\">DELETE</center></A></td>");      
      out.print("</tr>");
    }
    st30.close();
    out.print("</table>");
    out.print("</form>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"instanceof.jsp?TODO=ADD&VERSIONID="+ID+"\" target=\"appliFrame\">");
      out.print("<center><input type=\"submit\" name=\"Save\" value=\"Add\"></center>");
    out.print("</form>");
%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
