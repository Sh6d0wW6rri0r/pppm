
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
  String ID = request.getParameter("ID");
  String RACKID = request.getParameter("RACKID");
  PPPMTools pt = new PPPMTools();

  if (act.equals("ADD")) {
    String CAPACITY = request.getParameter("CAPACITY");
    String DESCRIPTION = request.getParameter("DESCRIPTION");
    String NBPLUG = request.getParameter("NBPLUG");

    Statement sti2 = Conn.createStatement();
    
    Statement st10 = Conn.createStatement();
    String q10 = "SELECT * FROM INDX WHERE ID='PDU'";
    ResultSet r10 = st10.executeQuery(q10);
    r10.next();
    int idnum=r10.getInt("SEQ");
    int newidnum=idnum+1;
    st10.close();
    Statement sti10 = Conn.createStatement();
    String i10 = "UPDATE INDX SET SEQ="+newidnum+" WHERE ID='PDU'";
    sti10.executeUpdate(i10);
    sti10.close();
    
    String idfill="";
    String idtmp = ""+idnum;
    for (int j =0; j<7-idtmp.length();j++) {
      idfill=idfill+"0";
    }
    idfill=idfill+idtmp;

    String PLUGIDtmp = pt.checkStr(request.getParameter("PLUGID"));
    String PLUGID="NONE";
    if (!PLUGIDtmp.equals("NONE")) {
      PLUGID = PLUGIDtmp.substring(0,PLUGIDtmp.indexOf("-")-1);
    }

    String i2 = "INSERT INTO CMDB_PDU VALUES ('"+idfill+"','"+pt.checkStr(DESCRIPTION)+"','"+PLUGID+"','"+NBPLUG+"','"+CAPACITY+"','"+RACKID+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  }
  
  if (act.equals("MOD")) {
    String CAPACITY = request.getParameter("CAPACITY");
    String DESCRIPTION = request.getParameter("DESCRIPTION");
    String NBPLUG = request.getParameter("NBPLUG");
    String PLUGIDtmp = pt.checkStr(request.getParameter("PLUGID"));
    String PLUGID="NONE";
    if (!PLUGIDtmp.equals("NONE")) {
      PLUGID = PLUGIDtmp.substring(0,PLUGIDtmp.indexOf("-")-1);
    }
    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_PDU SET DESCRIPTION='"+pt.checkStr(DESCRIPTION)+"',CAPACITY='"+CAPACITY+"',NBPLUG='"+NBPLUG+"',PLUGID='"+PLUGID+"' WHERE RACKID='"+RACKID+"' AND ID='"+ID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }  
  if (act.equals("DELETE")) {
    Statement sti2 = Conn.createStatement();
    String i2 = "DELETE FROM CMDB_PDU WHERE RACKID='"+RACKID+"' AND ID='"+ID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }

    out.print("<center><strong><h1>PDU</h1></strong></center><hr>");
    out.print("<table><tr><td><h2><strong>PDU(s)</strong></h2></center></td><td><center><A HREF=\"pduit.jsp?TODO=ADD&RACKID="+RACKID+"\"><img border=0 src=\"icons/addsmall.png\"></center></A></td></tr></table></td>");

    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\"><center>PDU #</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>DESCRIPTION</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>POWER PLUG</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>PLUG(s)</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>CAPACITY PER PLUG</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\"><center>TOTAL CAPACITY/USED</center></td>");  
    out.print("<td background=\"images/fond_titre.jpg\"><center>DISPLAY</center></td>");  
    out.print("<td width=\"10%\"><center>&nbsp;</center></td>");
    out.print("</tr>");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_PDU WHERE RACKID='"+RACKID+"'";
    ResultSet r30 = st30.executeQuery(q30);
    while(r30.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\"><center><A HREF=\"pduit.jsp?TODO=MOD&ID="+r30.getString("ID")+"&RACKID="+RACKID+"\">"+r30.getString("ID")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("DESCRIPTION")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("PLUGID")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("NBPLUG")+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>"+r30.getString("CAPACITY")+"</center></td>");
      int nbwatt=0;
      Statement st31 = Conn.createStatement();
      String q31 = "SELECT * FROM CMDB_POWERCABLE WHERE PDUID='"+r30.getString("ID")+"'";
      ResultSet r31 = st31.executeQuery(q31);
      while(r31.next()) {
        String ELEMENTIDtmp = pt.checkStr(r31.getString("ELEMENTID"));
        String MAINID="NONE";
        String SUBID="NONE";
        if (!ELEMENTIDtmp.equals("NONE")) {
          int endfirst=ELEMENTIDtmp.indexOf("|");
          MAINID = ELEMENTIDtmp.substring(0,endfirst-1);
          SUBID = ELEMENTIDtmp.substring(endfirst+2,ELEMENTIDtmp.length());
        }
        if (r31.getString("ELEMENTTYPE").equals("SERVER")) {
          Statement st32 = Conn.createStatement();
          String q32 = "SELECT * FROM CMDB_SERVER_POWER WHERE SERVERID='"+MAINID+"' AND POWERID='"+SUBID+"'";
          ResultSet r32 = st32.executeQuery(q32);
          if(r32.next()) {
            nbwatt=nbwatt+Integer.parseInt(r32.getString("POWERCAPACITY"));
          }
          st32.close();
        }
        if (r31.getString("ELEMENTTYPE").equals("SWITCH")) {
          Statement st32 = Conn.createStatement();
          String q32 = "SELECT * FROM CMDB_SWITCH_POWER WHERE SWITCHID='"+MAINID+"' AND POWERID='"+SUBID+"'";
          ResultSet r32 = st32.executeQuery(q32);
          if(r32.next()) {
            nbwatt=nbwatt+Integer.parseInt(r32.getString("POWERCAPACITY"));
          }
          st32.close();
        }
        if (r31.getString("ELEMENTTYPE").equals("BACKUP")) {
          Statement st32 = Conn.createStatement();
          String q32 = "SELECT * FROM CMDB_BACKUP_POWER WHERE BACKUPID='"+MAINID+"' AND POWERID='"+SUBID+"'";
          ResultSet r32 = st32.executeQuery(q32);
          if(r32.next()) {
            nbwatt=nbwatt+Integer.parseInt(r32.getString("POWERCAPACITY"));
          }
          st32.close();
        }
        if (r31.getString("ELEMENTTYPE").equals("SAN")) {
          Statement st32 = Conn.createStatement();
          String q32 = "SELECT * FROM CMDB_SAN_POWER WHERE SANID='"+MAINID+"' AND POWERID='"+SUBID+"'";
          ResultSet r32 = st32.executeQuery(q32);
          if(r32.next()) {
            nbwatt=nbwatt+Integer.parseInt(r32.getString("POWERCAPACITY"));
          }
          st32.close();
        }
        if (r31.getString("ELEMENTTYPE").equals("OTHER")) {
          Statement st32 = Conn.createStatement();
          String q32 = "SELECT * FROM CMDB_OTHER_POWER WHERE OTHERID='"+MAINID+"' AND POWERID='"+SUBID+"'";
          ResultSet r32 = st32.executeQuery(q32);
          if(r32.next()) {
            nbwatt=nbwatt+Integer.parseInt(r32.getString("POWERCAPACITY"));
          }
          st32.close();
        }

      }
      st31.close();
      int totalavail = Integer.parseInt(r30.getString("NBPLUG")) * Integer.parseInt(r30.getString("CAPACITY"));
      out.print("<td bgcolor=\"#FFFFFF\"><center>"+totalavail+" / "+nbwatt+"</center></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp<A HREF=\"pdudisp.jsp?TODO=MOD&ID="+r30.getString("ID")+"&RACKID="+RACKID+"\">Display</center></A></td>");
      out.print("<td><center><A HREF=\"deletepdu.jsp?TODO=MOD&ID="+r30.getString("ID")+"&RACKID="+RACKID+"\"><img border=0 src=\"icons/deletesmall.png\" height=15></center></A></td>");
      out.print("</tr>");
    }
    st30.close();
    out.print("</table>");
    out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
   Conn.close();
}
%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>

