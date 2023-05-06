
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
  String USIZE ="";
  String DESCRIPTION="";
  String OSID="";
  String SPID="";

    Statement st3 = Conn.createStatement();
    String q3 = "SELECT * FROM CMDB_OTHER WHERE ID='"+ID+"'";
    ResultSet r3 = st3.executeQuery(q3);
    if (r3.next()) {
      USIZE=r3.getString("USIZE");
      DESCRIPTION=r3.getString("DESCRIPTION");
    }
    st3.close();

    out.print("<center><strong><h1>Other Configuration : "+ID+"</h1></strong></center><hr>");
 
    out.print("<br><center><img src=\"images/other/"+Integer.parseInt(USIZE)+"U.jpg\"></center><br>");

    out.print("<center><strong><h1>"+DESCRIPTION+"</h1></strong></center><hr>");


    out.print("<br><strong>Network Interface(s)</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>&nbsp</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"8%\"><center>NET #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>TYPE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>SPEED</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"13%\"><center>ADDRESS</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"13%\"><center>MASK</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"13%\"><center>GATEWAY</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>ON SWITCH</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>ON PORT</center></td>");  
    out.print("</tr>");
    Statement st33 = Conn.createStatement();
    String q33 = "SELECT * FROM CMDB_OTHER_NETWORK WHERE OTHERID='"+ID+"' ORDER BY NETWORKID";
    ResultSet r33 = st33.executeQuery(q33);
    while(r33.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"8%\"><center><img src=\"images/net.jpg\"></center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"8%\"><center>&nbsp"+r33.getString("NETWORKID")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp"+r33.getString("NETWORKTYPE")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp"+r33.getString("NETWORKSPEED")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"13%\"><center>&nbsp"+r33.getString("NETWORKADDRESS")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"13%\"><center>&nbsp"+r33.getString("NETWORKMASK")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"13%\"><center>&nbsp"+r33.getString("NETWORKGATEWAY")+"</center></td>");
      Statement st33b = Conn.createStatement();
      String q33b = "SELECT * FROM CMDB_NETCABLE WHERE ELEMENTID='"+ID+" - "+r33.getString("NETWORKID")+"' AND ELEMENTTYPE='OTHER'";
      ResultSet r33b = st33b.executeQuery(q33b);
      if (r33b.next()) {
        out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp"+r33b.getString("SWITCHID")+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp"+r33b.getString("PLUG")+"</center></td>");
      } else {
        out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp</center></td>");
      }
      st33b.close();
      out.print("</tr>");
    }
    st33.close();
    out.print("</table>");


    out.print("<br><strong>Power Connection(s)</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>&nbsp</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>POWER #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"30%\"><center>TYPE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>CAPACITY</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>ON PDU</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>ON PORT</center></td>");  
    out.print("</tr>");
    Statement st35 = Conn.createStatement();
    String q35 = "SELECT * FROM OTHER_POWER WHERE OTHERID='"+ID+"' ORDER BY POWERID";
    ResultSet r35 = st35.executeQuery(q35);
    while(r35.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center><img src=\"images/power.jpg\"></center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r35.getString("POWERID")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"30%\"><center>&nbsp"+r35.getString("POWERTYPE")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp"+r35.getString("POWERCAPACITY")+"</center></td>");
      Statement st35b = Conn.createStatement();
      String q35b = "SELECT * FROM CMDB_POWERCABLE WHERE ELEMENTID='"+ID+" | "+r35.getString("POWERID")+"' AND ELEMENTTYPE='OTHER'";
      ResultSet r35b = st35b.executeQuery(q35b);
      if (r35b.next()) {
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r35b.getString("PDUID")+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r35b.getString("PLUG")+"</center></td>");
      } else {
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp</center></td>");
      }
      st35b.close();
      out.print("</tr>");
    }
    st35.close();
    out.print("</table>");




%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
