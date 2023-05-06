
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
  String POWERID = request.getParameter("POWERID");
  PPPMTools pt = new PPPMTools();

  if (act.equals("NEWPOWER")) {
    String POWERTYPE = pt.checkStr(request.getParameter("POWERTYPE"));
    String POWERCAPACITY = pt.checkStr(request.getParameter("POWERCAPACITY"));
    String idfill="0";
    Statement st3 = Conn.createStatement();
    String q3 = "SELECT * FROM CMDB_BACKUP_POWER WHERE BACKUPID='"+ID+"' ORDER BY POWERID DESC";
    ResultSet r3 = st3.executeQuery(q3);
    if (r3.next()) {
      int idf = Integer.parseInt(r3.getString("POWERID"));
      idf++;
      idfill=""+idf;
    }
    st3.close();  
    Statement sti2 = Conn.createStatement();
    String i2 = "INSERT INTO CMDB_BACKUP_POWER VALUES('"+ID+"','"+POWERTYPE+"','"+POWERCAPACITY+"','"+idfill+"')";
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
      String i3 = "INSERT INTO CMDB_POWERCABLE VALUES('"+ID+" | "+idfill+"','BACKUP','"+PDUID+"','"+PLUG+"')";
      sti3.executeUpdate(i3);
      sti3.close();
    }
  }
  
  if (act.equals("MODPOWER")) {
    String POWERTYPE = pt.checkStr(request.getParameter("POWERTYPE"));
    String POWERCAPACITY = pt.checkStr(request.getParameter("POWERCAPACITY"));
    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_BACKUP_POWER SET POWERTYPE='"+POWERTYPE+"',POWERCAPACITY='"+POWERCAPACITY+"' WHERE BACKUPID='"+ID+"' AND POWERID='"+POWERID+"'";
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
      String q50 = "SELECT * FROM CMDB_POWERCABLE WHERE ELEMENTID='"+ID+" | "+POWERID+"' AND ELEMENTTYPE='BACKUP'";
      ResultSet r50 = st50.executeQuery(q50);
      if (r50.next()) {
        Statement sti3 = Conn.createStatement();
        String i3 = "UPDATE CMDB_POWERCABLE SET PDUID='"+PDUID+"',PLUG='"+PLUG+"' WHERE ELEMENTID='"+ID+" | "+POWERID+"' AND ELEMENTTYPE='BACKUP'";
        sti3.executeUpdate(i3);
        sti3.close();
      } else {
        Statement sti3 = Conn.createStatement();
        String i3 = "INSERT INTO CMDB_POWERCABLE VALUES('"+ID+" | "+POWERID+"','BACKUP','"+PDUID+"','"+PLUG+"')";
        sti3.executeUpdate(i3);
        sti3.close();
      }
    }
  }

    out.print("<center><strong><h1>Power adapter(s)</h1></strong></center><hr>");
    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>POWER #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>TYPE</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\" width=\"10%\"><center>CAPACITY</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>ON PDU</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>ON PORT</center></td>");  
    out.print("</tr>");
    Statement st35 = Conn.createStatement();
    String q35 = "SELECT * FROM CMDB_BACKUP_POWER WHERE BACKUPID='"+ID+"' ORDER BY POWERID";
    ResultSet r35 = st35.executeQuery(q35);
    while(r35.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp<A HREF=\"backuppowerit.jsp?TODO=MOD&ID="+r35.getString("BACKUPID")+"&POWERID="+r35.getString("POWERID")+"\">"+r35.getString("POWERID")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r35.getString("POWERTYPE")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\" width=\"10%\"><center>&nbsp"+r35.getString("POWERCAPACITY")+"</center></td>");
      Statement st35b = Conn.createStatement();
      String q35b = "SELECT * FROM CMDB_POWERCABLE WHERE ELEMENTID='"+ID+" | "+r35.getString("POWERID")+"' AND ELEMENTTYPE='BACKUP'";
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
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"backuppowerit.jsp?TODO=NEW&ID="+ID+"\" target=\"appliFrame\">");
    out.print("<center><input type=\"submit\" name=\"Save\" value=\"Add\"></center>");
    out.print("</form>");
%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>

