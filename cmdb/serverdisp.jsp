
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
    String q3 = "SELECT * FROM CMDB_SERVER WHERE ID='"+ID+"'";
    ResultSet r3 = st3.executeQuery(q3);
    if (r3.next()) {
      USIZE=r3.getString("USIZE");
      DESCRIPTION=r3.getString("DESCRIPTION");
      OSID=r3.getString("OSID");
      SPID=r3.getString("SPID");
    }
    st3.close();

    out.print("<center><strong><h1>Server Configuration : "+ID+"</h1></strong></center><hr>");
 
    out.print("<br><center><img src=\"images/server/"+Integer.parseInt(USIZE)+"U.jpg\"></center><br>");

    out.print("<center><strong><h1>"+DESCRIPTION+"</h1></strong></center><hr>");

    out.print("<br><strong>OS</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>&nbsp</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"40%\"><center>NAME</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"40%\"><center>SERVICE PACK</center></td>");
    out.print("</tr>");
    Statement st29 = Conn.createStatement();
    String q29 = "SELECT * FROM CMDB_OS WHERE ID='"+OSID+"'";
    ResultSet r29 = st29.executeQuery(q29);
    if (r29.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center><img src=\"images/os.jpg\"></center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\"><center>&nbsp"+r29.getString("NAME")+"</center></td>");
    }
    st29.close();
    Statement st29b = Conn.createStatement();
    String q29b = "SELECT * FROM CMDB_SP WHERE ID='"+SPID+"' AND OSID='"+OSID+"'";
    ResultSet r29b = st29b.executeQuery(q29b);
    if (r29b.next()) {
      out.print("<td bgcolor=\"#FFFFFF\" width=\"50%\"><center>&nbsp"+r29b.getString("NAME")+"</center></td>");
      out.print("</tr>");
    }
    st29b.close();

    out.print("</table>");

    out.print("<br><strong>Service(s)</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>&nbsp</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"40%\"><center>NAME</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"40%\"><center>PORT</center></td>");
    out.print("</tr>");
    Statement st28 = Conn.createStatement();
    String q28 = "SELECT * FROM CMDB_SERVER_SERVICE WHERE SERVERID='"+ID+"'";
    ResultSet r28 = st28.executeQuery(q28);
    while (r28.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center><img src=\"images/service.jpg\"></center></td>");
      Statement st28b = Conn.createStatement();
      String q28b = "SELECT * FROM CMDB_SERVICE WHERE ID='"+r28.getString("SERVICEID")+"'";
      ResultSet r28b = st28b.executeQuery(q28b);
      if (r28b.next()) {
        out.print("<td bgcolor=\"#FFFFFF\" width=\"40%\"><center>&nbsp"+r28b.getString("NAME")+"</center></td>");
      } else {
      }
      st28b.close();
      out.print("<td bgcolor=\"#FFFFFF\" width=\"50%\"><center>&nbsp"+r28.getString("PORT")+"</center></td>");
    }
    st28.close();

    out.print("</table>");



    out.print("<br><strong>Processor(s)</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>&nbsp</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>PROC #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"50%\"><center>TYPE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>CORE #</center></td>");  
    out.print("</tr>");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_SERVER_PROC WHERE SERVERID='"+ID+"' ORDER BY PROCID";
    ResultSet r30 = st30.executeQuery(q30);
    while(r30.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center><img src=\"images/proc.jpg\"></center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r30.getString("PROCID")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"50%\"><center>&nbsp"+r30.getString("PROCTYPE")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r30.getString("PROCCORE")+"</center></td>");
      out.print("</tr>");
    }
    st30.close();
    out.print("</table>");

    out.print("<br><strong>Memory</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>&nbsp</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>MEMORY #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"50%\"><center>TYPE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>SIZE</center></td>");  
    out.print("</tr>");
    Statement st31 = Conn.createStatement();
    String q31 = "SELECT * FROM CMDB_SERVER_MEMORY WHERE SERVERID='"+ID+"' ORDER BY MEMORYID";
    ResultSet r31 = st31.executeQuery(q31);
    while(r31.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center><img src=\"images/ram.jpg\"></center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r31.getString("MEMORYID")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"50%\"><center>&nbsp"+r31.getString("MEMORYTYPE")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r31.getString("MEMORYSIZE")+"</center></td>");
      out.print("</tr>");
    }
    st31.close();
    out.print("</table>");

    out.print("<br><strong>Disk(s)</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>&nbsp</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>DISK #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"50%\"><center>TYPE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>SIZE</center></td>");  
    out.print("</tr>");
    Statement st32 = Conn.createStatement();
    String q32 = "SELECT * FROM CMDB_SERVER_DISK WHERE SERVERID='"+ID+"' ORDER BY DISKID";
    ResultSet r32 = st32.executeQuery(q32);
    while(r32.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center><img src=\"images/disk.jpg\"></center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r32.getString("DISKID")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"50%\"><center>&nbsp"+r32.getString("DISKTYPE")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r32.getString("DISKSIZE")+"</center></td>");
      out.print("</tr>");
    }
    st32.close();
    out.print("</table>");

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
    String q33 = "SELECT * FROM CMDB_SERVER_NETWORK WHERE SERVERID='"+ID+"' ORDER BY NETWORKID";
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
      String q33b = "SELECT * FROM CMDB_NETCABLE WHERE ELEMENTID='"+ID+" - "+r33.getString("NETWORKID")+"' AND ELEMENTTYPE='SERVER'";
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

    out.print("<br><strong>SAN Volume(s)</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>&nbsp</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"30%\"><center>VOLUME #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"30%\"><center>SAN</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"30%\"><center>VOLUME</center></td>");  
    out.print("</tr>");
    Statement st43 = Conn.createStatement();
    String q43 = "SELECT * FROM CMDB_SERVER_SAN WHERE SERVERID='"+ID+"' ORDER BY SERVERSANID";
    ResultSet r43 = st43.executeQuery(q43);
    while(r43.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center><img src=\"images/lv.jpg\"></center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"30%\"><center>&nbsp"+r43.getString("SERVERSANID")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"30%\"><center>&nbsp"+r43.getString("SANID")+"</center></td>");
      Statement st43b = Conn.createStatement();
      String q43b = "SELECT * FROM CMDB_SAN_VOLUME WHERE SANID='"+r43.getString("SANID")+"' AND VOLUMEID='"+r43.getString("VOLUMEID")+"'";
      ResultSet r43b = st43b.executeQuery(q43b);
      if (r43b.next()) {
        out.print("<td bgcolor=\"#FFFFFF\" width=\"30%\"><center>&nbsp"+r43b.getString("VOLUMENAME")+"</center></td>");
      } else {
        out.print("<td bgcolor=\"#FFFFFF\" width=\"30%\"><center>&nbsp</center></td>");
      }
      st43b.close();
      out.print("</tr>");
    }
    st43.close();
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
    String q35 = "SELECT * FROM CMDB_SERVER_POWER WHERE SERVERID='"+ID+"' ORDER BY POWERID";
    ResultSet r35 = st35.executeQuery(q35);
    while(r35.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center><img src=\"images/power.jpg\"></center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r35.getString("POWERID")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"30%\"><center>&nbsp"+r35.getString("POWERTYPE")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp"+r35.getString("POWERCAPACITY")+"</center></td>");
      Statement st35b = Conn.createStatement();
      String q35b = "SELECT * FROM CMDB_POWERCABLE WHERE ELEMENTID='"+ID+" | "+r35.getString("POWERID")+"' AND ELEMENTTYPE='SERVER'";
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

    out.print("<br><strong>Fiber Connection(s)</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>&nbsp</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>FIBER #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"30%\"><center>TYPE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>ON SAN</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>ON PORT</center></td>");  
    out.print("</tr>");
    Statement st36 = Conn.createStatement();
    String q36 = "SELECT * FROM CMDB_SERVER_FIBER WHERE SERVERID='"+ID+"' ORDER BY FIBERID";
    ResultSet r36 = st36.executeQuery(q36);
    while(r36.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center><img src=\"images/hba.jpg\"></center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r36.getString("FIBERID")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"30%\"><center>&nbsp"+r36.getString("FIBERTYPE")+"</center></td>");
      Statement st36b = Conn.createStatement();
      String q36b = "SELECT * FROM CMDB_FIBERCABLE WHERE ELEMENTID='"+ID+" | "+r36.getString("FIBERID")+"' AND ELEMENTTYPE='SERVER'";
      ResultSet r36b = st36b.executeQuery(q36b);
      if (r36b.next()) {
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r36b.getString("SANID")+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r36b.getString("PLUG")+"</center></td>");
      } else {
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp</center></td>");
      }
      st36b.close();
      out.print("</tr>");
    }
    st36.close();
    out.print("</table>");



%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
