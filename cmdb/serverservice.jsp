
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
  String MAILSERVER = (String)session.getAttribute("MAILSERVER");
  String THISSERVER = (String)session.getAttribute("THISSERVER");
  String ID = request.getParameter("ID");
  PPPMTools pt = new PPPMTools();


  if (act.equals("NEW")) {
    String SERVICEIDtmp = pt.checkStr(request.getParameter("SERVICEID"));
    String SERVICEID = SERVICEIDtmp.substring(0,SERVICEIDtmp.indexOf("-")-1);
    String PORT = pt.checkStr(request.getParameter("PORT"));
    Statement sti2 = Conn.createStatement();
    String i2 = "INSERT INTO CMDB_SERVER_SERVICE VALUES('"+ID+"','"+SERVICEID+"','"+PORT+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  } 

  if (act.equals("DELETE")) {
    String SERVICEID = pt.checkStr(request.getParameter("SERVICEID"));
    String PORT = pt.checkStr(request.getParameter("PORT"));
    Statement sti2 = Conn.createStatement();
    String i2 = "DELETE FROM CMDB_SERVER_SERVICE WHERE SERVERID='"+ID+"' AND SERVICEID='"+SERVICEID+"' AND PORT='"+PORT+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }


    out.print("<center><strong><h1>Server Services</h1></strong></center><hr>");

    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>NAME</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"60%\"><center>PORT</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"60%\"><center>DELETE</center></td>");
    out.print("</tr>");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_SERVER_SERVICE WHERE SERVERID='"+ID+"' ORDER BY SERVICEID";
    ResultSet r30 = st30.executeQuery(q30);
    while(r30.next()) {
      out.print("<tr>");
      Statement st31 = Conn.createStatement();
      String q31 = "SELECT * FROM CMDB_SERVICE WHERE ID='"+r30.getString("SERVICEID")+"'";
      ResultSet r31 = st31.executeQuery(q31);
      if (r31.next()) {
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r31.getString("NAME")+"</center></td>");
      }
      st31.close();
      out.print("<td bgcolor=\"#FFFFFF\" width=\"60%\"><center>&nbsp"+r30.getString("PORT")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"deleteserverserviceit.jsp?TODO=NONE&ID="+r30.getString("SERVERID")+"&SERVICEID="+r30.getString("SERVICEID")+"&PORT="+r30.getString("PORT")+"\">DELETE</center></A></td>");  
      out.print("</tr>");
    }
    st30.close();
    out.print("</table>");
    out.print("</form>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"serverserviceit.jsp?TODO=NEW&ID="+ID+"\" target=\"appliFrame\">");
    out.print("<center><input type=\"submit\" name=\"Save\" value=\"Add\"></center>");
    out.print("</form>");


%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
