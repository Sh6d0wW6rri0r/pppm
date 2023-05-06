
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


  if (act.equals("NEWPROC")) {
    String PROCTYPE = pt.checkStr(request.getParameter("PROCTYPE"));
    String PROCCORE = pt.checkStr(request.getParameter("PROCCORE"));
    String idfill="0";
    Statement st3 = Conn.createStatement();
    String q3 = "SELECT * FROM CMDB_SERVER_PROC WHERE SERVERID='"+ID+"' ORDER BY PROCID DESC";
    ResultSet r3 = st3.executeQuery(q3);
    if (r3.next()) {
      int idf = Integer.parseInt(r3.getString("PROCID"));
      idf++;
      idfill=""+idf;
    }
    st3.close();  
    Statement sti2 = Conn.createStatement();
    String i2 = "INSERT INTO CMDB_SERVER_PROC VALUES('"+ID+"','"+PROCTYPE+"','"+PROCCORE+"','"+idfill+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  } 
  if (act.equals("NEWMEMORY")) {
    String MEMORYTYPE = pt.checkStr(request.getParameter("MEMORYTYPE"));
    String MEMORYSIZE = pt.checkStr(request.getParameter("MEMORYSIZE"));
    String idfill="0";
    Statement st3 = Conn.createStatement();
    String q3 = "SELECT * FROM CMDB_SERVER_MEMORY WHERE SERVERID='"+ID+"' ORDER BY MEMORYID DESC";
    ResultSet r3 = st3.executeQuery(q3);
    if (r3.next()) {
      int idf = Integer.parseInt(r3.getString("MEMORYID"));
      idf++;
      idfill=""+idf;
    }
    st3.close();  
    Statement sti2 = Conn.createStatement();
    String i2 = "INSERT INTO CMDB_SERVER_MEMORY VALUES('"+ID+"','"+MEMORYTYPE+"','"+MEMORYSIZE+"','"+idfill+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  } 
  if (act.equals("NEWDISK")) {
    String DISKTYPE = pt.checkStr(request.getParameter("DISKTYPE"));
    String DISKSIZE = pt.checkStr(request.getParameter("DISKSIZE"));
    String idfill="0";
    Statement st3 = Conn.createStatement();
    String q3 = "SELECT * FROM CMDB_SERVER_DISK WHERE SERVERID='"+ID+"' ORDER BY DISKID DESC";
    ResultSet r3 = st3.executeQuery(q3);
    if (r3.next()) {
      int idf = Integer.parseInt(r3.getString("DISKID"));
      idf++;
      idfill=""+idf;
    }
    st3.close();  
    Statement sti2 = Conn.createStatement();
    String i2 = "INSERT INTO CMDB_SERVER_DISK VALUES('"+ID+"','"+DISKTYPE+"','"+DISKSIZE+"','"+idfill+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  } 

  if (act.equals("NEWNETWORK")) {
    String NETWORKTYPE = pt.checkStr(request.getParameter("NETWORKTYPE"));
    String NETWORKSPEED = pt.checkStr(request.getParameter("NETWORKSPEED"));
    String NETWORKADDRESS = pt.checkStr(request.getParameter("NETWORKADDRESS"));
    String NETWORKMASK = pt.checkStr(request.getParameter("NETWORKMASK"));
    String NETWORKGATEWAY = pt.checkStr(request.getParameter("NETWORKGATEWAY"));
    String idfill="0";
    Statement st3 = Conn.createStatement();
    String q3 = "SELECT * FROM CMDB_SERVER_NETWORK WHERE SERVERID='"+ID+"' ORDER BY NETWORKID DESC";
    ResultSet r3 = st3.executeQuery(q3);
    if (r3.next()) {
      int idf = Integer.parseInt(r3.getString("NETWORKID"));
      idf++;
      idfill=""+idf;
    }
    st3.close();  
    Statement sti2 = Conn.createStatement();
    String i2 = "INSERT INTO CMDB_SERVER_NETWORK VALUES('"+ID+"','"+NETWORKTYPE+"','"+NETWORKSPEED+"','"+NETWORKADDRESS+"','"+NETWORKMASK+"','"+NETWORKGATEWAY+"','"+idfill+"')";
    sti2.executeUpdate(i2);
    sti2.close();
    String SWITCHID = pt.checkStr(request.getParameter("SWITCHID"));
    String PLUG = pt.checkStr(request.getParameter("PLUG"));
    if (!SWITCHID.equals("NONE")) {
      Statement sti3 = Conn.createStatement();
      String i3 = "INSERT INTO CMDB_NETCABLE VALUES('"+ID+" - "+idfill+"','SERVER','"+SWITCHID+"','"+PLUG+"')";
      sti3.executeUpdate(i3);
      sti3.close();
    }
  } 

  if (act.equals("NEWSAN")) {
    String SANVOLUME = pt.checkStr(request.getParameter("SANVOLUME"));
    String idfill="0";
    Statement st3 = Conn.createStatement();
    String q3 = "SELECT * FROM CMDB_SERVER_SAN WHERE SERVERID='"+ID+"' ORDER BY SERVERSANID DESC";
    ResultSet r3 = st3.executeQuery(q3);
    if (r3.next()) {
      int idf = Integer.parseInt(r3.getString("SERVERSANID"));
      idf++;
      idfill=""+idf;
    }
    st3.close();  
    String idsan = SANVOLUME.substring(0,SANVOLUME.indexOf("/")-1);
    String REST = SANVOLUME.substring(SANVOLUME.indexOf("/")+2,SANVOLUME.length());
    String idvol = REST.substring(0,REST.indexOf("/")-1);

    Statement sti2 = Conn.createStatement();
    String i2 = "INSERT INTO CMDB_SERVER_SAN VALUES('"+ID+"','"+idsan+"','"+idvol+"','"+idfill+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  } 


  if (act.equals("NEWPOWER")) {
    String POWERTYPE = pt.checkStr(request.getParameter("POWERTYPE"));
    String POWERCAPACITY = pt.checkStr(request.getParameter("POWERCAPACITY"));
    String idfill="0";
    Statement st3 = Conn.createStatement();
    String q3 = "SELECT * FROM CMDB_SERVER_POWER WHERE SERVERID='"+ID+"' ORDER BY POWERID DESC";
    ResultSet r3 = st3.executeQuery(q3);
    if (r3.next()) {
      int idf = Integer.parseInt(r3.getString("POWERID"));
      idf++;
      idfill=""+idf;
    }
    st3.close();  
    Statement sti2 = Conn.createStatement();
    String i2 = "INSERT INTO CMDB_SERVER_POWER VALUES('"+ID+"','"+POWERTYPE+"','"+POWERCAPACITY+"','"+idfill+"')";
    sti2.executeUpdate(i2);
    sti2.close();
    String PDUIDtmp=request.getParameter("PDUID");
    String PDUID="NONE";
    if (!PDUIDtmp.equals("NONE")) {
      PDUID = PDUIDtmp.substring(0,PDUIDtmp.indexOf("|")-1);
    }
    String PLUG = pt.checkStr(request.getParameter("PLUG"));
    if (!PDUID.equals("NONE")) {
      Statement sti3 = Conn.createStatement();
      String i3 = "INSERT INTO CMDB_POWERCABLE VALUES('"+ID+" | "+idfill+"','SERVER','"+PDUID+"','"+PLUG+"')";
      sti3.executeUpdate(i3);
      sti3.close();
    }
  } 

  if (act.equals("NEWFIBER")) {
    String FIBERTYPE = pt.checkStr(request.getParameter("FIBERTYPE"));
    String idfill="0";
    Statement st3 = Conn.createStatement();
    String q3 = "SELECT * FROM CMDB_SERVER_FIBER WHERE SERVERID='"+ID+"' ORDER BY FIBERID DESC";
    ResultSet r3 = st3.executeQuery(q3);
    if (r3.next()) {
      int idf = Integer.parseInt(r3.getString("FIBERID"));
      idf++;
      idfill=""+idf;
    }
    st3.close();  
    Statement sti2 = Conn.createStatement();
    String i2 = "INSERT INTO CMDB_SERVER_FIBER VALUES('"+ID+"','"+FIBERTYPE+"','"+idfill+"')";
    sti2.executeUpdate(i2);
    sti2.close();
    String SANID = pt.checkStr(request.getParameter("SANID"));
    String PLUG = pt.checkStr(request.getParameter("PLUG"));
    if (!SANID.equals("NONE")) {
      Statement sti3 = Conn.createStatement();
      String i3 = "INSERT INTO CMDB_FIBERCABLE VALUES('"+ID+" - "+idfill+"','SERVER','"+SANID+"','"+PLUG+"')";
      sti3.executeUpdate(i3);
      sti3.close();
    }
  } 


  if (act.equals("MODPROC")) {
    String PROCID = request.getParameter("PROCID");
    String PROCTYPE = pt.checkStr(request.getParameter("PROCTYPE"));
    String PROCCORE = pt.checkStr(request.getParameter("PROCCORE"));
    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_SERVER_PROC SET PROCTYPE='"+PROCTYPE+"',PROCCORE='"+PROCCORE+"' WHERE SERVERID='"+ID+"' AND PROCID='"+PROCID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }

  if (act.equals("MODMEMORY")) {
    String MEMORYID = request.getParameter("MEMORYID");
    String MEMORYTYPE = pt.checkStr(request.getParameter("MEMORYTYPE"));
    String MEMORYSIZE = pt.checkStr(request.getParameter("MEMORYSIZE"));
    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_SERVER_MEMORY SET MEMORYTYPE='"+MEMORYTYPE+"',MEMORYSIZE='"+MEMORYSIZE+"' WHERE SERVERID='"+ID+"' AND MEMORYID='"+MEMORYID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }

  if (act.equals("MODDISK")) {
    String DISKID = request.getParameter("DISKID");
    String DISKTYPE = pt.checkStr(request.getParameter("DISKTYPE"));
    String DISKSIZE = pt.checkStr(request.getParameter("DISKSIZE"));
    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_SERVER_DISK SET DISKTYPE='"+DISKTYPE+"',DISKSIZE='"+DISKSIZE+"' WHERE SERVERID='"+ID+"' AND DISKID='"+DISKID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }

  if (act.equals("MODNETWORK")) {
    String NETWORKID = request.getParameter("NETWORKID");
    String NETWORKTYPE = pt.checkStr(request.getParameter("NETWORKTYPE"));
    String NETWORKSPEED = pt.checkStr(request.getParameter("NETWORKSPEED"));
    String NETWORKADDRESS = pt.checkStr(request.getParameter("NETWORKADDRESS"));
    String NETWORKMASK = pt.checkStr(request.getParameter("NETWORKMASK"));
    String NETWORKGATEWAY = pt.checkStr(request.getParameter("NETWORKGATEWAY"));
    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_SERVER_NETWORK SET NETWORKTYPE='"+NETWORKTYPE+"',NETWORKSPEED='"+NETWORKSPEED+"',NETWORKADDRESS='"+NETWORKADDRESS+"',NETWORKMASK='"+NETWORKMASK+"',NETWORKGATEWAY='"+NETWORKGATEWAY+"' WHERE SERVERID='"+ID+"' AND NETWORKID='"+NETWORKID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
    String SWITCHID = pt.checkStr(request.getParameter("SWITCHID"));
    String PLUG = pt.checkStr(request.getParameter("PLUG"));
    if (!SWITCHID.equals("NONE")) {
      Statement st50 = Conn.createStatement();
      String q50 = "SELECT * FROM CMDB_NETCABLE WHERE ELEMENTID='"+ID+" - "+NETWORKID+"' AND ELEMENTTYPE='SERVER'";
      ResultSet r50 = st50.executeQuery(q50);
      if (r50.next()) {
        Statement sti3 = Conn.createStatement();
        String i3 = "UPDATE CMDB_NETCABLE SET SWITCHID='"+SWITCHID+"',PLUG='"+PLUG+"' WHERE ELEMENTID='"+ID+" - "+NETWORKID+"' AND ELEMENTTYPE='SERVER'";
        sti3.executeUpdate(i3);
        sti3.close();
      } else {
        Statement sti3 = Conn.createStatement();
        String i3 = "INSERT INTO CMDB_NETCABLE VALUES('"+ID+" - "+NETWORKID+"','SERVER','"+SWITCHID+"','"+PLUG+"')";
        sti3.executeUpdate(i3);
        sti3.close();
      }
    }
  }


  if (act.equals("MODSAN")) {
    String SERVERSANID = request.getParameter("SERVERSANID");
    String SANVOLUME = pt.checkStr(request.getParameter("SANVOLUME"));

    String idsan = SANVOLUME.substring(0,SANVOLUME.indexOf("/")-1);
    String REST = SANVOLUME.substring(SANVOLUME.indexOf("/")+2,SANVOLUME.length());
    String idvol = REST.substring(0,REST.indexOf("/")-1);

    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_SERVER_SAN SET SANID='"+idsan+"',VOLUMEID='"+idvol+"' WHERE SERVERID='"+ID+"' AND SERVERSANID='"+SERVERSANID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }

  if (act.equals("MODPOWER")) {
    String POWERID = request.getParameter("POWERID");
    String POWERTYPE = pt.checkStr(request.getParameter("POWERTYPE"));
    String POWERCAPACITY = pt.checkStr(request.getParameter("POWERCAPACITY"));
    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_SERVER_POWER SET POWERTYPE='"+POWERTYPE+"',POWERCAPACITY='"+POWERCAPACITY+"' WHERE SERVERID='"+ID+"' AND POWERID='"+POWERID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
    String PDUIDtmp=request.getParameter("PDUID");
    String PDUID="NONE";
    if (!PDUIDtmp.equals("NONE")) {
      PDUID = PDUIDtmp.substring(0,PDUIDtmp.indexOf("|")-1);
    }
    String PLUG = pt.checkStr(request.getParameter("PLUG"));
    if (!PDUID.equals("NONE")) {
      Statement st50 = Conn.createStatement();
      String q50 = "SELECT * FROM CMDB_POWERCABLE WHERE ELEMENTID='"+ID+" | "+POWERID+"' AND ELEMENTTYPE='SERVER'";
      ResultSet r50 = st50.executeQuery(q50);
      if (r50.next()) {
        Statement sti3 = Conn.createStatement();
        String i3 = "UPDATE CMDB_POWERCABLE SET PDUID='"+PDUID+"',PLUG='"+PLUG+"' WHERE ELEMENTID='"+ID+" | "+POWERID+"' AND ELEMENTTYPE='SERVER'";
        sti3.executeUpdate(i3);
        sti3.close();
      } else {
        Statement sti3 = Conn.createStatement();
        String i3 = "INSERT INTO CMDB_POWERCABLE VALUES('"+ID+" | "+POWERID+"','SERVER','"+PDUID+"','"+PLUG+"')";
        sti3.executeUpdate(i3);
        sti3.close();
      }
    }
  }

  if (act.equals("MODFIBER")) {
    String FIBERID = request.getParameter("FIBERID");
    String FIBERTYPE = pt.checkStr(request.getParameter("FIBERTYPE"));
    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_SERVER_FIBER SET FIBERTYPE='"+FIBERTYPE+"' WHERE SERVERID='"+ID+"' AND FIBERID='"+FIBERID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
    String SANID = pt.checkStr(request.getParameter("SANID"));
    String PLUG = pt.checkStr(request.getParameter("PLUG"));
    if (!SANID.equals("NONE")) {
      Statement st50 = Conn.createStatement();
      String q50 = "SELECT * FROM CMDB_FIBERCABLE WHERE ELEMENTID='"+ID+" - "+FIBERID+"' AND ELEMENTTYPE='SERVER'";
      ResultSet r50 = st50.executeQuery(q50);
      if (r50.next()) {
        Statement sti3 = Conn.createStatement();
        String i3 = "UPDATE CMDB_FIBERCABLE SET SANID='"+SANID+"',PLUG='"+PLUG+"' WHERE ELEMENTID='"+ID+" - "+FIBERID+"' AND ELEMENTTYPE='SERVER'";
        sti3.executeUpdate(i3);
        sti3.close();
      } else {
        Statement sti3 = Conn.createStatement();
        String i3 = "INSERT INTO CMDB_FIBERCABLE VALUES('"+ID+" - "+FIBERID+"','SERVER','"+SANID+"','"+PLUG+"')";
        sti3.executeUpdate(i3);
        sti3.close();
      }
    }
  }

    out.print("<center><strong><h1>Server Configuration</h1></strong></center><hr>");


    out.print("<strong>Processor(s)</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>PROC #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"60%\"><center>TYPE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>CORE #</center></td>");  
    out.print("</tr>");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_SERVER_PROC WHERE SERVERID='"+ID+"' ORDER BY PROCID";
    ResultSet r30 = st30.executeQuery(q30);
    while(r30.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp<A HREF=\"serverprocit.jsp?TODO=MOD&ID="+r30.getString("SERVERID")+"&PROCID="+r30.getString("PROCID")+"\">"+r30.getString("PROCID")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"60%\"><center>&nbsp"+r30.getString("PROCTYPE")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r30.getString("PROCCORE")+"</center></td>");
      out.print("</tr>");
    }
    st30.close();
    out.print("</table>");
    out.print("</form>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"serverprocit.jsp?TODO=NEW&ID="+ID+"\" target=\"appliFrame\">");
    out.print("<center><input type=\"submit\" name=\"Save\" value=\"Add\"></center>");
    out.print("</form>");

    out.print("<strong>Memory</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>MEMORY #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"60%\"><center>TYPE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>SIZE</center></td>");  
    out.print("</tr>");
    Statement st31 = Conn.createStatement();
    String q31 = "SELECT * FROM CMDB_SERVER_MEMORY WHERE SERVERID='"+ID+"' ORDER BY MEMORYID";
    ResultSet r31 = st31.executeQuery(q31);
    while(r31.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp<A HREF=\"servermemoryit.jsp?TODO=MOD&ID="+r31.getString("SERVERID")+"&MEMORYID="+r31.getString("MEMORYID")+"\">"+r31.getString("MEMORYID")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"60%\"><center>&nbsp"+r31.getString("MEMORYTYPE")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r31.getString("MEMORYSIZE")+"</center></td>");
      out.print("</tr>");
    }
    st31.close();
    out.print("</table>");
    out.print("</form>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"servermemoryit.jsp?TODO=NEW&ID="+ID+"\" target=\"appliFrame\">");
    out.print("<center><input type=\"submit\" name=\"Save\" value=\"Add\"></center>");
    out.print("</form>");

    out.print("<strong>Disk(s)</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>DISK #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"60%\"><center>TYPE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>SIZE</center></td>");  
    out.print("</tr>");
    Statement st32 = Conn.createStatement();
    String q32 = "SELECT * FROM CMDB_SERVER_DISK WHERE SERVERID='"+ID+"' ORDER BY DISKID";
    ResultSet r32 = st32.executeQuery(q32);
    while(r32.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp<A HREF=\"serverdiskit.jsp?TODO=MOD&ID="+r32.getString("SERVERID")+"&DISKID="+r32.getString("DISKID")+"\">"+r32.getString("DISKID")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"60%\"><center>&nbsp"+r32.getString("DISKTYPE")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r32.getString("DISKSIZE")+"</center></td>");
      out.print("</tr>");
    }
    st32.close();
    out.print("</table>");
    out.print("</form>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"serverdiskit.jsp?TODO=NEW&ID="+ID+"\" target=\"appliFrame\">");
    out.print("<center><input type=\"submit\" name=\"Save\" value=\"Add\"></center>");
    out.print("</form>");

    out.print("<strong>Network Interface(s)</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>NET #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>TYPE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>SPEED</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>ADDRESS</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>MASK</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>GATEWAY</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>ON SWITCH</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>ON PORT</center></td>");  
    out.print("</tr>");
    Statement st33 = Conn.createStatement();
    String q33 = "SELECT * FROM CMDB_SERVER_NETWORK WHERE SERVERID='"+ID+"' ORDER BY NETWORKID";
    ResultSet r33 = st33.executeQuery(q33);
    while(r33.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp<A HREF=\"servernetworkit.jsp?TODO=MOD&ID="+r33.getString("SERVERID")+"&NETWORKID="+r33.getString("NETWORKID")+"\">"+r33.getString("NETWORKID")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r33.getString("NETWORKTYPE")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp"+r33.getString("NETWORKSPEED")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r33.getString("NETWORKADDRESS")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r33.getString("NETWORKMASK")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r33.getString("NETWORKGATEWAY")+"</center></td>");
      Statement st33b = Conn.createStatement();
      String q33b = "SELECT * FROM CMDB_NETCABLE WHERE ELEMENTID='"+ID+" - "+r33.getString("NETWORKID")+"' AND ELEMENTTYPE='SERVER'";
      ResultSet r33b = st33b.executeQuery(q33b);
      if (r33b.next()) {
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r33b.getString("SWITCHID")+"</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r33b.getString("PLUG")+"</center></td>");
      } else {
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp</center></td>");
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp</center></td>");
      }
      st33b.close();
      out.print("</tr>");
    }
    st33.close();
    out.print("</table>");
    out.print("</form>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"servernetworkit.jsp?TODO=NEW&ID="+ID+"\" target=\"appliFrame\">");
    out.print("<center><input type=\"submit\" name=\"Save\" value=\"Add\"></center>");
    out.print("</form>");

    out.print("<strong>SAN Volume(s)</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>VOLUME #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>SAN</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>VOLUME</center></td>");  
    out.print("</tr>");
    Statement st43 = Conn.createStatement();
    String q43 = "SELECT * FROM CMDB_SERVER_SAN WHERE SERVERID='"+ID+"' ORDER BY SERVERSANID";
    ResultSet r43 = st43.executeQuery(q43);
    while(r43.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp<A HREF=\"serversanit.jsp?TODO=MOD&ID="+r43.getString("SERVERID")+"&SERVERSANID="+r43.getString("SERVERSANID")+"\">"+r43.getString("SERVERSANID")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r43.getString("SANID")+"</center></td>");
      Statement st43b = Conn.createStatement();
      String q43b = "SELECT * FROM CMDB_SAN_VOLUME WHERE SANID='"+r43.getString("SANID")+"' AND VOLUMEID='"+r43.getString("VOLUMEID")+"'";
      ResultSet r43b = st43b.executeQuery(q43b);
      if (r43b.next()) {
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r43b.getString("VOLUMENAME")+"</center></td>");
      } else {
        out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp</center></td>");
      }
      st43b.close();
      out.print("</tr>");
    }
    st43.close();
    out.print("</table>");
    out.print("</form>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"serversanit.jsp?TODO=NEW&ID="+ID+"\" target=\"appliFrame\">");
    out.print("<center><input type=\"submit\" name=\"Save\" value=\"Add\"></center>");
    out.print("</form>");

    out.print("<strong>Power Connection(s)</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>POWER #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>TYPE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>CAPACITY</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>ON PDU</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>ON PORT</center></td>");  
    out.print("</tr>");
    Statement st35 = Conn.createStatement();
    String q35 = "SELECT * FROM CMDB_SERVER_POWER WHERE SERVERID='"+ID+"' ORDER BY POWERID";
    ResultSet r35 = st35.executeQuery(q35);
    while(r35.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp<A HREF=\"serverpowerit.jsp?TODO=MOD&ID="+r35.getString("SERVERID")+"&POWERID="+r35.getString("POWERID")+"\">"+r35.getString("POWERID")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r35.getString("POWERTYPE")+"</center></td>");
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
    out.print("</form>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"serverpowerit.jsp?TODO=NEW&ID="+ID+"\" target=\"appliFrame\">");
    out.print("<center><input type=\"submit\" name=\"Save\" value=\"Add\"></center>");
    out.print("</form>");

    out.print("<strong>Fiber Connection(s)</Strong>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>FIBER #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>TYPE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>ON SAN</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>ON PORT</center></td>");  
    out.print("</tr>");
    Statement st36 = Conn.createStatement();
    String q36 = "SELECT * FROM CMDB_SERVER_FIBER WHERE SERVERID='"+ID+"' ORDER BY FIBERID";
    ResultSet r36 = st36.executeQuery(q36);
    while(r36.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp<A HREF=\"serverfiberit.jsp?TODO=MOD&ID="+r36.getString("SERVERID")+"&FIBERID="+r36.getString("FIBERID")+"\">"+r36.getString("FIBERID")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r36.getString("FIBERTYPE")+"</center></td>");
      Statement st36b = Conn.createStatement();
      String q36b = "SELECT * FROM CMDB_FIBERCABLE WHERE ELEMENTID='"+ID+" - "+r36.getString("FIBERID")+"' AND ELEMENTTYPE='SERVER'";
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
    out.print("</form>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"serverfiberit.jsp?TODO=NEW&ID="+ID+"\" target=\"appliFrame\">");
    out.print("<center><input type=\"submit\" name=\"Save\" value=\"Add\"></center>");
    out.print("</form>");



%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
