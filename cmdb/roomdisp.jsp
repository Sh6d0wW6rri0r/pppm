
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
  String DESCRIPTION="";
  String ROOMID="";
  String NBU="";

  out.print("<center><strong><h1>Room "+ID+"</h1></strong></center><hr>");
  out.print("<table><tr valign=bottom>");
  Statement st30 = Conn.createStatement();
  String q30 = "SELECT * FROM CMDB_RACK WHERE ROOMID='"+ID+"'";
  ResultSet r30 = st30.executeQuery(q30);
  while (r30.next()) {
    out.print("<td>");
    DESCRIPTION=r30.getString("DESCRIPTION");
    ROOMID=r30.getString("ROOMID");
    NBU=r30.getString("NBU");
    out.print("<center><table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
    out.print("<tr height=\"18\"><td>&nbsp</td><td colspan=\"3\"><img src=\"images/rack/top.jpg\"></td><td>&nbsp</td></tr>");     
    for (int i=0;i<Integer.parseInt(NBU);i++) {
      boolean isfull=false;
      Statement st40 = Conn.createStatement();
      String q40 = "SELECT * FROM CMDB_SERVER WHERE RACKID='"+r30.getString("ID")+"' AND U='"+i+"'";
      ResultSet r40 = st40.executeQuery(q40);
      if (r40.next()) {
        String SERVERID=r40.getString("ID");
        String USIZE=r40.getString("USIZE");
        out.print("<tr height=\"18\"><td>"+i+"</td><td><img src=\"images/rack/left.jpg\"></td><td width=\"220\" rowspan=\""+Integer.parseInt(USIZE)+"\"><A HREF=\"serverdisp.jsp?TODO=MOD&ID="+r40.getString("ID")+"\"><img src=\"images/server/"+Integer.parseInt(USIZE)+"U.jpg\"></a></td><td><img src=\"images/rack/right.jpg\"></td><td rowspan=\""+Integer.parseInt(USIZE)+"\" width=\"500\" align=\"left\">"+SERVERID+"</td></tr>");     
        for (int ik=1;ik<Integer.parseInt(USIZE);ik++) {
          out.print("<tr height=\"18\"><td>"+(i+ik)+"</td><td><img src=\"images/rack/left.jpg\"></td><td><img src=\"images/rack/right.jpg\"></td><td>&nbsp</td></tr>");
        } 
        i=i+Integer.parseInt(USIZE)-1;
        isfull=true;
      } 
      st40.close();
      if(!isfull) {
        Statement st41 = Conn.createStatement();
        String q41 = "SELECT * FROM CMDB_SWITCH WHERE RACKID='"+r30.getString("ID")+"' AND U='"+i+"'";
        ResultSet r41 = st41.executeQuery(q41);
        if (r41.next()) {
          String SERVERID=r41.getString("ID");
          String USIZE=r41.getString("USIZE");
          out.print("<tr height=\"18\"><td>"+i+"</td><td><img src=\"images/rack/left.jpg\"></td><td width=\"220\" rowspan=\""+Integer.parseInt(USIZE)+"\"><A HREF=\"switchdisp.jsp?TODO=MOD&ID="+r41.getString("ID")+"\"><img src=\"images/switch/"+Integer.parseInt(USIZE)+"U.jpg\"></a></td><td><img src=\"images/rack/right.jpg\"></td><td rowspan=\""+Integer.parseInt(USIZE)+"\" width=\"500\" align=\"left\">"+SERVERID+"</td></tr>");     
          for (int ik=1;ik<Integer.parseInt(USIZE);ik++) {
            out.print("<tr height=\"18\"><td>"+(i+ik)+"</td><td><img src=\"images/rack/left.jpg\"></td><td><img src=\"images/rack/right.jpg\"></td><td>&nbsp</td></tr>");
          } 
          i=i+Integer.parseInt(USIZE)-1;
          isfull=true;
        } 
        st41.close();
      }
      if(!isfull) {
        Statement st41 = Conn.createStatement();
        String q41 = "SELECT * FROM CMDB_BACKUP WHERE RACKID='"+r30.getString("ID")+"' AND U='"+i+"'";
        ResultSet r41 = st41.executeQuery(q41);
        if (r41.next()) {
          String SERVERID=r41.getString("ID");
          String USIZE=r41.getString("USIZE");
          out.print("<tr height=\"18\"><td>"+i+"</td><td><img src=\"images/rack/left.jpg\"></td><td width=\"220\" rowspan=\""+Integer.parseInt(USIZE)+"\"><A HREF=\"backupdisp.jsp?TODO=NONE&ID="+r41.getString("ID")+"\"><img src=\"images/backup/"+Integer.parseInt(USIZE)+"U.jpg\"></a></td><td><img src=\"images/rack/right.jpg\"></td><td rowspan=\""+Integer.parseInt(USIZE)+"\" width=\"500\" align=\"left\">"+SERVERID+"</td></tr>");     
          for (int ik=1;ik<Integer.parseInt(USIZE);ik++) {
            out.print("<tr height=\"18\"><td>"+(i+ik)+"</td><td><img src=\"images/rack/left.jpg\"></td><td><img src=\"images/rack/right.jpg\"></td><td>&nbsp</td></tr>");
          } 
          i=i+Integer.parseInt(USIZE)-1;
          isfull=true;
        } 
        st41.close();
      }
      if(!isfull) {
        Statement st41 = Conn.createStatement();
        String q41 = "SELECT * FROM CMDB_OTHER WHERE RACKID='"+r30.getString("ID")+"' AND U='"+i+"'";
        ResultSet r41 = st41.executeQuery(q41);
        if (r41.next()) {
          String SERVERID=r41.getString("ID");
          String USIZE=r41.getString("USIZE");
          out.print("<tr height=\"18\"><td>"+i+"</td><td><img src=\"images/rack/left.jpg\"></td><td width=\"220\" rowspan=\""+Integer.parseInt(USIZE)+"\"><A HREF=\"otherdisp.jsp?TODO=NONE&ID="+r41.getString("ID")+"\"><img src=\"images/other/"+Integer.parseInt(USIZE)+"U.jpg\"></a></td><td><img src=\"images/rack/right.jpg\"></td><td rowspan=\""+Integer.parseInt(USIZE)+"\" width=\"500\" align=\"left\">"+SERVERID+"</td></tr>");     
          for (int ik=1;ik<Integer.parseInt(USIZE);ik++) {
            out.print("<tr height=\"18\"><td>"+(i+ik)+"</td><td><img src=\"images/rack/left.jpg\"></td><td><img src=\"images/rack/right.jpg\"></td><td>&nbsp</td></tr>");
          } 
          i=i+Integer.parseInt(USIZE)-1;
          isfull=true;
        } 
        st41.close();
      }
      if(!isfull) {
        Statement st41 = Conn.createStatement();
        String q41 = "SELECT * FROM CMDB_SAN WHERE RACKID='"+r30.getString("ID")+"' AND U='"+i+"'";
        ResultSet r41 = st41.executeQuery(q41);
        if (r41.next()) {
          String SERVERID=r41.getString("ID");
          String USIZE=r41.getString("USIZE");
          out.print("<tr height=\"18\"><td>"+i+"</td><td><img src=\"images/rack/left.jpg\"></td><td width=\"220\" rowspan=\""+Integer.parseInt(USIZE)+"\"><A HREF=\"sandisp.jsp?TODO=MOD&ID="+r41.getString("ID")+"\"><img src=\"images/san/"+Integer.parseInt(USIZE)+"U.jpg\"></a></td><td><img src=\"images/rack/right.jpg\"></td><td rowspan=\""+Integer.parseInt(USIZE)+"\" width=\"500\" align=\"left\">"+SERVERID+"</td></tr>");     
          for (int ik=1;ik<Integer.parseInt(USIZE);ik++) {
            out.print("<tr height=\"18\"><td>"+(i+ik)+"</td><td><img src=\"images/rack/left.jpg\"></td><td><img src=\"images/rack/right.jpg\"></td><td>&nbsp</td></tr>");
          } 
          i=i+Integer.parseInt(USIZE)-1;
          isfull=true;
        } 
        st41.close();
      }
      if(!isfull) {
        out.print("<tr><td>"+i+"</td><td><img src=\"images/rack/left.jpg\"></td><td  width=\"220\" bgcolor=\"#000000\"><img src=\"images/rack/fond.jpg\"></td><td><img src=\"images/rack/right.jpg\"></td><td>&nbsp</td></tr>");
      }
    } 
    out.print("<tr height=\"18\"><td>&nbsp</td><td colspan=\"3\"><img src=\"images/rack/bottom.jpg\"></td><td>&nbsp</td></tr>");     
    out.print("</table></center>");
    out.print("</td>");
  }
  st30.close();
  out.print("</tr></table>");
  out.print("<br><center><A HREF=\"#\" onclick=\"window.close();\">close</A></center>");
  Conn.close();
}
%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
