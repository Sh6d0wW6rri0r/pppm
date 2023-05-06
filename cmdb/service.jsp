
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
    String NAME = request.getParameter("NAME");
    String DESCRIPTION = request.getParameter("DESCRIPTION");
    String VENDORIDtmp = pt.checkStr(request.getParameter("VENDORID"));
    String VENDORID="NONE";
    if (!VENDORIDtmp.equals("NONE")) {
      VENDORID = VENDORIDtmp.substring(0,VENDORIDtmp.indexOf("-")-1);
    }

    Statement sti2 = Conn.createStatement();
    Statement st10 = Conn.createStatement();
    String q10 = "SELECT * FROM INDX WHERE ID='SERVICE'";
    ResultSet r10 = st10.executeQuery(q10);
    r10.next();
    int idnum=r10.getInt("SEQ");
    int newidnum=idnum+1;
    st10.close();
    Statement sti10 = Conn.createStatement();
    String i10 = "UPDATE INDX SET SEQ="+newidnum+" WHERE ID='SERVICE'";
    sti10.executeUpdate(i10);
    sti10.close();
    
    String idfill="";
    String idtmp = ""+idnum;
    for (int j =0; j<7-idtmp.length();j++) {
      idfill=idfill+"0";
    }
    idfill=idfill+idtmp;

    String i2 = "INSERT INTO CMDB_SERVICE VALUES ('"+idfill+"','"+pt.checkStr(NAME)+"','"+pt.checkStr(DESCRIPTION)+"','"+VENDORID+"')";
    sti2.executeUpdate(i2);
    sti2.close();
  } 

  if (act.equals("MOD")) {
    String NAME = request.getParameter("NAME");
    String DESCRIPTION = request.getParameter("DESCRIPTION");
    String VENDORIDtmp = pt.checkStr(request.getParameter("VENDORID"));
    String VENDORID="NONE";
    if (!VENDORIDtmp.equals("NONE")) {
      VENDORID = VENDORIDtmp.substring(0,VENDORIDtmp.indexOf("-")-1);
    }

    Statement sti2 = Conn.createStatement();
    String i2 = "UPDATE CMDB_SERVICE SET NAME='"+pt.checkStr(NAME)+"',VENDORID='"+VENDORID+"',DESCRIPTION='"+pt.checkStr(DESCRIPTION)+"' WHERE ID='"+ID+"'";
    sti2.executeUpdate(i2);
    sti2.close();
  }

    out.print("<center><strong><h1>Services list</h1></strong></center><hr>");


    out.print("<table border=\"0\" CELLSPACING=\"2\" BORDERCOLOR=\"#000000\" width=\"100%\">");
    out.print("<tr BGCOLOR=\"#9A9A9A\">");
    out.print("<td background=\"images/fond_titre.jpg\"><center>NAME</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>DESCRIPTION</center></td>");
    out.print("<td background=\"images/fond_titre.jpg\"><center>VENDOR</center></td>");  
    out.print("</tr>");
    Statement st30 = Conn.createStatement();
    String q30 = "SELECT * FROM CMDB_SERVICE ORDER BY ID";
    ResultSet r30 = st30.executeQuery(q30);
    while(r30.next()) {
      out.print("<tr>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp<A HREF=\"serviceit.jsp?TODO=MOD&ID="+r30.getString("ID")+"\">"+r30.getString("NAME")+"</center></A></td>");
      out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r30.getString("DESCRIPTION")+"</center></td>");
      Statement st31 = Conn.createStatement();
      String q31 = "SELECT * FROM VENDOR WHERE ID='"+r30.getString("VENDORID")+"'";
      ResultSet r31 = st31.executeQuery(q31);
      if(r31.next()) {
        out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp"+r31.getString("NAME")+"</center></td>");        
      } else {
        out.print("<td bgcolor=\"#FFFFFF\"><center>&nbsp</center></td>");
      }
      st31.close();
      out.print("</tr>");
    }
    st30.close();
    out.print("</table>");
    out.print("</form>");
    out.print("<form name=\"formFILTER\" method=\"post\" action=\"serviceit.jsp?TODO=NEW\" target=\"appliFrame\">");
    out.print("<center><input type=\"submit\" name=\"Save\" value=\"Add\"></center>");
    out.print("</form>");

%>
<div align="center"></div>
<div align="center"></div>

</body>

</html>
