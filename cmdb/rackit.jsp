
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
  String VENDORID="NONE";
  PPPMTools pt = new PPPMTools();
  boolean isthereaction=false;
  
  if (act.equals("ADDCLOSE")) {
    DESCRIPTION = pt.checkStr(request.getParameter("DESCRIPTION"));
    ROOMID = pt.checkStr(request.getParameter("ROOMID"));
    NBU = pt.checkStr(request.getParameter("NBU"));
    String VENDORIDtmp = pt.checkStr(request.getParameter("VENDORID"));
    VENDORID="NONE";
    if (!VENDORIDtmp.equals("NONE")) {
      VENDORID = VENDORIDtmp.substring(0,VENDORIDtmp.indexOf("-")-1);
    }
    Statement sti2 = Conn.createStatement();
    String i2 = "INSERT INTO CMDB_RACK VALUES('"+ID+"','"+DESCRIPTION+"','"+ROOMID+"','"+NBU+"','"+VENDORID+"')";
    sti2.executeUpdate(i2);
    sti2.close();    		
	out.print("<script language=\"JavaScript\">");
	out.print("window.close();"); 
    out.print("</script");  	
    isthereaction=true;
  }
  if (act.equals("MODCLOSE")) {
    DESCRIPTION = pt.checkStr(request.getParameter("DESCRIPTION"));
    ROOMID = pt.checkStr(request.getParameter("ROOMID"));
    NBU = pt.checkStr(request.getParameter("NBU"));
    String VENDORIDtmp = pt.checkStr(request.getParameter("VENDORID"));
    VENDORID="NONE";
    if (!VENDORIDtmp.equals("NONE")) {
      VENDORID = VENDORIDtmp.substring(0,VENDORIDtmp.indexOf("-")-1);
    }
    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_RACK SET DESCRIPTION='"+DESCRIPTION+"',ROOMID='"+ROOMID+"',NBU='"+NBU+"',VENDORID='"+VENDORID+"' WHERE ID='"+ID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
	out.print("<script language=\"JavaScript\">");
	out.print("window.close();"); 
    out.print("</script");  	
    isthereaction=true;
  }
  
  if (!isthereaction) {  
    if (act.equals("NEW")) {
      out.print("<center><strong><h1>New rack</h1></strong></center><hr>");
      out.print("<form name=\"formFILTER\" method=\"post\" action=\"rackit.jsp?TODO=ADDCLOSE\" target=\"_top\">");
    } else {
      out.print("<center><strong><h1>Modify rack</h1></strong></center><hr>");
      out.print("<form name=\"formFILTER\" method=\"post\" action=\"rackit.jsp?TODO=MODCLOSE&ID="+ID+"\" target=\"_top\">");
      Statement st30 = Conn.createStatement();
      String q30 = "SELECT * FROM CMDB_RACK WHERE ID='"+ID+"'";
      ResultSet r30 = st30.executeQuery(q30);
      if (r30.next()) {
        DESCRIPTION=r30.getString("DESCRIPTION");
        ROOMID=r30.getString("ROOMID");
        NBU=r30.getString("NBU");
        VENDORID=r30.getString("VENDORID");
      }
      st30.close();
    } 
    out.print("<table>");
    if (act.equals("NEW")) {
      out.print("<tr><td>Name of the rack : </td><td><input name=\"ID\" type=\"text\" size=\"50\" value=\""+ID+"\"></td></tr>");
    } else {
      out.print("<tr><td>Name of the rack : </td><td>"+ID+"</td></tr>");
    }
    out.print("<tr><td>Description of the rack : </td><td><textarea name=\"DESCRIPTION\" cols=\"80\" rows=\"25\" value=\"\">"+DESCRIPTION+"</textarea></td></tr>");
    out.print("<tr><td># of U : </td><td><input name=\"NBU\" type=\"text\" size=\"50\" value=\""+NBU+"\"></td></tr>");
    out.print("<tr><td>Room of the rack : </td><td><select name=\"ROOMID\">");
    Statement st20 = Conn.createStatement();
    String q20 = "SELECT * FROM CMDB_ROOM";
    ResultSet r20 = st20.executeQuery(q20);
    while(r20.next()) {
      out.print("<option");
      if (ROOMID.equals(r20.getString("ID"))) {
        out.print(" selected ");
      }
      out.print(">"+r20.getString("ID")+"</option>");
    }
    st20.close();
    out.print("</select></td></tr>");
    out.print("<tr><td>Vendor : </td><td><select name=\"VENDORID\">");
    out.print("<option");
    if (VENDORID.equals("NONE")) {
      out.print(" selected ");
    }
    out.print(">NONE</option>");
    Statement st400 = Conn.createStatement();
    String q400 = "SELECT * FROM VENDOR";
    ResultSet r400 = st400.executeQuery(q400);
    while(r400.next()) {
      out.print("<option");
      if (VENDORID.equals(r400.getString("ID"))) {
        out.print(" selected");
      }
      out.print(">"+r400.getString("ID")+" - "+r400.getString("NAME")+"</option>");
    }
    st400.close();
    out.print("</select></td></tr>"); 
    if (act.equals("NEW")) {
      out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/add.png\" type=image Value=submit></td>");
      out.print("<td><A HREF=\"#\" onclick=\"window.close();\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
    } else {  
      out.print("<table><tr><td>&nbsp;</td><td><INPUT border=0 src=\"icons/modify.png\" type=image Value=submit></td>");
      out.print("<td><A HREF=\"#\" onclick=\"window.close();\"><img border=0 src=\"icons/cancel.png\"></A></td></tr></table>");
    }
    out.print("</table>");
    out.print("</form>");
  }
  Conn.close();
}
%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
