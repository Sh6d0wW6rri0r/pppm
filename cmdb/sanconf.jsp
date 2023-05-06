
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


<body>

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
  String MAILSERVER = (String)session.getAttribute("MAILSERVER");
  String THISSERVER = (String)session.getAttribute("THISSERVER");
  String ID = request.getParameter("ID");
  PPPMTools pt = new PPPMTools();
  if (act.equals("NEWDISK")) {
    String DISKTYPE = pt.checkStr(request.getParameter("DISKTYPE"));
    String DISKSIZE = pt.checkStr(request.getParameter("DISKSIZE"));
    String idfill="0";
    Statement st3 = Conn.createStatement();
    String q3 = "SELECT * FROM CMDB_SAN_DISK WHERE SANID='"+ID+"' ORDER BY DISKID DESC";
    ResultSet r3 = st3.executeQuery(q3);
    if (r3.next()) {
      int idf = Integer.parseInt(idfill);
      idf++;
      idfill=""+idf;
    }
    st3.close();  
    Statement sti2 = Conn.createStatement();
    String i2 = "INSERT INTO CMDB_SAN_DISK VALUES('"+ID+"','"+DISKTYPE+"','"+DISKSIZE+"','"+idfill+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  } 
  if (act.equals("MODDISK")) {
    String DISKID = request.getParameter("DISKID");
    String DISKTYPE = pt.checkStr(request.getParameter("DISKTYPE"));
    String DISKSIZE = pt.checkStr(request.getParameter("DISKSIZE"));
    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_SAN_DISK SET DISKTYPE='"+DISKTYPE+"',DISKSIZE='"+DISKSIZE+"' WHERE SANID='"+ID+"' AND DISKID='"+DISKID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }
  if (act.equals("NEWVOLUME")) {
    String VOLUMENAME = pt.checkStr(request.getParameter("VOLUMENAME"));
    String VOLUMESIZE = pt.checkStr(request.getParameter("VOLUMESIZE"));
    String idfill="0";
    Statement st3 = Conn.createStatement();
    String q3 = "SELECT * FROM CMDB_SAN_VOLUME WHERE SANID='"+ID+"' ORDER BY VOLUMEID DESC";
    ResultSet r3 = st3.executeQuery(q3);
    if (r3.next()) {
      int idf = Integer.parseInt(idfill);
      idf++;
      idfill=""+idf;
    }
    st3.close();  
    Statement sti2 = Conn.createStatement();
    String i2 = "INSERT INTO CMDB_SAN_VOLUME VALUES('"+ID+"','"+VOLUMENAME+"','"+VOLUMESIZE+"','"+idfill+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  } 
  if (act.equals("MODVOLUME")) {
    String VOLUMEID = request.getParameter("VOLUMEID");
    String VOLUMENAME = pt.checkStr(request.getParameter("VOLUMENAME"));
    String VOLUMESIZE = pt.checkStr(request.getParameter("VOLUMESIZE"));
    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_SAN_VOLUME SET VOLUMENAME='"+VOLUMENAME+"',VOLUMESIZE='"+VOLUMESIZE+"' WHERE SANID='"+ID+"' AND VOLUMEID='"+VOLUMEID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }
  if (act.equals("DELETEVOLUME")) {
    String VOLUMEID = request.getParameter("VOLUMEID");
    Statement sti2 = Conn.createStatement();
    String i2 = "DELETE FROM CMDB_SAN_VOLUME WHERE VOLUMEID='"+VOLUMEID+"' AND SANID='"+ID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }
  if (act.equals("DELETEDISK")) {
    String DISKID = request.getParameter("DISKID");
    Statement sti2 = Conn.createStatement();
    String i2 = "DELETE FROM CMDB_SAN_DISK WHERE DISKID='"+DISKID+"' AND SANID='"+ID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }
  out.print("<center><strong><h1>San configuration</h1></strong></center><hr>");
  out.print("<table><tr><td><h2><strong>Volume(s)</strong></h2></center></td><td><center><A HREF=\"sanvolumeit.jsp?TODO=NEW&ID="+ID+"\"><img border=0 src=\"icons/addsmall.png\"></center></A></td></tr></table></td>");
  out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
  out.print("<tr>");
  out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>VOLUME NAME</center></td>");
  out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>SIZE</center></td>");  
  out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
  out.print("</tr>");
  Statement st31 = Conn.createStatement();
  String q31 = "SELECT * FROM CMDB_SAN_VOLUME WHERE SANID='"+ID+"' ORDER BY VOLUMENAME";
  ResultSet r31 = st31.executeQuery(q31);
  while(r31.next()) {
    out.print("<tr>");
    out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp<A HREF=\"sanvolumeit.jsp?TODO=MOD&ID="+r31.getString("SANID")+"&VOLUMEID="+r31.getString("VOLUMEID")+"\">"+r31.getString("VOLUMENAME")+"</center></A></td>");
    out.print("<td bgcolor=\"#FFFFFF\" width=\"60%\"><center>&nbsp"+r31.getString("VOLUMESIZE")+"</center></td>");
    out.print("<td><center><A HREF=\"deletesanvolume.jsp?TODO=MOD&ID="+r31.getString("SANID")+"&VOLUMEID="+r31.getString("VOLUMEID")+"\"><img border=0 src=\"icons/deletesmall.png\" height=15></center></A></td>");
    out.print("</tr>");
  }
  st31.close();
  out.print("</table>");
  out.print("<table><tr><td><h2><strong>Disk(s)</strong></h2></center></td><td><center><A HREF=\"sandiskit.jsp?TODO=NEW&ID="+ID+"\"><img border=0 src=\"icons/addsmall.png\"></center></A></td></tr></table></td>");
  out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
  out.print("<tr>");
  out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>DISK #</center></td>");
  out.print("<td background=\"images/fond_titre.jpg\" width=\"60%\"><center>TYPE</center></td>");
  out.print("<td background=\"images/fond_titre.jpg\" width=\"20%\"><center>SIZE</center></td>");  
  out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
  out.print("</tr>");
  Statement st32 = Conn.createStatement();
  String q32 = "SELECT * FROM CMDB_SAN_DISK WHERE SANID='"+ID+"' ORDER BY DISKID";
  ResultSet r32 = st32.executeQuery(q32);
  while(r32.next()) {
    out.print("<tr>");
    out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp<A HREF=\"sandiskit.jsp?TODO=MOD&ID="+r32.getString("SANID")+"&DISKID="+r32.getString("DISKID")+"\">"+r32.getString("DISKID")+"</center></A></td>");
    out.print("<td bgcolor=\"#FFFFFF\" width=\"60%\"><center>&nbsp"+r32.getString("DISKTYPE")+"</center></td>");
    out.print("<td bgcolor=\"#FFFFFF\" width=\"20%\"><center>&nbsp"+r32.getString("DISKSIZE")+"</center></td>");
    out.print("<td><center><A HREF=\"deletesandisk.jsp?TODO=MOD&ID="+r32.getString("SANID")+"&DISKID="+r32.getString("DISKID")+"\"><img border=0 src=\"icons/deletesmall.png\" height=15></center></A></td>");
    out.print("</tr>");
  }
  st32.close();
  out.print("</table>");
  out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
  Conn.close();
}


%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
